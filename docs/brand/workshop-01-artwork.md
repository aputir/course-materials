# First workshop cover artwork

- Asset: `resources/assets/illustrations/workshop-01-shared-light-print.png` (1536 × 1024 PNG).
- Generated with the built-in ImageGen tool on 2026-10-08; no CLI/API fallback. A second ImageGen call tightened the framing and requested a flatter white background while preserving the sketch.
- Reference: the supplied APUT visual board was inspected; its motifs were described in the prompt. No reference image was passed to the generator.
- Intent: a minimal pen sketch of a keeper and AI companion sharing lantern light, with a small orbital lighthouse as the brand cue.
- Quote: “AI knows as much as you know.” The user confirmed this wording. It is now authored once in `src/course/workshop-reflection.typ`; the illustration contains no lettering.
- Placement and type: `cover-vignette`, `quote-frame`, and `workshop-closing` in `src/course/theme.typ` own the image sizes, spacing, thin navy frame, double quotation marks, Lora Italic treatment, and LTR direction. `course-workshop` automatically uses the same quote/artwork on the cover and dedicated closing page of every workshop. The closing image is larger; the English story, prompts, and invitation come from the shared content module. The entire closing reflection uses English LTR Lora, as required by [the editorial brief](workshop-reflection-editorial.md). Generic covers still use optional `cover-artwork`.
- Original supplied board and text are preserved at the paths listed in [the brand guide](README.md).

## Initial generation prompt

```text
Use case: illustration-story
Asset type: a small, impressive editorial vignette centered in the lower half of a Persian university programming workshop cover.
Primary request: an extremely minimal, fun, cool hand-drawn black ink sketch inspired by the thought "AI knows as much as you know." Do not put any lettering in the image; the quote will be typeset beneath it.
Brand context: APUT's supplied visual board is "The Lighthouse at the Edge of the Drift": calm, curious, tactile, luminous. It depicts a rounded lighthouse with an orbital ring around its lantern, a young keeper in a coat and scarf carrying a lantern, and a small round harbor ship. Translate that maritime/space vocabulary into flat pen line art for this monochrome print variant.
Scene and subject: one tiny young curious keeper with a scarf stands beside an adorably simple rounded AI companion with two dot eyes on a short dock. The keeper holds a small lantern; both look into the SAME restrained triangular cone of light from it, which reveals a tiny four-point star. The shared light is the metaphor for the knowledge the learner brings. Behind them, just one small lighthouse outline with a single orbital ring echoes the brand.
Style/medium: spontaneous handwritten notebook doodle, sophisticated sparse black felt-tip/fineliner strokes, subtle natural line wobble, charming gesture, simple silhouettes, almost no shading. A few expressive strokes must carry the idea. Main body should read as an authentic hand-drawn sketch, never a glossy render.
Composition: wide compact vignette, approximately 3:2 landscape canvas, characters near center, lighthouse secondary and small, complete silhouettes with generous margins, much pure white negative space, all artwork contained in the central 75 percent. Clear silhouette readable at 100mm wide.
Color: strictly black ink on pure white (#FFFFFF) opaque background. No gray wash, no paper texture, no color, no gradients, no photorealism, no 3D.
Constraints: no text, no quote, no logos, no border, no watermark, no elaborate harbor or scenery, no decorative clutter, no dense hatching. The lantern beam is a thin outline only with white interior. Keep it extremely minimal and cool.
```

## Final refinement prompt

```text
Edit this generated cover sketch. Preserve the same keeper, friendly rounded AI companion, lantern beam, single star, small orbital lighthouse, dock, poses and sparse hand-drawn black pen style. Change only the background and framing: make EVERY blank area a perfectly flat opaque pure white (#FFFFFF), removing ALL paper grain, noise, gray haze, shadows, tonal wash or vignette. It must blend invisibly into a pure-white printed page. Keep black strokes crisp. Frame the existing drawing slightly more tightly in a wide approximately 3:2 landscape image, so the complete drawing occupies about 80 percent of the width and 70 percent of the height, centered vertically with balanced white margins. Do not cut any existing part of the drawing. No new objects, lettering, quote, logos, borders or watermark. Strictly black ink and pure white only, with antialiased stroke edges.
```
