# Breakout Phase 01 Specification Redesign Implementation Plan

> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Completely redesign and rewrite `src/documents/breakout-phase-01.typ` into a calm, professional, 6-page technical specification matching AP course standards, incorporating custom cover artwork, table of contents, MVC architecture, graphics coordinates, segmented deflection physics, pluggable high-score persistence, state machine, and a 100-point rubric with an oral defense multiplier.

**Architecture:** Implement pure Typst vector graphics and structured layout helpers for Breakout's playfield blueprint, MVC architecture, 2D coordinates, segmented paddle physics, and state machine directly within the document ecosystem. Rewrite `src/documents/breakout-phase-01.typ` page-by-page adhering to an exact 6-page budget with full-width text justification (`par(justify: true)`), generous spacing, and no awkward text overflows.

**Tech Stack:** Typst 0.15.1, `src/course/theme.typ`, local `@local/dorost:0.2.1`, bundled fonts (Vazirmatn, Lora, JetBrains Mono), Poppler rendering tools (`pdftoppm`, `pdfinfo`).

**Spec:** `docs/design/specs/2026-10-26-breakout-phase-01-redesign.md`

## Global Constraints

- Persian prose, Persian-first rule. Exact Java identifiers, types, and code snippets stay in English.
- Use shared semantic helpers: `en`, `term`, `code-inline`, `code-block`, `note`, `latin-number`, `fa`, `math-inline`.
- Full-width line justification: `set par(justify: true, leading: 4.5pt, spacing: 6pt)`.
- Page Budget: Exactly 6 pages (`breakout-phase-01.pdf`).
- Do not modify `scripts/build.sh`. Compile using `./course-materials/scripts/build.sh breakout-phase-01`.
- Clean commit after each completed task following Conventional Commits (`feat:`, `docs:`, `fix:`).

---

### Task 1: Cover Artwork, Blueprint Vignette & Metadata

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: `course-document(cover-artwork: ...)` from `src/course/theme.typ`.
- Produces: Vector-drawn Breakout playfield blueprint schematic, the 1976 Wozniak/Jobs 44-chip historical quote frame, and a recommended prompt panel.

- [ ] **Step 1: Define the vector blueprint schematic and historical quote frame**
Define a `breakout-cover-vignette()` component with:
- An engineering blueprint container (`130mm × 68mm`) with dark navy background (`rgb("122236")`), drawing a green vector paddle, yellow ball with reflection ray lines, and colored brick rows.
- A quote frame containing the 1976 Wozniak/Jobs Atari 44-chip hardware sprint fun fact.
- An optional prompt callout for generating high-res artwork.

- [ ] **Step 2: Connect `cover-artwork` to `course-document`**
Pass `breakout-cover-vignette()` to `course-document(cover-artwork: ...)` in `breakout-phase-01.typ`.

- [ ] **Step 3: Compile and verify Page 1**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Render: `pdftoppm -png -r 150 -f 1 -l 1 output/pdf/breakout-phase-01.pdf /tmp/page1`
Verify: Cover layout is clean, seal is intact, blueprint and quote frame are properly aligned.

- [ ] **Step 4: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add custom cover blueprint vignette and 1976 historical hook"
```

---

### Task 2: Page 2 — Table of Contents & Assignment Foundations

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst `#outline` and course theme heading styles.
- Produces: Page 2 containing Table of Contents, Section 1 (Goal & Scope), and Section 2 (Core Mechanics & Rules).

- [ ] **Step 1: Configure Table of Contents styling**
Add `#outline(title: "فهرست مطالب", indent: 1.5em, depth: 2)` at the beginning of the body.
Ensure dotted leaders connect headings to Persian numbers.

- [ ] **Step 2: Author Section 1 (Goal, Scope & Educational Objectives)**
Detail the pedagogical objectives:
- Modeling with pure Java classes.
- Single Responsibility Principle (SRP).
- Encapsulation of internal mutable state.
- Connection to AP syllabus (what is expected now vs. later).

- [ ] **Step 3: Author Section 2 (Core Gameplay Mechanics & Rules)**
Detail the gameplay requirements:
- 3 Lives / Hearts displayed on HUD.
- Score system (+100 per destroyed brick).
- Serve on demand (ball attached to paddle, launched with `Space`).
- Pause toggle (`P` key) and Quick Restart (`R` key).

- [ ] **Step 4: Add explicit page break**
Append `#pagebreak()` to seal Page 2.

- [ ] **Step 5: Compile and verify Page 2**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Verify: Table of contents and intro fit Page 2 with comfortable vertical breathing room.

- [ ] **Step 6: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add table of contents and foundational rules to page 2"
```

---

### Task 3: Page 3 — Visual OOP Architecture, MVC & Pluggable Storage Contract

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst block and grid components.
- Produces: Page 3 containing Section 3 (System Architecture & OOP Design), UML MVC diagram, Responsibility Matrix, and the `HighScoreStorage` interface contract.

- [ ] **Step 1: Construct the 3-Tier MVC Architecture Visual**
Build a clean visual diagram using nested blocks showing:
- Controller Layer: `GameEngine` (Timer 60 FPS, Key Listener, Collision Dispatcher).
- Model Layer: `Ball`, `Paddle`, `Brick`, `GameState`, `HighScoreStorage`.
- View Layer: `BreakoutCanvas` (`acm.graphics` wrappers, HUD, Overlays).

- [ ] **Step 2: Detail Class Responsibilities & Encapsulation Rules**
Provide the responsibility table detailing:
- `Ball`: Position, velocity vectors, radius, `update()`, bounding box.
- `Paddle`: Position, dimensions, horizontal clamping, `moveLeft()`, `moveRight()`.
- `Brick`: Position, width/height, durability, `destroy()`.
- `GameEngine`: Ticking game loop, updating model, delegating render.

- [ ] **Step 3: Introduce the Pluggable High-Score Strategy Contract**
Detail the `HighScoreStorage` interface:
```java
public interface HighScoreStorage {
    int loadHighScore();
    void saveHighScore(int score);
}
```
Explain the architectural rationale: decoupling storage allows immediate RAM implementation (`InMemoryScoreStorage`) and zero-refactor file persistence (`FileScoreStorage`) once File I/O is taught.

- [ ] **Step 4: Add explicit page break**
Append `#pagebreak()` to seal Page 3.

- [ ] **Step 5: Compile and verify Page 3**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Verify: MVC diagram and code blocks render cleanly with proper line wrapping.

- [ ] **Step 6: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add MVC architecture diagram and pluggable storage contract to page 3"
```

---

### Task 4: Page 4 — Mathematical Physics, Geometry & Anti-Pattern Hall of Fame

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst math formatting and code blocks.
- Produces: Page 4 containing Section 4 (Geometry & Physics), 2D coordinate space visual, Segmented Paddle Deflection formula, AABB collision, and the Anti-Pattern Hall of Fame callout.

- [ ] **Step 1: Build the 2D Screen Coordinate Space Diagram**
Render a diagram illustrating:
- Origin $(0, 0)$ top-left, $+X$ right, $+Y$ down.
- Velocity vector arrows with positive/negative signs ($v_y > 0$ down, $v_y < 0$ up).
- Standard dimensions table: Canvas $800 \times 600$, Paddle $100 \times 15$, Ball $d=16$, Brick grid $5 \times 8$.

- [ ] **Step 2: Detail Segmented Paddle Deflection Physics**
Provide the mathematical formulation and diagram for angle deflection:
- Offset $d = (x_{\text{ball}} - x_{\text{center}}) / (W / 2) \in [-1.0, 1.0]$.
- Angle $\theta = d \times 60^\circ$.
- Component calculation preserving scalar speed: $v_x = v \sin(\theta)$, $v_y = -v \cos(\theta)$.

- [ ] **Step 3: Detail AABB Collision & The Anti-Pattern Hall of Fame**
Add the callout box highlighting common student bugs:
- *The "Sticky Paddle" bug:* Why `ball.setY(paddle.getY() - ball.getRadius())` is required.
- *Integer division truncation:* Why `2.0` and `double` arithmetic must be used.
- *Corner collision axis resolution:* Clamping circle center to rectangle bounds.

- [ ] **Step 4: Add explicit page break**
Append `#pagebreak()` to seal Page 4.

- [ ] **Step 5: Compile and verify Page 4**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Verify: Physics equations, coordinate diagram, and warning box fit Page 4 without overflow.

- [ ] **Step 6: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add physics, coordinate visual and anti-pattern guide to page 4"
```

---

### Task 5: Page 5 — State Machine & Phased Milestones Roadmap

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst block layouts and lists.
- Produces: Page 5 containing Section 5 (State Machine & Game Flow), Section 6 (Implementation Milestones 1–5), and Section 7 (Bonus Features).

- [ ] **Step 1: Construct the State Machine Visual**
Diagram showing the states and transition events:
- `READY` $\to$ Space $\to$ `RUNNING`
- `RUNNING` $\leftrightarrow$ P $\leftrightarrow$ `PAUSED`
- `RUNNING` $\to$ Life Loss $\to$ `READY` (if lives > 0)
- `RUNNING` $\to$ `GAME_OVER` (if lives == 0)
- `RUNNING` $\to$ `VICTORY` (if bricks == 0)
- `GAME_OVER` / `VICTORY` $\to$ R $\to$ `READY`

- [ ] **Step 2: Author the 5 Scaffolded Milestones**
Break implementation down into:
- *Milestone 1:* Canvas setup and keyboard paddle clamping.
- *Milestone 2:* Ball movement, 3-wall reflections, and manual serve launch.
- *Milestone 3:* Segmented paddle deflection and 3 Lives / Hearts HUD.
- *Milestone 4:* $5 \times 8$ Brick matrix, AABB collision destruction, and RAM high score.
- *Milestone 5:* State machine, pause overlay, win/loss conditions, and restart.

- [ ] **Step 3: Define Optional Bonus Features**
- Durable 2-hit bricks with damage visual / color shift (+10 pts).
- Dynamic runtime storage toggle between RAM and File (+5 pts).

- [ ] **Step 4: Add explicit page break**
Append `#pagebreak()` to seal Page 5.

- [ ] **Step 5: Compile and verify Page 5**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Verify: State diagram and milestones list flow comfortably across Page 5.

- [ ] **Step 6: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add state machine diagram and scaffolded milestones to page 5"
```

---

### Task 6: Page 6 — Repository Standards, 100-Point Rubric & Oral Defense Multiplier

**Files:**
- Modify: `src/documents/breakout-phase-01.typ`

**Interfaces:**
- Consumes: Typst tables and note callouts.
- Produces: Page 6 containing Section 8 (Deliverables & Git Repository Structure), Section 9 (Grading Rubric Table), and Section 10 (Oral Defense Multiplier Policy).

- [ ] **Step 1: Specify the Project Directory Layout & Git Conventions**
Provide standard directory structure:
```text
breakout/
├── src/
│   ├── model/       # Ball, Paddle, Brick, GameState, HighScoreStorage, InMemoryScoreStorage
│   ├── view/        # BreakoutCanvas, HUD, Overlays
│   ├── controller/  # GameEngine, Main
│   └── util/        # GameConstants
├── lib/             # acm.jar
└── README.md
```

- [ ] **Step 2: Construct the 100-Point Grading Rubric Table**
Detailed table covering:
- Functionality & Game Feel: 40 pts.
- OOP Architecture & Design: 35 pts.
- Code Cleanliness & Best Practices: 15 pts.
- Oral Defense & Conceptual Mastery: 10 pts.
- Total: 100 pts normalized to 2.0 course points.

- [ ] **Step 3: Formulate the Oral Defense Multiplier Policy**
Explain the linear interpolation formula:
$$\text{Final Score} = \text{Technical Score} \times \alpha, \quad \alpha \in [0.5, 1.0]$$
Detail the criteria: complete understanding yields $\alpha = 1.0$; inability to defend scales down to $\alpha = 0.5$ (50% penalty).

- [ ] **Step 4: Compile and verify Page 6**
Run: `./course-materials/scripts/build.sh breakout-phase-01`
Verify: Table and closing notes fit Page 6 with zero overflow to Page 7.

- [ ] **Step 5: Commit**
```bash
git -C /home/opmc/Dev/aputir/course-materials add src/documents/breakout-phase-01.typ
git -C /home/opmc/Dev/aputir/course-materials commit -m "feat(breakout): add repository layout, rubric and defense multiplier to page 6"
```

---

### Task 7: Full Compilation, Visual Inspection & Quality Gates

**Files:**
- Read/Verify: `output/pdf/breakout-phase-01.pdf`

**Interfaces:**
- Consumes: Built PDF.
- Produces: Verified 6-page production PDF.

- [ ] **Step 1: Compile the entire document**
Run: `./course-materials/scripts/build.sh breakout-phase-01`

- [ ] **Step 2: Check page count**
Run: `pdfinfo output/pdf/breakout-phase-01.pdf | grep Pages`
Expected: `Pages: 6`

- [ ] **Step 3: Render and inspect all 6 pages**
Run: `pdftoppm -png -r 150 output/pdf/breakout-phase-01.pdf /tmp/breakout-page`
Inspect: Ensure full-width line justification, clean spacing, proper diagram alignments, and no clipped characters.

- [ ] **Step 4: Commit and finalize**
```bash
git -C /home/opmc/Dev/aputir/course-materials add output/pdf/breakout-phase-01.pdf
git -C /home/opmc/Dev/aputir/course-materials commit -m "chore(breakout): rebuild and verify 6-page Breakout phase 01 specification"
```
