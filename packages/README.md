# Pinned Typst packages

`local/dorost/0.2.1` is the course's local package snapshot from
[alirezaopmc/dorost](https://github.com/alirezaopmc/dorost), based on upstream
v0.2.0 with the additive inline-code font/size and exact-glyph changes in the
companion Dorost checkout. The complete runtime source and both upstream
license files are included so course builds work without Typst Universe or
network access.

Keep this package directory aligned with the Dorost source checkout. When
updating it, copy `typst.toml`, `lib.typ`, `src/`, `LICENSE`, and
`LICENSE-MIT-0`, then update the versioned directory and imports together.
