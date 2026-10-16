#!/usr/bin/env bash
# The Nix expressions below are text with literal quotes
# shellcheck disable=SC2089,SC2090
# Compares the services in the topology between upstream main (or the given ref)
# and the working tree, for every service def's test configs.
# Usage: dev/compare-with-main.sh [ref]
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
JOBS="${JOBS:-$(nproc)}"
OUT="$(mktemp -d)"
trap 'rm -rf "$OUT"' EXIT

if [[ $# -gt 0 ]]; then
  base="$(git -C "$REPO" rev-parse "$1")"
else
  git -C "$REPO" fetch --quiet https://github.com/oddlama/nix-topology main
  base="$(git -C "$REPO" merge-base HEAD FETCH_HEAD)"
fi
echo "Comparing the working tree against $(git -C "$REPO" log -1 --format='%h %s' "$base")"

mkdir "$OUT/src" "$OUT/old" "$OUT/new"
git -C "$REPO" archive "$base" | tar -x -C "$OUT/src"

# Nix expressions, passed as text to `nix eval --expr`
compare="import $REPO/dev/compare-with-main.nix {
  pkgs = import (builtins.getFlake \"path:$REPO/dev\").inputs.nixpkgs { };
}"
old_src="$OUT/src"
new_src="builtins.path {
  path = $REPO;
  name = \"source\";
  filter = p: _: baseNameOf p != \".git\" && baseNameOf p != \"result\";
}"
export compare old_src new_src OUT

nix eval --impure --json --expr "($compare).caseNames" | jq -r '.[]' >"$OUT/cases"
echo "Evaluating $(wc -l <"$OUT/cases") cases with $JOBS jobs..."

# Each side in its own process, so an evaluation error on one side doesn't hide the other
# shellcheck disable=SC2016
for side in old new; do
  sed "s/^/$side /" "$OUT/cases"
done | xargs -P "$JOBS" -L1 bash -c '
  side=$0 case=$1 src_var=${0}_src
  if ! nix eval --impure --json --expr "($compare).servicesOf (${!src_var}) \"$case\"" \
    >"$OUT/$side/$case.json" 2>"$OUT/$side/$case.err"; then
    grep "error:" "$OUT/$side/$case.err" | tail -1 | sed "s/^ *error: //" | jq -R "{error: .}" >"$OUT/$side/$case.json"
  fi
'

differences=0
while read -r case; do
  diff=$(jq -n --arg case "$case" --slurpfile old "$OUT/old/$case.json" --slurpfile new "$OUT/new/$case.json" '
    $old[0] as $o | $new[0] as $n
    | if ($o | has("error")) or ($n | has("error")) then
        if $o == $n then empty else {case: $case, old: $o, new: $n} end
      else
        [($o + $n) | keys[] as $id
         | if ($o[$id] == null) or ($n[$id] == null) then {($id): {old: $o[$id], new: $n[$id]}}
           else [$o[$id] | keys[] as $f | select($o[$id][$f] != $n[$id][$f])
                 | {($f): {old: $o[$id][$f], new: $n[$id][$f]}}]
                | add // {} | if . == {} then empty else {($id): .} end
           end]
        | add // {} | if . == {} then empty else {case: $case, services: .} end
      end')
  if [[ -n "$diff" ]]; then
    differences=$((differences + 1))
    echo "$diff"
  fi
done <"$OUT/cases"

if [[ "$differences" -eq 0 ]]; then
  echo "All cases produce the same services."
else
  echo "$differences case(s) differ."
  exit 1
fi
