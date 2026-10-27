# Pinned Typst packages

`local/dorost/0.2.1` is the course's local package snapshot of upstream
[alirezaopmc/dorost](https://github.com/alirezaopmc/dorost) v0.2.1, which
includes the inline-code font and size options and the exact-glyph changes.
The complete runtime source and both upstream license files are included so
course builds work without Typst Universe or network access.

Keep this package directory aligned with the upstream `main` branch. When
updating it, copy `typst.toml`, `lib.typ`, `src/`, `LICENSE`, and
`LICENSE-MIT-0`, then update the versioned directory and imports together.
