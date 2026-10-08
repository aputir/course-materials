#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd -- "$(dirname -- "$0")/.." && pwd)"
temporary_root=""
cleanup() {
  if [[ -n "$temporary_root" && -d "$temporary_root" ]]; then
    rm -rf -- "$temporary_root"
  fi
}
trap cleanup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

command -v zip >/dev/null 2>&1 || {
  printf 'Error: zip is required to create the template archive.\n' >&2
  exit 1
}

pdf_names=(
  handout-template
  homework-template
  hw1
  project-phase-template
  slides-template
  typography-proof
  workshop-01
  workshop-notes-template
)
for name in "${pdf_names[@]}"; do
  if [[ ! -s "$project_root/output/pdf/$name.pdf" ]]; then
    printf 'Error: missing built PDF: output/pdf/%s.pdf\n' "$name" >&2
    printf 'Build the documents first with ./scripts/build.sh all.\n' >&2
    exit 1
  fi
done

mkdir -p "$project_root/tmp"
temporary_root="$(mktemp -d "$project_root/tmp/package.XXXXXX")"
package_root="$temporary_root/ut-course-documents"
mkdir -p "$package_root/docs" "$package_root/scripts" "$package_root/output/pdf"

cp "$project_root/AGENTS.md" "$project_root/README.md" "$package_root/"
cp -R "$project_root/src" "$project_root/resources" "$package_root/"
# Exclude maintainer-local story work even when packaging from a full checkout.
rm -f "$package_root/src/documents/evolution-ai-story.typ"
rm -rf "$package_root/resources/assets/evolution-ai-story" \
  "$package_root/resources/assets/evolution-story"
cp "$project_root/scripts/build.sh" "$project_root/scripts/package.sh" "$project_root/scripts/compress-pdf.swift" "$package_root/scripts/"
cp "$project_root/docs/document-style-guide.md" \
  "$project_root/docs/technical-decisions.md" \
  "$project_root/docs/template-review.md" \
  "$project_root/docs/verification.md" \
  "$package_root/docs/"
cp -R "$project_root/docs/brand" "$package_root/docs/"
for name in "${pdf_names[@]}"; do
  cp "$project_root/output/pdf/$name.pdf" "$package_root/output/pdf/"
done

(cd "$temporary_root" && zip -X -r -q "$temporary_root/ut-course-template.zip" \
  ut-course-documents -x '*/.DS_Store' '*/._*' '*/__MACOSX/*')
mkdir -p "$project_root/output"
mv -f "$temporary_root/ut-course-template.zip" "$project_root/output/ut-course-template.zip"
printf 'Packaged output/ut-course-template.zip\n'
