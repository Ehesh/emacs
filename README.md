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
- **Fonts (optional, recommended):** the config uses **FiraCode Nerd Font**
  (monospace) and **Gentium Plus** (variable/prose). Both are guarded with
  `find-font`, so a machine missing either one falls back gracefully instead of
  erroring — if the font doesn't change, it isn't installed. Install them from
  the [Nerd Fonts](https://www.nerdfonts.com/) project and
  [SIL Gentium](https://software.sil.org/gentium/), then restart Emacs.
  Completion-list icons additionally need **Symbols Nerd Font Mono** (run
  `M-x nerd-icons-install-fonts`, then install the downloaded `.ttf`); until
  then those icons stay off (guarded), and everything else works normally.
- **External tools (later passes):** some features shell out to external
  programs (Quarto, himalaya, etc.); those are platform-guarded and documented
  in `Config.org` as they're added.

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
