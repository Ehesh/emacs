# Emacs Do-Over — Implementation Spec (v2, decisions closed)

This is the final spec from the question session. Everything is now decided — the two items previously parked (meow vs meep, email auth) are closed below. It's self-contained so it can be handed to Claude Code (or done here) as the plan for Session 1 onward.

---

## A. Locked decisions

| Topic | Decision |
|---|---|
| Base | Install **jamescherti/minimal-emacs.d** (not yet downloaded). |
| Package manager | **package.el + use-package** (not Elpaca) — see §B2. |
| Look | **nano-theme + nano-modeline**, layered — *not* full nano-emacs (§B1). **Aesthetic priority: a genuinely modern look — no "90s Emacs".** |
| Config style | **Literate** — one clean, heavily-commented `Config.org` that tangles to the minimal-emacs.d files. |
| Fonts | **Keep both** — FiraCode Nerd Font (mono) + Gentium Plus (variable). |
| Modal editing | **meow** (locked) — replace all Evil leftovers; layout tuned for prose/navigation, not coding. |
| Keys/discoverability | **which-key** for cheap lookups + **transient** for curated menus (§B3). |
| Fleeting ideas | **`inbox.org` + one-key `org-capture`.** |
| Org learning | **Include a hands-on "Org & notes starter guide"** (`.org` in the config). |
| Git | **Add Magit** — you started using git this week. |
| elfeed | **Keep**, feeds rebuilt around **linguistics** (LINGUIST List etc. — §G). |
| Ghostel | **Keep, Linux-only** (native module won't build on Windows; OS-guarded — §E). |
| dired-open → external apps | **Keep, made cross-platform.** |
| Transient menus | **Yes — continue the migration**, rebuilt clean (§B3). |
| org-transclusion | **Add** (notes/thesis assembly by reference). |
| drag-stuff | **Keep** (`M-arrows` to move lines/regions). |
| Email | **himalaya** (cross-platform), **Gmail app password + 2FA for now** (OAuth deferred — §B5). |
| Export toolchain | **Quarto** (installed, not raw pandoc); **no LaTeX**; **sometimes Typst**. → adds `quarto-mode` + `ox-typst`; drops AUCTeX/ox-pandoc. |
| "Session menu" | Interpreting as **perspective session save/restore + your transient scaffold** — ✎ *confirm if you meant something else.* |

---

## B. Answers to the questions you asked (kept for the record)

### B1. Full nano would make you relearn a lot
`rougier/nano-emacs` is a whole clone-and-load config framework: its own keybindings (would collide with meow/transient), its own header-line layout and splash, its own stack choices, and it's opinionated/slow-moving. **nano-theme + nano-modeline** (both on GNU ELPA) give ~90% of the *look* while you keep your keys and packages. That's what §C assumes.

### B2. package.el vs Elpaca — **locked: package.el**
Elpaca's real edge is async installs + easy GitHub packages, not config size. For you it loses on **Windows reliability** (git/symlink/async flakiness), the GitHub gap is already covered by `use-package :vc`, and minimal-emacs.d is built around package.el. So: package.el + use-package.

### B3. Transient — yes, continue
It's built-in, self-documenting, and perfect when you're not coding daily. Two rules so it stays maintainable: (1) don't hand-build transients that merely duplicate a key lookup — which-key does that free; reserve transients for grouped/multi-step menus (notes, research, export, toggles). (2) Let meow's leader/keypad **dispatch into** those transients, so it feels like one command palette.

### B4. drag-stuff — kept
Moves the current line / region / word with `M-<up/down/left/right>`. Handy for reordering prose. Harmless; drop later only if meow's own line-moving makes it redundant.

### B5. Email — himalaya, app password
Nano's "mu thing" is **mu4e**, which needs `mu` — effectively Linux/macOS only, so it's out for a Windows+Linux setup. **himalaya** (one cross-platform Rust binary) is the right pick; we style its Emacs buffers to look nano-clean. On auth: himalaya's OAuth2 is fragile (needs a binary built with the `oauth2` feature; the project has floated moving OAuth out), so **your choice of Gmail app password + 2FA is the reliable path.** (App passwords require 2-factor turned on for the Google account.) OAuth stays an aspiration we can revisit later.

---

## C. Final package plan (keep / cut / add)

### Keep (cleaned up)
- **Completion core:** vertico, orderless, marginalia, consult, corfu, cape, embark, embark-consult, kind-icon, nerd-icons-completion
- **UI:** fontaine (+ your two fonts), nerd-icons, nerd-icons-dired, which-key, hl-todo, rainbow-mode, rainbow-delimiters
- **Org:** org-modern, org-modern-indent, org-appear, toc-org, org-tempo
- **Writing/research:** citar, citar-embark, writeroom-mode, writegood-mode, pdf-tools
- **Workflow:** perspective, drag-stuff, elfeed (+ elfeed-goodies), diminish
- **Sane-defaults + after-init hooks** (recentf, savehist, save-place, auto-revert)

### Cut
- **Dead/broken:** all `counsel-*` bindings, all Evil references, the malformed `undo-tree` block, the stray double `#+end_src`
- **Linux-news elfeed feeds** (→ linguistics feeds, §G)
- **eradio**, **app-launchers/dmenu**, **shell-color-scripts**, the **TEST** section, the **half-built transient menus** (rebuilt clean), the commented **eshell-toggle/vterm** cruft

### Add
- **nano-theme + nano-modeline** (the look)
- **Magit** (Git)
- **org-capture** + `inbox.org` (fleeting ideas)
- **org-transclusion**
- **Org & notes starter guide** (`guide.org`)
- **Research tooling** (research session, yes/no each): org-noter (PDF annotation), jinx (Spanish+English spellcheck), an IPA/Unicode input method
- **Export matched to your tools:** `quarto-mode` (edit/preview `.qmd`) + `ox-typst` (Org→Typst) — **not** AUCTeX/ox-pandoc
- **Editor-layout / AI-piping helper** — a tidy command + menu entry wrapping `shell-command-on-region` (`M-|`) to send region/buffer to an external CLI agent and get the result back (designed at the editing session)

---

## C-bis. Org plugins for a modern look (your stated priority)

Curated for "modern, low-maintenance, researcher, not a coder."

**Biggest look wins (add by default):**
- **org-modern** *(already in)* — modern headings, tags, blocks, tables.
- **mixed-pitch** *(new — top pick)* — prose in Gentium, code/tables in FiraCode. The single change that makes Org read like a typeset document instead of a config file.
- **valign** *(new)* — pixel-aligns table columns under a variable-pitch font, so glossing/example tables look crisp. (Can lag on very large tables; easy to toggle.)
- **spacious-padding** *(new — look session)* — airy internal padding/borders; not Org-specific but a huge modernizer, pairs perfectly with nano.
- **org-appear** *(already in)* — hides emphasis markers until the cursor is on them.

**Researcher quality-of-life:**
- **org-download** *(new)* — drag/paste images (figures, PDF screenshots) into notes.
- **org-noter**, **citar**, **org-transclusion** *(already planned)*.
- **org-web-tools** *(new, optional)* — save a web article as a clean Org note.

**Export (your tools):**
- **quarto-mode**, **ox-typst** *(new)* — per §C.

**Deliberately skipped** (fit your "rarely review notes" habit): org-roam / org-roam-ui (backlink database — too archivist), org-super-agenda (heavy agenda you won't live in), org-bullets (org-modern supersedes it).

---

## D. Previously parked — now decided
- **Modal editing → meow.** We salvage/clean your existing meow setup into a coherent prose/navigation layout; the config stays modal-agnostic so a future swap to meep would be one contained session, not a rewrite.
- **Email auth → Gmail app password + 2FA** for now (§B5).

---

## E. Cross-platform + Git strategy
- **Single config, two machines:** make `.emacs.d` a **git repo** (doubles as git practice). Track `Config.org`, tangled `*-init.el`, `early-init.el`/`init.el`; **gitignore `var/`**. Sync by pull/push.
- **Emacs dir:** Windows `C:\Users\Usuario\AppData\Roaming\.emacs.d` (your connected folder); Linux `~/.emacs.d`. Same repo cloned to each.
- **OS guards:** platform-specific bits wrapped in `(when (eq system-type 'gnu/linux) …)` / `'windows-nt` — that's how Ghostel and the external-open commands live in one config without breaking the other machine.
- **Fonts:** set FiraCode + Gentium but check `find-font` first so a machine missing a font falls back instead of erroring. ✎ *Are both fonts installed on both machines?*

---

## F. Session 1 — Bootstrap (concrete spec)

**Goal:** a minimal, verified Emacs that boots cleanly on **both** OSes on the package.el foundation. Not pretty yet — just solid ground.

**Steps**
1. **Back up** the current `Config.org` (copy to `Config.org.bak` and commit it).
2. **Install minimal-emacs.d**: clone its `early-init.el` + `init.el` into the emacs dir. Init the git repo; add `.gitignore` (§E).
3. **Create the four extension files** as near-empty stubs with correct headers: `pre-early-init.el`, `post-early-init.el`, `pre-init.el`, `post-init.el`.
4. **Start the new `Config.org`** (literate): auto-tangle-on-save, package.el/use-package bootstrap, `var/` redirection, sane defaults, backups→`var/backups`, OS-guard helpers. **Remove** every Elpaca artifact (`elpaca-setup`, `elpaca-wait`, `:ensure (… :host github …)` → `use-package :vc`).
5. **Fonts + a theme placeholder** so it's not jarring (full look is Session 2): load nano-theme, set fontaine preset with graceful fallback.
6. **Verify boot** on Linux and Windows: `emacs --debug-init` with **zero errors**, clean tangle, `M-x` works.

**Done-criteria**
- [ ] `.emacs.d` is a git repo with `var/` ignored
- [ ] `emacs --debug-init` → no errors/missing-file warnings on **both** OSes
- [ ] `Config.org` tangles on save; reload works
- [ ] package.el installs a test package (e.g. which-key)
- [ ] old config safely backed up

**Windows caveat:** a Sept-2026 Windows update currently blocks *this Cowork session's* direct shell into your `.emacs.d`. It does **not** affect Claude Code locally or you running Emacs yourself. If Session 1 runs here, expect a few "run this and paste the output" moments; in Claude Code that friction disappears.

---

## G. elfeed — linguistics starter feeds (prune freely)

```
;; LINGUIST List (linguistlist.org)
("https://linguistlist.org/issues/rss/calls"    ll cfp)          ; Calls for Papers
("https://linguistlist.org/issues/rss/confs"    ll conferences)
("https://linguistlist.org/issues/rss/jobs"     ll jobs)
("https://linguistlist.org/issues/rss/diss"     ll dissertations)
("https://linguistlist.org/issues/rss/books"    ll books)
("https://linguistlist.org/issues/rss/software" ll tools)        ; ← relevant to your IGT/CLDF work
("https://linguistlist.org/issues/rss/media"    ll media)
("https://linguistlist.org/issues/rss/toc"      ll journals)     ; Journal tables of contents
```

Candidate blogs to add (confirm which you'd read): **Language Log**, **All Things Linguistic**, any journal/newsletter feeds you follow. ✎ *Your must-haves?*

---

## Roadmap

0. **Decisions** — ✅ closed (this doc).
1. **Bootstrap** (§F) — minimal-emacs.d + package.el, boots clean on both OSes, git repo.
2. **Look & feel** — nano-theme + nano-modeline, fonts, mixed-pitch, spacious-padding, org-modern, UI.
3. **Editing core** — **meow** prose/navigation layout, rebuilt leader, which-key, transient menus rebuilt clean, Magit, the AI-piping helper.
4. **Org & notes** — org base, `inbox.org` + one-key capture, org-transclusion, valign, org-download, elfeed (linguistics feeds), the **starter guide**.
5. **Research tooling** — citar, pdf-tools, org-noter, jinx, IPA input, quarto-mode + ox-typst.
6. **Email** — himalaya CLI (both OSes) + Emacs integration, Gmail app password.
7. **Dashboard** *(parked, your call)* — vui.el vs textui.el.

The **"what does what" guide** grows section-by-section inside `Config.org` throughout.

---

*Open ✎ items (all non-blocking): what "session menu" meant, whether both fonts are on both machines, and your must-have blog feeds. Say "start Session 1" (here or in Claude Code) and this is the spec it follows.*
