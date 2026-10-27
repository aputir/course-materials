# Breakout Phase 01 Pages 3–7 Polish Implementation Plan

> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Polish and restructure pages 3 to 7 (and general styling across all pages) of `course-materials/src/documents/breakout-phase-01.typ`: remove teamwork (solo project), convert rules table to headings/paragraphs, expand line-height and list spacing in template, structure bullet lists on page 5, replace .gitignore with "گیت ایگنور", reference GitHub & Conventional Commits, modernize Page 6 architecture with an engaging storytelling hook and vertical MVC cards, convert Page 7 entities to visual cards with an inline Typst vector geometry diagram, shorten all headings, eliminate `ئ` on words ending in `ه`, and ensure strict 1-page-per-section adherence.

**Architecture:** 
1. Upgrade `spacing.line` and list rhythm in `theme.typ` and `breakout-phase-01.typ` for professional Persian readability.
2. Rewrite `rules.typ` (Page 3) as clean semantic blocks/headings without teamwork.
3. Polish `before-phase1.typ` (Page 5) with structured key-value visual cards and Git/Conventional Commits standards.
4. Rewrite `architecture.typ` (Page 6) with an Instagram-quality storytelling hook, vertical MVC cards, and clear data-flow.
5. Transform `entities.typ` (Page 7) into 4 modular entity cards and a pure Typst vector graphics playfield schematic illustrating dimensions and coordinates.
6. Conduct a global orthography and tone sweep across all breakout pages to enforce plain `ه` (no `ئ`) and friendly tone.

**Tech Stack:** Typst 0.15.1, `course-materials/scripts/build.sh`, poppler (`pdftoppm`, `pdfinfo`).

## Global Constraints

- Persian-first prose; technical identifiers, code, and types remain in English (`en`, `code-inline`, `code-block`).
- Orthography: No `ئ` on words ending with `ه` across ALL pages (e.g., `پوسته بوم` instead of `پوستهٔ بوم`, `هسته بازی` instead of `هستهٔ بازی`, `لایه مدل` instead of `لایهٔ مدل`).
- Tone: Warm, friendly, encouraging, modern storytelling hooks. No dry academic clichés or starting with "common errors".
- Solo project: All references to teams, teammates, or group members removed.
- Strict 1-page-per-section budget: Each page module must fit its single page cleanly without causing overflow or extra pages. Exactly 12 total pages in `output/pdf/breakout-phase-01.pdf`.
- Headings: Short, direct, punchy titles.
- Build verification: Run `./course-materials/scripts/build.sh breakout-phase-01` after each task and inspect page count and layout with `pdfinfo` and `pdftoppm`.

---

### Task 1: Typography, Line-Height & List Spacing Overhaul

**Files:**
- Modify: `course-materials/src/course/theme.typ`
- Modify: `course-materials/src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst paragraph, list, and heading layout rules.
- Produces: Professional line leading (`7pt`), comfortable paragraph spacing (`7.5pt`), and airy bullet lists (`spacing: 8pt`).

- [ ] **Step 1: Update spacing values in `src/course/theme.typ`**
  - Increase `spacing.line` from `4pt` to `6.5pt`.
  - Increase `spacing.paragraph` from `5pt` to `7pt`.
  - Increase `spacing.item` from `5pt` to `8pt`.
  - Ensure `set list(spacing: 8pt)` gives bullet lists proper vertical room.

- [ ] **Step 2: Update paragraph configuration in `breakout-phase-01.typ`**
  - Set `par(justify: true, leading: 6.5pt, spacing: 7.5pt)`.
  - Ensure title and metadata also adhere to no-`ئ` rule (`هسته بازی Breakout`).

- [ ] **Step 3: Test compilation across all templates**
  - Run `./course-materials/scripts/build.sh` to confirm no unintended regressions across other course documents.

---

### Task 2: Page 3 — Rules & Academic Ethics (Solo Project & Headings/Paragraphs)

**Files:**
- Modify: `course-materials/src/documents/breakout/rules.typ`

**Interfaces:**
- Consumes: `theme.typ` components (`block`, `colors`, `spacing`, `note`).
- Produces: `breakout-rules-page()` without table, without teamwork, in friendly tone.

- [ ] **Step 1: Replace table with structured semantic headings and paragraphs**
  - Short title: `= قوانین و شرایط تحویل`
  - Solo project emphasis: clarify development is strictly individual.
  - Section headings:
    - `== استقلال در پیاده‌سازی` (Originality and self-reliance)
    - `== ثبت منظم در گیت‌هاب` (Atomic commits, individual contribution)
    - `== گفت‌وگوی فنی حضوری` (Personal defense session)
    - `== بستر تحویل و زمان‌بندی` (Ilearn and GitHub repo)
    - `== دستیار هوش مصنوعی` (Educational aid, but you must own every line)
  - Replace `هٔ` with plain `ه` throughout the text.
  - Ensure warm, encouraging tone in the closing assistant note.

- [ ] **Step 2: Build and verify Page 3**
  - Run `./course-materials/scripts/build.sh breakout-phase-01`
  - Render page 3 with `pdftoppm` and verify it fits exactly on page 3.

---

### Task 3: Page 4 — Introduction & Educational Goals Polish

**Files:**
- Modify: `course-materials/src/documents/breakout/introduction.typ`

**Interfaces:**
- Consumes: `breakout-introduction-page()`
- Produces: Crisp, friendly educational goals with short headings and no `هٔ`.

- [ ] **Step 1: Polish text, headings, and orthography**
  - Short heading: `= معرفی بازی و اهداف`
  - Subheading: `== اهداف اصلی این فاز`
  - Strip all `هٔ` -> plain `ه` (`نقطه عطفی`, `هسته پایدار`, `پوسته پرزرق‌وبرق`, etc.).
  - Ensure bullet items have good spacing and warm tone.

- [ ] **Step 2: Build and verify Page 4**
  - Check layout and ensure no overflow onto next page.

---

### Task 4: Page 5 — Pre-Phase 1 Actions (Structured Format, گیت ایگنور, GitHub & Conventional Commits)

**Files:**
- Modify: `course-materials/src/documents/breakout/before-phase1.typ`

**Interfaces:**
- Consumes: `breakout-before-phase1-page()`
- Produces: High-structure cards for research & UML steps, "گیت ایگنور", GitHub & Conventional Commits references, solo wording.

- [ ] **Step 1: Restructure Section 1 (Git & Repository Scaffolding)**
  - Short heading: `= اقدامات پیش از کدنویسی`
  - Subheading: `== ۱. راه‌اندازی مخزن گیت‌هاب و ساختار پروژه`
  - Rename .gitignore to `گیت‌ایگنور` / `گیت ایگنور (#code-inline(".gitignore"))`.
  - Explicitly reference `گیت‌هاب (#en[GitHub])` and `کامیت‌های استاندارد (#en[Conventional Commits])` with examples (`feat:`, `fix:`, `refactor:`).
  - Update README description to solo: student name and student ID.

- [ ] **Step 2: Transform Sections 2 & 3 from plain bullets into structured visual cards**
  - For Section 2 (Game research) and Section 3 (OOP modeling): replace plain low-English bullet lists with clean, structured compact cards/panels or styled definition boxes.
  - Remove all references to "اعضای تیم" or "اعضای گروه".
  - Replace all `هٔ` with plain `ه`.

- [ ] **Step 3: Build and verify Page 5**
  - Run `./course-materials/scripts/build.sh breakout-phase-01`
  - Render page 5 and verify clean layout fitting on exactly 1 page.

---

### Task 5: Page 6 — Architecture & MVC (Storytelling Hook, Vertical Cards, Clean Structure)

**Files:**
- Modify: `course-materials/src/documents/breakout/architecture.typ`

**Interfaces:**
- Consumes: `breakout-architecture-page()`
- Produces: Storytelling hook, 3 vertically stacked MVC cards, compact data flow and pluggable persistence interface.

- [ ] **Step 1: Rewrite opening hook**
  - Short heading: `= ساختار و معماری سیستم`
  - Hook: Friendly, relatable storytelling angle (e.g., imagine dumping physics, drawing, and keyboard listeners into a giant 2000-line monster class; how it starts as fun and turns into debugging spaghetti; and how MVC gives each part its own superhero job).
  - No dry "common error" opening.

- [ ] **Step 2: Stack MVC cards vertically**
  - Replace horizontal 3-column grid with 3 elegant, vertically stacked horizontal rows/cards:
    1. **لایه مدل (Model):** حقیقت جهان بازی و داده‌های ناب
    2. **لایه نما (View):** پنجره نمایش و بوم گرافیکی
    3. **لایه کنترل‌گر (Controller):** مغز متفکر و هماهنگ‌کننده
  - Compact vertical padding and clear visual accent colors so all 3 cards fit cleanly.

- [ ] **Step 3: Restructure data flow & HighScoreStorage contract**
  - Streamlined data-flow pipeline (User input $\rightarrow$ Controller $\rightarrow$ Model update $\rightarrow$ View render).
  - Compact interface presentation for `HighScoreStorage`.
  - Replace all `هٔ` with plain `ه`.

- [ ] **Step 4: Build and verify Page 6**
  - Run `./course-materials/scripts/build.sh breakout-phase-01`
  - Verify page 6 fits perfectly within its single page without spilling over.

---

### Task 6: Page 7 — Entities & Typst Geometry Visualization

**Files:**
- Modify: `course-materials/src/documents/breakout/entities.typ`

**Interfaces:**
- Consumes: Pure Typst vector drawing (`rect`, `circle`, `line`, `place`, `grid`).
- Produces: `breakout-entities-page()` with entity cards and an inline vector schematic of playfield geometry.

- [ ] **Step 1: Build inline Typst vector geometry diagram**
  - Create a clean graphic schematic showing:
    - Canvas boundary (800×600 aspect, scaled down to e.g. 100mm × 45mm).
    - Top HUD bar (score & hearts).
    - Brick matrix (5 rows × 8 columns) with dimension annotation.
    - Ball circle (radius $r = 8$, diameter $16$, $v_x, v_y$ velocity arrow).
    - Paddle rect (width $100$, height $15$, horizontal movement range, $40$px from bottom).
    - Origin $(0, 0)$ top-left indicator.

- [ ] **Step 2: Convert table into styled entity cards / headings**
  - 4 distinct styled entity cards:
    - **سکو (Paddle):** ابعاد ۱۰۰×۱۵، جابه‌جایی افقی با کلیدها، مهار در لبه‌ها.
    - **توپ (Ball):** قطر ۱۶ پیکسل، بردار سرعت، استقرار روی سکو تا پرتاب با فاصله.
    - **آجرها (Bricks):** ماتریس ۵×۸ (۴۰ آجر)، ابعاد ۸۵×۲۵، فاصله ۶ پیکسل، ۱۰۰ امتیاز.
    - **نشانگر وضعیت (HUD):** امتیاز، ۳ قلب جان، نمایش رکورد.
  - Subheading: `== اصول کپسوله‌سازی` with concise friendly guidelines.
  - Replace all `هٔ` with plain `ه`.

- [ ] **Step 3: Build and verify Page 7**
  - Run `./course-materials/scripts/build.sh breakout-phase-01`
  - Render page 7 with `pdftoppm` and inspect visual balance and geometry diagram.

---

### Task 7: Global Consistency Sweep (Pages 1–2, 8–12)

**Files:**
- Modify: `course-materials/src/documents/breakout/cover.typ`
- Modify: `course-materials/src/documents/breakout/toc.typ`
- Modify: `course-materials/src/documents/breakout/rules-gameplay.typ`
- Modify: `course-materials/src/documents/breakout/graphics.typ`
- Modify: `course-materials/src/documents/breakout/physics.typ`
- Modify: `course-materials/src/documents/breakout/milestones.typ`
- Modify: `course-materials/src/documents/breakout/evaluation.typ`

**Interfaces:**
- Consumes: All breakout files.
- Produces: Fully unified 12-page document with zero `هٔ`, short punchy headings, and friendly tone.

- [ ] **Step 1: Check and replace all instances of `هٔ` with plain `ه`**
  - Run `grep -rn "هٔ" course-materials/src/documents/breakout/` to ensure zero remaining occurrences.

- [ ] **Step 2: Shorten and simplify headings across pages 8–12**
  - Page 8: `= قوانین و سازوکار گیم‌پلی` $\rightarrow$ `= سازوکار گیم‌پلی`
  - Page 9: `= واسط گرافیکی و کتابخانه ACM` $\rightarrow$ `= گرافیک و واسط کاربری`
  - Page 10: `= فیزیک حرکت و هندسه برخورد` $\rightarrow$ `= فیزیک و برخوردها`
  - Page 11: `= نقشه راه و گام‌های پیاده‌سازی` $\rightarrow$ `= گام‌های پیاده‌سازی`
  - Page 12: `= شیوه ارزیابی و مصاحبه حضوری` $\rightarrow$ `= معیارهای ارزیابی`

- [ ] **Step 3: Full compilation and visual inspection**
  - Run `./course-materials/scripts/build.sh`
  - Verify total page count is exactly 12 pages.
  - Render all pages to PNG and confirm visual perfection, margins, breathing room, and alignment.
