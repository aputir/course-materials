#!/usr/bin/env bash
set -euo pipefail
project_root="$(cd -- "$(dirname -- "$0")/.." && pwd)"
mkdir -p "$project_root/output/pdf"
# One registry owns selectors, entry sources, and output names.
build_entries=(
  'hw1|src/documents/hw1.typ|hw1'
  'workshop-01|src/documents/workshop-01.typ|workshop-01'
  'homework|src/templates/homework.typ|homework-template'
  'workshop-notes|src/templates/workshop-notes.typ|workshop-notes-template'
  'project-phase|src/templates/project-phase.typ|project-phase-template'
  'handout|src/templates/handout.typ|handout-template'
  'typography|src/examples/typography.typ|typography-proof'
  'slides|src/templates/slides.typ|slides-template'
)
# This presentation is maintainer-local work and is not present in source clones.
if [[ -f "$project_root/src/documents/evolution-ai-story.typ" ]]; then
  build_entries+=(
    'evolution-ai-story|src/documents/evolution-ai-story.typ|evolution-ai-story'
  )
fi
requested_entry="${1:-all}"
built_any=0
for entry in "${build_entries[@]}"; do
  IFS='|' read -r entry_key entry_source entry_output <<< "$entry"
  if [[ "$requested_entry" == all || "$requested_entry" == "$entry_key" ]]; then
    typst compile --root "$project_root" --ignore-system-fonts \
      --font-path "$project_root/resources/assets/fonts" \
      "$project_root/$entry_source" "$project_root/output/pdf/$entry_output.pdf"
    printf 'Built %s.pdf\n' "$entry_output"
    built_any=1
  fi
done
if [[ "$built_any" == 0 ]]; then
  printf 'Usage: %s [all' "$0" >&2
  for entry in "${build_entries[@]}"; do
    printf '|%s' "${entry%%|*}" >&2
  done
  printf ']\n' >&2
  exit 2
fi
