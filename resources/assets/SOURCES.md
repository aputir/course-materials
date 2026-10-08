# Asset sources

## APUT brand and workshop artwork

`brand/reference/visual-system-direction-01.jpg` is the supplied root `brand/brand.jpg`, moved without modification. Its original written notes are preserved verbatim in `docs/brand/references/direction-01-source.txt` (formerly `brand/text.txt`). The board and notes describe the proposed APUT harbor/lighthouse visual direction. The guide in `docs/brand/README.md` records the board's tokens and distinguishes the original 3D treatment from the requested monochrome print adaptation.

`illustrations/workshop-01-shared-light-print.png` is a 1536 × 1024 PNG generated with the built-in ImageGen tool for the first workshop on 2026-10-08. It is a black-ink sketch of a keeper and rounded AI companion sharing lantern light, with an orbital lighthouse. The initial generation used the board's observed motifs in a text prompt; the final refinement used the generated sketch as its edit reference. Both prompts are recorded in `docs/brand/workshop-01-artwork.md`. The supplied reference board was not edited. The quote is separately typeset in Typst and is not part of the image.

## Institutional marks

`logos/ut-source.png` is the only mark rendered in current documents. It is an unmodified 554 × 554 PNG extracted from `references/HW1/Advanced Algorithms, Homework 0x04 (4).docx` (`word/media/image1.png`). At the 32 mm cover width it provides approximately 440 pixels per inch. Its original colors and aspect ratio are retained.

`logos/engineering-source.png` (447 × 447, `word/media/image2.png`) is retained only as a reference asset. The user's later instruction removed it from all templates and compiled documents; the theme does not load it.

Online searches included the official University of Tehran and College of Engineering sites. The university site's image link was `https://ut.ac.ir/assets/5c006a29/images/logos/loading-logo.png`, but a direct download returned an HTML challenge response instead of PNG data. No suitable official Engineering SVG/PNG download was verified. The supplied document's exact UT seal was therefore chosen over third-party redraws. The reference URL is retained for provenance, not used as a runtime dependency.

Institutional marks remain the property of their respective institutions. No new license or official endorsement is implied by this course template.

## Vazirmatn

- Version: 33.003
- Files: `fonts/vazirmatn/Vazirmatn-Regular.ttf`, `Vazirmatn-Bold.ttf`
- Source: <https://github.com/rastikerdar/vazirmatn/tree/v33.003/fonts/ttf>
- License: SIL Open Font License 1.1; exact license text is `fonts/vazirmatn/OFL.txt`.
- Author: Saber Rastikerdar and the Vazirmatn Project authors.

Vazirmatn provides Persian/Arabic shaping. English prose is now assigned to Lora; Vazirmatn remains the fallback for Persian glyphs.

## Lora

- Version: 3.021 (confirmed in all four TTF name tables).
- Files: `fonts/lora/Lora-Regular.ttf`, `Lora-Bold.ttf`, `Lora-Italic.ttf`, and `Lora-BoldItalic.ttf`.
- Upstream: [Cyreal's Lora repository](https://github.com/cyrealtype/Lora-Cyrillic).
- Pinned source: [commit `2d53b449b60e185b39f671b44fded83e0910ad30`](https://github.com/cyrealtype/Lora-Cyrillic/tree/2d53b449b60e185b39f671b44fded83e0910ad30/fonts/ttf). These are unchanged static TTFs, not locally generated instances.
- License: SIL Open Font License 1.1, retained verbatim in `fonts/lora/OFL.txt` from the same commit.
- Authors: Olga Karpushina, Alexei Vanyashin, and the Lora Project contributors; exact copyright and reserved-font-name text are in the license.

The shared theme uses Lora for all English prose, English names/concepts, Latin numbers, and quotes in editable documents and slides. The base fallback stack is Lora followed by Vazirmatn, so unwrapped Latin glyphs also receive Lora. Semantic `en`/`english` helpers still supply correct LTR layout. Code stays JetBrains Mono and mathematics stays New Computer Modern Math.

## JetBrains Mono

- Version: 2.304
- File: `fonts/jetbrains-mono/JetBrainsMono-Regular.ttf`
- Source: <https://github.com/JetBrains/JetBrainsMono/tree/v2.304/fonts/ttf>
- License: SIL Open Font License 1.1; exact license text is `fonts/jetbrains-mono/OFL.txt`.

## Mathematics

New Computer Modern Math is embedded in Typst 0.15.1 and is used by the theme. It requires no separate download. Builds ignore system fonts to avoid accidental substitutions.

## Story illustrations

The 43 PNG files in the maintainer-local `evolution-ai-story/` folder accompany the local narration script. They are supplied workspace assets, retained without edits. The image-only presentation uses them in numbered filename order at their original 1672 × 940 or 1672 × 941 resolution. These files and the editable presentation are excluded from Git and the portable source archive. No new external artwork was sourced for this presentation.

The eight earlier illustrations in the maintainer-local `evolution-story/` folder are retained as original reference assets. They are also excluded from Git and the portable source archive.
