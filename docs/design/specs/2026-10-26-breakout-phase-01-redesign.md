# Breakout Phase 01 Specification Redesign — Design Spec

**Date:** 2026-10-26  
**Type:** Project Phase Document (`فاز پروژه`)  
**Working Title:** `هستهٔ بازی Breakout`  
**Subtitle:** `اهداف، نیازمندی‌های فنی، طراحی شی‌گرا و معیارهای ارزیابی`  
**Target File:** `src/documents/breakout-phase-01.typ`  
**Target Output:** `output/pdf/breakout-phase-01.pdf`  
**Target Audience:** 20-year-old undergraduate students in Advanced Programming (AP), University of Tehran.

---

## 1. Executive Summary & Purpose

The purpose of this overhaul is to transform the Breakout Phase 01 specification from a dense, unstructured assignment description into a calm, academically rigorous, and student-friendly engineering document. 

The revised document provides:
1. A **specialized visual cover** featuring a blueprint-style arcade playfield schematic and the historical 1976 Steve Wozniak / Steve Jobs 44-chip Atari hardware sprint fun fact.
2. A formal **Table of Contents (`#outline`)** for clean navigation.
3. A calm, spacious layout with the theme's natural Persian alignment and comfortable paragraph spacing; each major topic starts on its own page.
4. Concrete **visual figures** illustrating OOP architecture (MVC separation), 2D computer graphics coordinate conventions, segmented paddle physics, and the game state machine.
5. An architectural bridge to the course syllabus: introducing the **Strategy Pattern without naming it** via a decoupled `HighScoreStorage` contract (RAM storage today, File I/O once taught in lecture).
6. An unambiguous **100-point grading rubric** featuring an **oral-defense multiplier $\alpha$ set by the TAs after the presentation** that guards against academic integrity violations and rewards deep conceptual mastery.

---

## 2. Pedagogical Alignment with AP Syllabus

### Student Progress Context
- **Completed Topics:** Objects, Classes, Encapsulation, Compile-Time & Runtime Polymorphism, Abstraction via Interfaces, `acm.graphics` hierarchy (`GRect`, `GOval`, `GLabel`, `GCanvas`), and asynchronous Event Listeners (`addMouseListeners`, `addKeyListeners`).
- **Topics Covered During Phase 1 (Prior to Deadline):** Text-Based File I/O (`FileReader`, `BufferedReader`, `PrintWriter`), Binary Streams, Serialization, and JSON.
- **Topics Explicitly Deferred / Excluded for Phase 1:** Sound, audio clips, multiple levels, complex animations/GIFs, concurrency/multithreading, and advanced Java 8 functional streams/lambdas.

### The Unnamed Strategy Pattern
Instead of burdening students with theoretical GoF design pattern terminology before it appears in the syllabus, the document establishes an architectural pattern naturally through an interface:
- Contract: `HighScoreStorage` with `int loadHighScore()` and `void saveHighScore(int score)`.
- Immediate concrete implementation: `InMemoryScoreStorage` (stores session high score in RAM).
- Future concrete implementation: `FileScoreStorage` (reads/writes `highscore.txt` using `BufferedReader` and `PrintWriter`).
- Architectural takeaway: Demonstrates how interface-based decoupling allows swapping persistence mechanisms with zero modifications to `GameEngine` or domain models.

---

## 3. Visual & Typographical Standards

### Typographical Geometry
- **Text Alignment:** the theme's natural alignment (`justify: false`). Persian prose keeps natural word spacing, as the style guide requires.
- **Rhythm & Spacing:**
  - Paragraph spacing: `6pt` (measured separation without empty blank lines).
  - Line leading: `4.5pt`.
  - Section headings (Level 1): `18pt` above, `7pt` below.
  - Subsections (Level 2): `12pt` above, `5pt` below.
- **Page Budget & Flow:** No fixed page count. Major topics start on new pages through explicit `#pagebreak()` calls.

### Cover Artwork & Vignette
- **Cover Visual:** Placed in the lower-cover area using `workshop-style` proportions (`130mm × 72mm`), presenting a vector blueprint schematic of the Breakout playfield: paddle center coordinate, deflection angle rays ($\theta \in [-60^\circ, +60^\circ]$), and multi-colored brick matrix.
- **Historical Callout (Fun Fact):**
  > *«در سال ۱۹۷۶، نولان باشنل در شرکت آتاری از استیو جابز خواست بازی Breakout را با کمترین تعداد تراشهٔ سخت‌افزاری بسازد. جابز پروژه را به استیو وازنیاک سپرد؛ وازنیاک طی ۴ شبانه‌روز کار بی‌وقفه، مدار بازی را تنها با ۴۴ تراشه پیاده کرد. ابتکارات وازنیاک در بهینه‌سازی مدارهای گرافیکی این بازی، مستقیماً الهام‌بخش او در طراحی معماری نمایش تصویر و رنگ در رایانهٔ انقلابی Apple II شد.»*
- **Recommended Asset Generation Prompt:**
  ```text
  Technical blueprint drawing of classic 1976 Breakout arcade game, showing green vector wireframe paddle, mathematical ball deflection angles, and brick array grid on deep navy blueprint paper, clean line art, precise dimension labels, engineering schematic style, high resolution.
  ```

---

## 4. Page-by-Page Document Structure

### Page 1: Cover Page
- UT Seal (32mm) and official institutional typography (`دانشگاه تهران`, `دانشکده علوم کامپیوتر`).
- Document Category: `فاز پروژه ۰۱`
- Document Title: `هستهٔ بازی Breakout`
- Subtitle: `اهداف، نیازمندی‌های فنی، طراحی شی‌گرا و معیارهای ارزیابی`
- Metadata: Instructor, preparer, academic term, and delivery dates.
- Cover Artwork Vignette + Framed 1976 Atari Wozniak/Jobs historical hook.

### Page 2: Table of Contents & Foundations
- **فهرست مطالب (Table of Contents):** Stylized `#outline(title: "فهرست مطالب", indent: 1.5em, depth: 2)` with dotted leaders.
- **هدف و محدوده (Scope & Objectives):** Alignment with OOP principles, single responsibility, and the AP syllabus.
- **رفتار و قوانین پایهٔ بازی (Core Mechanics):**
  - Standard 3 Lives / Hearts system.
  - Score counter (+100 points per brick destroyed).
  - Serve on demand: Ball rests attached to paddle at start / after life loss until `Space` is pressed.
  - Pause toggle on key `P`.
  - Restart on key `R`.

### Page 3: OOP Architecture & MVC Contract
- **معماری سیستم و تفکیک مسئولیت‌ها (System Architecture):**
  - Model (Domain Layer): `Ball`, `Paddle`, `Brick`, `GameState` (pure Java, zero graphics dependencies).
  - View (Presentation Layer): `BreakoutCanvas`, HUD (Score & Hearts), state overlays.
  - Controller (Orchestration Layer): `GameEngine` managing 60 FPS tick, key events, and collision dispatch.
- **UML Class Diagram & Responsibility Matrix:** Clean visual layout detailing fields, access modifiers (`private`), and public methods.
- **آینده‌نگری معماری: قرارداد ذخیره‌سازی داده (Pluggable Persistence):**
  - Definition of `HighScoreStorage` interface.
  - Immediate `InMemoryScoreStorage` class.
  - Forward-looking `FileScoreStorage` class (unnamed strategy pattern).

### Page 4: Mathematical Physics & Collision Geometry
- **دستگاه مختصات دوبعدی نمایش (2D Screen Coordinates):**
  - Origin $(0,0)$ top-left, $+X$ right, $+Y$ down.
  - Sign conventions for velocity: $v_y > 0$ means downwards/falling, $v_y < 0$ means upwards/bouncing.
- **بازتاب زاویه‌دار قطعه‌ای از سکو (Segmented Paddle Deflection):**
  - Offset formula: $d = \frac{x_{\text{ball}} - x_{\text{paddle\_center}}}{W_{\text{paddle}} / 2} \in [-1.0, +1.0]$.
  - Angle: $\theta = d \times 60^\circ$.
  - Preserved speed velocity components: $v_x' = v \sin(\theta)$, $v_y' = -v \cos(\theta)$.
- **برخورد جعبه‌های مرزی (AABB) و کالبدشکافی خطاهای متداول:**
  - Bounding box clamp collision calculation.
  - **The "Sticky Paddle" Trap:** Why `ball.setY(paddle.getY() - ball.getRadius())` is mandatory to avoid paddle trapping.
  - **Integer Division Truncation:** Enforcing `2.0` and `double` arithmetic.
  - **High-speed Tunneling:** Frame delta constraints.

### Page 5: Game State Machine & Phased Milestones
- **ماشین وضعیت بازی (Game State Machine):**
  - Visual diagram: `READY` (Serve) $\leftrightarrow$ `RUNNING` $\leftrightarrow$ `PAUSED` $\to$ `GAME_OVER` / `VICTORY`.
- **گام‌های پنج‌گانهٔ پیاده‌سازی (5 Scaffolded Milestones):**
  1. *Milestone 1:* Window, Canvas & Keyboard-clamped Paddle.
  2. *Milestone 2:* Ball physics, 3-wall bounce, and manual Serve state.
  3. *Milestone 3:* Paddle deflection physics and 3 Lives / Hearts HUD.
  4. *Milestone 4:* 40-brick matrix ($5 \times 8$), AABB destruction, score & RAM high score.
  5. *Milestone 5:* Game state lifecycle, pause overlay, win/loss triggers, and restart.
- **بخش‌های اختیاری و امتیازی (Bonus Scope):**
  - Durable 2-hit bricks with damage visual / color shift (+5 pts).
  - Runtime storage toggle between RAM and File (+10 pts).

### Page 6: Deliverables, Grading Rubric & Defense Policy
- **ساختار استاندارد مخزن گیت (Git Directory Standards):**
  - High-level description of the repository deliverable; no mandatory directory tree.
  - Commit message conventions.
- **جدول مصوب بارم‌بندی (100-Point Grading Rubric):**
  - Functionality & Game Feel: 35 pts.
  - OOP Architecture & Design: 35 pts.
  - Code Cleanliness & Best Practices: 15 pts.
  - Oral Defense & Conceptual Mastery: 15 pts.
- **ضریب دفاع شفاهی (Oral Defense Multiplier):**
  - $\alpha = 0.5 + 0.5 \cdot \frac{m}{100}$, where $m \in [0, 100]$ is the mastery percentage the TAs assess after the presentation; therefore $0.5 \le \alpha \le 1$.
  - $\text{Final Score} = \text{Technical Score} \times \alpha$. Example: technical 80 and $m = 60$ give $\alpha = 0.8$ and a final score of 64.
- **نکات تحویل و پشتیبانی (Submission Guidelines):**
  - Repository link submission on eLearn (سامانه آموزشی ایلرن).
  - Plagiarism warning and academic integrity contract.

---

## 5. Verification & Quality Gates
- **Compilation Gate:** Document must compile cleanly via `./course-materials/scripts/build.sh breakout-phase-01` with zero Typst warnings or errors.
- **Visual Inspection:** Generated PDF must be checked page-by-page via `pdftoppm` to verify line justification, spacing, table borders, and diagram layout.
- **Page Budget Gate:** Removed. Check instead for near-empty pages and unintended spillovers.
