# Course document work

Read `docs/document-style-guide.md` and `README.md` before creating or revising course documents. Use `src/course/theme.typ` as the single source of layout and typography.

Use one UT logo on the cover; do not render the Engineering logo. Prefer Persian document/course titles and omit redundant English translations. Write ordinary prose and descriptive names in Persian when a natural equivalent exists, including fictional project or vessel names. Keep English for exact code/API names, named software/libraries, and specialist terms students need to recognize; give those terms a short Persian explanation when helpful.

### Editorial and Layout Conventions
- **No parenthetical English terms in prose or headings:** Never place English translations, acronyms, or glosses in parentheses (e.g. do NOT write `بافر دوگانه (#en[Double Buffering])` or `معماری (#en[MVC])`). Instead, use Persian in the sentence and attach a footnote: `بافر دوگانه#footnote[#en[Double Buffering]]` or `معماری مدل-نما-کنترل‌گر#footnote[#en[MVC: Model-View-Controller]]`.
- **Clean headings:** Headings must never contain parenthetical English terms or acronyms (e.g. use `== پایداری تصویر و بافر دوگانه` instead of `== پایداری تصویر و بافر دوگانه (#en[Double Buffering])`).
- **No parentheses around code tags or card badges:** Display code identifiers or badges directly without parentheses (e.g. `#code-inline("HighScoreStorage")`, not `(#code-inline("HighScoreStorage"))`).
- **Vertical-first cards and layouts:** Avoid horizontal cards or placing cards side-by-side. Always prefer full-width, vertically stacked cards (`width: 100%`).
- **Vertical separation of formulas and code:** Never place formulas and code side-by-side horizontally. Stack them vertically with ample breathing room. For fractions, decompose numerator and denominator into separate named variables ($Delta x$ and $w_"half"$) matching implementation variables.

Preserve assignment text, scores, examples, and submission requirements. Keep original references and editable sources. Use the documented inline helpers for Persian, English, code, numbers, and math.

Use the pinned `@local/dorost:0.2.1` package in `packages/` for shared direction,
inline code/math, and Persian-digit primitives. Keep APUT page layouts, typography,
and course-specific components in `src/course/theme.typ`; compile through
`scripts/build.sh` so the local package path is configured.

Workshop closing reflections are an explicit exception to Persian-first prose: the quote, story, prompt labels/examples, takeaway, and closing invitation must all be English, LTR, and set in Lora. Keep this content in `src/course/workshop-reflection.typ` and its presentation in `src/course/theme.typ`; every workshop uses `course-workshop`. Enclose the quote in typographic double quotation marks on the cover and final page. Write a professional story about how knowledge improves prompting and evaluation; make the example appealing to programming students without inserting audience labels into the story. The refined prompt must reuse the initial prompt and add useful design decisions, methods, and behavior details. End by inviting readers to try both prompts and share their experience with classmates. Follow `docs/brand/workshop-reflection-editorial.md` for the full brief.

When producing PDFs, compile with the bundled fonts, render and review the pages, and update `docs/verification.md`. Do not add automated tests unless requested by the user.
