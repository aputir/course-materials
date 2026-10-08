# Course document work

Read `docs/document-style-guide.md` and `README.md` before creating or revising course documents. Use `src/course/theme.typ` as the single source of layout and typography.

Use one UT logo on the cover; do not render the Engineering logo. Prefer Persian document/course titles and omit redundant English translations. Write ordinary prose and descriptive names in Persian when a natural equivalent exists, including fictional project or vessel names. Keep English for exact code/API names, named software/libraries, and specialist terms students need to recognize; give those terms a short Persian explanation when helpful.

Preserve assignment text, scores, examples, and submission requirements. Keep original references and editable sources. Use the documented inline helpers for Persian, English, code, numbers, and math.

Workshop closing reflections are an explicit exception to Persian-first prose: the quote, story, prompt labels/examples, takeaway, and closing invitation must all be English, LTR, and set in Lora. Keep this content in `src/course/workshop-reflection.typ` and its presentation in `src/course/theme.typ`; every workshop uses `course-workshop`. Enclose the quote in typographic double quotation marks on the cover and final page. Write a professional story about how knowledge improves prompting and evaluation; make the example appealing to programming students without inserting audience labels into the story. The refined prompt must reuse the initial prompt and add useful design decisions, methods, and behavior details. End by inviting readers to try both prompts and share their experience with classmates. Follow `docs/brand/workshop-reflection-editorial.md` for the full brief.

When producing PDFs, compile with the bundled fonts, render and review the pages, and update `docs/verification.md`. Do not add automated tests unless requested by the user.
