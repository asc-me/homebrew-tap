# Graphban formulae

```bash
brew install asc-me/tap/gban
```

`gban` is the [Graphban](https://github.com/asc-me/graphban) client for a human at a terminal
— issue seats, read why an agent is stuck, re-task one. The supervisor that runs waves is a
separate package and is not here: `uv tool install graphban-fleet` gives you `gbfleet` and
`gbagent`, and Homebrew is the wrong shape for it, since it exists to be resolved on `PATH`
by whatever launched it.

Formulae are generated from the PyPI release. Bumping one means a new `url` and `sha256` from
the sdist of the new version — `brew bump-formula-pr` does both.
