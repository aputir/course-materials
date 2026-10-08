# Shared workshop reflection editorial brief

This records the user's requirements and expanded writing brief for every workshop. The closing reflection is an explicit exception to the course's Persian-first prose. Its quote, story, prompt labels, both examples, takeaway, and invitation must use English LTR flow. Prose, labels, and quotes use Lora; exact code identifiers retain JetBrains Mono, and math retains its native font. Course teaching content and page furniture retain their Persian treatment.

## Message and voice

Use the exact quote “AI knows as much as you know.” Keep the string unadorned in the shared content source; the theme supplies typographic double quotation marks on both the cover and closing page. The quote describes the quality of the collaboration, not a literal limit on the model's stored knowledge.

Write a short, professional story showing how experience and subject knowledge help someone describe a problem, supply relevant constraints, anticipate edge cases, and evaluate an answer. Give the story a concrete situation and connect it gently to the illustration's shared lantern light. Avoid guarantees that a better prompt produces correct code. Keep the voice approachable without patronizing novices, forced slang, or motivational clichés.

The audience is university Advanced Programming students. Their interests should influence the scenario; do not insert “Gen Z,” “AP student,” or “noob” into the story. The current story follows two friends creating and animating a fleet of ships on a p5.js canvas. One describes the scene; the more experienced friend also specifies how the animation should be structured and checked.

## Prompt comparison

- Keep the first prompt very simple and recognizable.
- The second must repeat the exact first prompt, then expand it with useful design decisions, methods, and behavior details. Store that prefix only once.
- End both prompts with the exact sentence “Your output must be only a p5.js codeblock.” on its own line. Store the instruction once and render it at the end of each panel. Any requested explanation belongs in code comments so it respects this output restriction.
- Make the addition meaningful: define visual choices, state, method responsibilities, movement, and edge behavior. Ask for a runnable result and an explanation of decisions, so the reader can inspect and modify it.
- Use an engaging programming situation connected to the workshop. The current p5.js example connects introductory objects, arrays, and animation. Avoid elaborate infrastructure or unrelated techniques.
- Show the prompts without inventing AI outputs. This is an invitation to experiment, not an additional assignment or submission requirement.

The user-selected example creates ships and animates them around a p5.js canvas. The expanded prompt asks for an 800 × 500 white canvas, five black-outline ships drawn with simple shapes, an array of `Ship` objects, separate `display()`/`update()`/`wrap()` methods, one-time initialization, frame updates, speed in pixels per second, wrapping after a ship fully exits, and an explanation of how to change ship count and speed. These requirements make the animation's design inspectable without prescribing every line of code. This supersedes the earlier tournament example.

The API wording was checked against the official p5.js references: [`setup()`](https://p5js.org/reference/p5/setup/) runs initialization once; [`draw()`](https://p5js.org/reference/p5/draw/) repeats during the sketch; [`deltaTime`](https://p5js.org/reference/p5/deltaTime/) is measured in milliseconds, so the example requests `deltaTime / 1000` when expressing speed in pixels per second. The ship methods are requested application methods, not p5.js APIs.

End by asking readers to try both prompts in the same AI tool and run the sketches. Ask them to compare movement, edge behavior, and ease of modification, then share their experience and a suggested prompt improvement with classmates.

## Ownership and production

`src/course/workshop-reflection.typ` owns all repeated editorial copy and the image path. `src/course/theme.typ` owns typography, direction, frames, image geometry, and prompt panels. Every workshop uses `course-workshop`; do not duplicate this section in entry files. Keep the existing white-background black-ink sketch, the larger closing image, and one-page reflection composition.

The earlier 2026-10-08 revision used separate story-writing and prompt-writing subagents, followed by independent editorial review. For the subsequent user-selected ships scenario, the editorial subagent reviewed the expanded prompt and story, recommending explicit method responsibilities and speed units. The main editor integrated those recommendations into the shared source. Evaluation remains part of the lesson.

After copy changes, compile both the actual workshop and starter with bundled fonts, render all pages, inspect the English section and both quoted titles, and update `docs/verification.md`.
