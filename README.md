# E6's Emacs

A writing-first scholarly Emacs environment, built on
[minimal-emacs.d](https://github.com/jamescherti/minimal-emacs.d) with a
literate config that tangles from `Config.org`.

## Structure

minimal-emacs.d provides two files that are **vendored and never hand-edited** —
`early-init.el` and `init.el`. They load our own files in a fixed order:

```
early-init.el  ->  pre-early-init.el  ->  post-early-init.el
init.el        ->  pre-init.el  ->  (packages)  ->  post-init.el
```

All configuration lives in **`Config.org`**, which tangles into `post-init.el`
(the last file loaded). Saving `Config.org` re-tangles it automatically.

**Golden rule:** edit only `Config.org`. The `*-init.el` files are generated —
never edit them by hand; they are overwritten on every tangle.

## Install note

This is a single config synced across machines via git.

- **Where it lives:** Windows `%APPDATA%\.emacs.d` (i.e.
  `C:\Users\<you>\AppData\Roaming\.emacs.d`); Linux `~/.emacs.d`. Clone the same
  repo to that path on each machine.
- **First launch:** on the first start, `package.el` refreshes archives and
  installs the packages declared in `Config.org` — this takes a minute; later
  starts are fast. Launch Emacs the normal way (Start menu / shortcut on
  Windows), not from a shell that sets `HOME`, so `~` resolves to this directory.
- **Fonts:** the config uses **FiraCode Nerd Font** at 12pt for *everything*
  (no serif). Install it from [Nerd Fonts](https://www.nerdfonts.com/); if it's
  missing Emacs falls back to a default. Prefer proportional prose? Set
  `variable-pitch-family` in the *Fonts — fontaine* block to a **sans** you have
  (e.g. `DejaVu Sans`) and toggle it per buffer with `SPC t m` (mixed-pitch) —
  it's off by default because a serif here hurt readability. Completion-list
  icons need **Symbols Nerd Font Mono** (`M-x nerd-icons-install-fonts`, then
  install the `.ttf`); until then those icons are off and everything else works.
- **External tools (later passes):** some features shell out to external
  programs (Quarto, himalaya, etc.); those are platform-guarded and documented
  in `Config.org` as they're added.

## Editor extras

- **dirvish** — modern file manager (replaces Dired); `SPC f d`, sidebar `SPC f D`.
- **olivetti** — centered writing margins in text/Org/Markdown buffers (code
  buffers keep full width); `olivetti-style` is `fancy`, and the `fringe` face is
  darkened so the page flanks read as margins. Toggle `SPC t o`.
- **org-sticky-header** — pins the current heading at the top of Org buffers.
- **Nord-coloured Org headings** — heading levels sized/coloured with the Nord
  palette; source blocks get a subtle raised background and code faces stay
  monospaced even under mixed-pitch (zzamboni-style beautify).
- **rainbow-delimiters** — nested brackets/parens coloured by depth in code.

## Languages & linting

Opening a supported file gives you syntax highlighting, and **linting/diagnostics
via `eglot` (built-in LSP) — but only if the matching language server is on your
`PATH`** (silent otherwise). Major modes: Markdown, YAML, TOML, Lua, Typst
(`.typ`, needs the typst tree-sitter grammar), Rust (`rust-ts-mode`), Python
(built-in), plus Quarto `.qmd` from the research pass.

Install servers as you need them (Linux; use uv for Python tools):

| Language | Server | Install |
|---|---|---|
| Python | basedpyright / ruff | `uv tool install basedpyright` · `uv tool install ruff` |
| Rust | rust-analyzer | `rustup component add rust-analyzer` |
| Typst | tinymist | download from the tinymist releases (or your package manager) |
| Lua | lua-language-server | your package manager |
| YAML | yaml-language-server | `npm i -g yaml-language-server` |
| TOML | taplo | `cargo install taplo-cli --locked` |
| Markdown | marksman | your package manager / release |

For Typst syntax you also need the tree-sitter grammar:
`M-x treesit-install-language-grammar RET typst`.

## Launch & services

`SPC l` opens a menu to **convert the current file** and run/track tools:

- **Convert:** `w` Word · `h` HTML · `p` PDF. Org/Markdown use **Quarto's bundled
  pandoc** (`quarto pandoc`; PDF via **Typst**, no LaTeX and no separate pandoc);
  `.qmd` uses `quarto render`. `t` compiles a `.typ` with `typst`. (Quarto can't
  *render* `.org`, but `quarto pandoc` converts it fine.)
- **Linguistics:** if you set `e6/pandoc-ling-filter` to your `pandoc-ling.lua`,
  pandoc exports run through it so linguistic examples number/cross-reference.
- **marimo:** `SPC l m` launches a notebook **in a directory you choose, using
  that directory's uv env** (`uv run marimo edit`).
- **Services (`SPC l s`, prodigy):** `s` start, `S` stop, `r` restart, `b` open
  its URL (shown in the service name). Ships with **marimo** (:2718 — run the
  `marimo` binary directly so Stop works; `uv tool install marimo` once) and
  **BentoPDF** (:3000, `podman run --replace …`, no `-d`, so prodigy owns it).
- `SPC l P` → `list-processes` (all Emacs child processes).

Anything launched this way is an Emacs child process, so it dies when you quit
Emacs — no orphaned resource hogs.

## Org / ADHD "emotional sprints"

TODO states are by *feeling*: `FIRE` `APPROACH` `BORING` `PLAY` → `DONE`. Capture
is low-friction (`SPC c` → `i`/`f`/`p`/`b`, just dump it). The **dashboard**
`SPC n s` stacks tasks by sprint (⚡📅🎨🪵) instead of a clock. A **Pomodoro/timer**
lives at `SPC t p`. Edit the keywords/dashboard in the *Org base* block.

## Projects & pomodoro

- **Projects (`SPC p`, project.el):** any Git repo is a project; a plain folder
  becomes one if it has a `.project` marker file. `SPC p p` switch, `SPC p f`
  find file, `SPC p g` grep.
- **Pomodoro/timer (`SPC t p`):** `p` start a 25/5 Pomodoro on the current task,
  `k` stop; plus a plain countdown with pause/resume.

## Read-aloud & dictation (Linux only)

`e6/readback-mode` (toggle with `SPC t R`) reads paragraphs aloud (**pocket-tts**
— much better Spanish than Piper) and lets you dictate spoken comments that
**Parakeet v3** transcribes into Org `# …` comment lines (which don't export to
Word). Enabling starts two warm model servers; disabling frees them.

**In-mode keys:** `<f4>` render whole section then unload the TTS model · `<f5>`
cycle voice · `<f6>` language en/es · `<f7>` read to section end (model stays hot)
· `<f8>` dictate (once = pause+record, again = stop+insert+resume) · `<f9>`
pause/resume · `M-<f9>` stop · `<f10>`/`<f12>` slower/faster · `M-<f12>` reset.
A header-line shows `🎙 Dictation — EN/ES`. Works in **Org, Markdown and QMD**
(sections split on headings); comments use `# …` in Org and `<!-- … -->` in
Markdown/QMD so they never export.

**Setup with uv:**

```bash
# player + recorder (system packages)
sudo apt install mpv alsa-utils curl          # arecord is in alsa-utils

# TTS: pocket-tts (Kyutai) — the default engine, run as a warm server
uv tool install pocket-tts                     # or just rely on `uvx pocket-tts`

# STT: Parakeet server deps into a uv env (heavy: pulls torch)
uv venv ~/.venvs/parakeet
uv pip install --python ~/.venvs/parakeet -r scripts/requirements.txt
```

- **TTS** defaults to pocket-tts started via `uvx pocket-tts serve`
  (`e6/readback-pocket-serve-command`). Spanish uses the `lola` voice with the
  `spanish_24l` model; English uses `alba`. Change these in the *Settings* block
  of `Config.org` (`e6/readback-pocket-voice-en` / `-es`,
  `e6/readback-pocket-language-en` / `-es`).
- **STT**: if `uv` is on PATH, `e6/readback-server-command` defaults to
  `("uv" "run" "--with" "nemo_toolkit[asr]" "python")`, so the Parakeet server
  works with no venv (first run downloads torch, cached after). To use the pinned
  venv above instead:
  ```elisp
  (setq e6/readback-server-command '("/home/YOU/.venvs/parakeet/bin/python"))
  ```
- **Prefer Piper** (e.g. for English speed)? `(setq e6/readback-tts-engine 'piper)`,
  then `uv tool install piper-tts` and put voice `.onnx` files under
  `~/.local/share/piper/` (`e6/readback-piper-voice-en` / `-es`).

> Python elsewhere in this config (Org-Babel `python` blocks, the inferior
> Python shell) is also routed through `uv run python` when uv is on PATH — see
> the "Python via uv" section in `Config.org`.

## Updating the minimal-emacs.d base

`init.el` and `early-init.el` are upstream files. To update them, re-copy the
two files from
[jamescherti/minimal-emacs.d](https://github.com/jamescherti/minimal-emacs.d),
review the diff, and commit. Do not edit them directly — customizations go in
`Config.org`.

## What's ignored by git

Installed packages (`elpa/`), compilation caches (`eln-cache/`, `*.elc`),
`custom.el`, and all per-machine state (backups, autosaves, `recentf.eld`,
history, etc.) are gitignored. Only `Config.org`, the vendored base, the tangled
`*-init.el`, and this documentation are tracked.
