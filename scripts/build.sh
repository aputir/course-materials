#!/usr/bin/env bash
set -euo pipefail
project_root="$(cd -- "$(dirname -- "$0")/.." && pwd)"
mkdir -p "$project_root/output/pdf"
build_one() {
  typst compile --root "$project_root" --ignore-system-fonts \
    --font-path "$project_root/assets/fonts" \
    "$project_root/$1" "$project_root/output/pdf/$2.pdf"
  printf 'Built %s.pdf\n' "$2"
}
case "${1:-all}" in
  all)
    build_one documents/hw1.typ hw1
    build_one templates/homework.typ homework-template
    build_one templates/workshop-notes.typ workshop-notes-template
    build_one templates/project-phase.typ project-phase-template
    build_one templates/handout.typ handout-template
    build_one examples/typography.typ typography-proof
    ;;
  hw1) build_one documents/hw1.typ hw1 ;;
  homework) build_one templates/homework.typ homework-template ;;
  workshop-notes) build_one templates/workshop-notes.typ workshop-notes-template ;;
  project-phase) build_one templates/project-phase.typ project-phase-template ;;
  handout) build_one templates/handout.typ handout-template ;;
  typography) build_one examples/typography.typ typography-proof ;;
  *) printf 'Usage: %s [all|hw1|homework|workshop-notes|project-phase|handout|typography]\n' "$0" >&2; exit 2 ;;
esac
