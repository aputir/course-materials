# APUT visual identity

The supplied visual direction is **The Lighthouse at the Edge of the Drift**. Its core idea is “learning brings light to the harbor”: learning makes the surroundings more understandable and navigable. The personality is calm, curious, tactile, and luminous.

## Sources and asset organization

- [Original visual board](../../resources/assets/brand/reference/visual-system-direction-01.jpg): the supplied `brand/brand.jpg`, moved without modification.
- [Original design notes](references/direction-01-source.txt): the supplied `brand/text.txt`, retained verbatim, including its source timestamps. Its two `Table` placeholders have no accompanying data; the palette and visual tokens below are transcribed from the board.
- [Workshop cover sketch](../../resources/assets/illustrations/workshop-01-shared-light-print.png): generated specifically for the first workshop, using the monochrome adaptation below.
- [Generation brief and final prompt](workshop-01-artwork.md): provenance and instructions for the sketch.

Brand references live in `resources/assets/brand/reference/`; finished document illustrations live in `resources/assets/illustrations/`. Brand documentation and original written references live here. Institutional logos remain separate in `resources/assets/logos/`.

## World and visual vocabulary

The lighthouse is the main reference landmark. Its lantern and orbital rings connect the harbor and space themes. The young keeper carries a lantern, representing curiosity and guidance. A rounded ship and collectible optical objects extend this world.

Use Persian descriptive names in course prose: «فانوس‌بان», «کشتی بندر», and «نشان عدسی». The original proposed product terms are retained here for reference:

| Source name | Role | Persian description |
| --- | --- | --- |
| Lumens | XP and accumulated progress | نورِ پیشرفت |
| Lenses | Achievement badges | نشان‌های عدسی |
| Star Chart | Leaderboard and navigation | نقشهٔ ستارگان |
| Ship’s Log | Assignment narrative opening | دفتر سفر |

These are proposed vocabulary, not requirements to add features to course documents.

## Color direction

| Token | Board target | Use |
| --- | --- | --- |
| Midnight | `#132B46` | Deep background and chapter openings |
| Ocean | `#275F70` | Cool environment |
| Sea glass | `#90BFB9` | Quiet supporting color |
| Beacon | `#F0C77B` | Concentrated, meaningful accents |
| Ivory | `#ECE5D7` | Teaching-slide background direction |
| Mist | `#B7B4CD` | Soft supporting color |

Lighting and material shading may vary these targets within illustrations. Keep amber concentrated around the idea students should notice first. This board is a creative reference, not an official University of Tehran identity manual. `src/course/theme.typ` remains the source of the current document colors, typography, spacing, and cover hierarchy; the workshop revision does not replace its palette.

## Original illustration treatment

- Medium: sculpted 3D, with a muted, gentle contrast.
- Materials: ceramic, brass, and frosted glass, with subtle grain.
- Shapes: rounded, modular, simple, and readable.
- Light: soft upper-left key light; warm points of attention in a cool setting.
- Composition: one focal point and open space; near-orthographic three-quarter view.

For the original 3D family, keep medium, materials, lighting, and shape language consistent. Subjects, actions, and settings can vary; palette accents and approved views stay bounded.

## Monochrome document adaptation

The first workshop explicitly uses a different medium: sparse, naturally uneven black pen strokes on an opaque white background. Keep the world's lighthouse, keeper, lantern, orbital motif, rounded shapes, quiet curiosity, and ample open space. Remove color, glossy materials, gradients, elaborate scenery, and dense shading. This is a documented print adaptation, not a replacement for the original 3D direction.

The keeper and a small rounded AI companion share the lantern's field of light. A single star makes the idea visible: the learner's knowledge guides what they can recognize and assess together. This is an illustration of the quote, rather than a literal technical claim about a model's stored knowledge.

Use the artwork as a centered lower-cover vignette and repeat it at a larger size on the workshop's closing page. Keep the English quote as editable, explicitly LTR Lora Italic text in double quotation marks inside a simple thin frame, outside the raster image. `course-workshop` supplies this composition automatically; `src/course/workshop-reflection.typ` is the single source for the quote, artwork path, story, prompt comparison, and invitation. The entire closing reflection is English LTR Lora; see [the editorial brief](workshop-reflection-editorial.md) for future workshops. The cover still has one unmodified UT seal and no Engineering logo. Do not add brand lettering or a second logo to the sketch.
