  ;;; post-init.el --- Early configurations -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package dashboard
  :demand t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Eheshiu's cute EMACS!")
  (setq dashboard-startup-banner "~/.emacs.d/var/images/catboy050.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

(setq ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain)

(defun dt-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))

(add-hook 'ediff-mode-hook 'dt-ediff-hook)

(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                       (("https://www.reddit.com/r/linux.rss" reddit linux)
                        ("https://www.reddit.com/r/commandline.rss" reddit commandline)
                        ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
                        ("https://www.reddit.com/r/emacs.rss" reddit emacs)
                        ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
                        ("https://hackaday.com/blog/feed/" hackaday linux)
                        ("https://opensource.com/feed" opensource linux)
                        ("https://linux.softpedia.com/backend.xml" softpedia linux)
                        ("https://itsfoss.com/feed/" itsfoss linux)
                        ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
                        ("https://www.phoronix.com/rss.php" phoronix linux)
                        ("http://feeds.feedburner.com/d0od" omgubuntu linux)
                        ("https://www.computerworld.com/index.rss" computerworld linux)
                        ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
                        ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
                        ("https://betanews.com/feed" betanews linux)
                        ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
                        ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))
 

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package eradio
  :init
  (setq eradio-player '("mpv" "--no-video" "--no-terminal"))
  :config
  (setq eradio-channels '(("Totally 80s FM" . "https://zeno.fm/radio/totally-80s-fm/")
                          ("Oldies Radio 50s-60s" . "https://zeno.fm/radio/oldies-radio-50s-60s/")
                          ("Oldies Radio 70s" . "https://zeno.fm/radio/oldies-radio-70s/")
                          ("Unlimited 80s" . "https://zeno.fm/radio/unlimited80s/")
                          ("80s Hits" . "https://zeno.fm/radio/80shits/")
                          ("90s Hits" . "https://zeno.fm/radio/90s_HITS/")
                          ("2000s Pop" . "https://zeno.fm/radio/2000s-pop/")
                          ("The 2000s" . "https://zeno.fm/radio/the-2000s/")
                          ("Hits 2010s" . "https://zeno.fm/radio/helia-hits-2010/")
                          ("Classical Radio" . "https://zeno.fm/radio/classical-radio/")
                          ("Classical Relaxation" . "https://zeno.fm/radio/radio-christmas-non-stop-classical/")
                          ("Classic Rock" . "https://zeno.fm/radio/classic-rockdnb2sav8qs8uv/")
                          ("Gangsta49" . "https://zeno.fm/radio/gangsta49/")
                          ("HipHop49" . "https://zeno.fm/radio/hiphop49/")
                          ("Madhouse Country Radio" . "https://zeno.fm/radio/madhouse-country-radio/")
                          ("PopMusic" . "https://zeno.fm/radio/popmusic74vyurvmug0uv/")
                          ("PopStars" . "https://zeno.fm/radio/popstars/")
                          ("RadioMetal" . "https://zeno.fm/radio/radio-metal/")
                          ("RocknRoll Radio" . "https://zeno.fm/radio/rocknroll-radio994c7517qs8uv/"))))

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

;; (use-package flyspell
;;   :custom
;;   (ispell-program-name "hunspell")
;;   (ispell-dictionary ews-hunspell-dictionaries)
;;   (flyspell-mark-duplications-flag nil) ;; Writegood mode does this
;;   (org-fold-core-style 'overlays) ;; Fix Org mode bug
;;   :config
;;   (ispell-set-spellchecker-params)
;;   (ispell-hunspell-add-multi-dic ews-hunspell-dictionaries)
;;   :hook
;;   (text-mode . flyspell-mode)
;;   :bind
;;   (("C-c w s s" . ispell)
;;    ("C-;"       . flyspell-auto-correct-previous-word)))

;; (use-package dictionary
;;   :custom
;;   (dictionary-server "dict.org")
;;   :bind
;;   (("C-c w s d" . dictionary-lookup-definition)))
;; 
;; (use-package powerthesaurus
;;   :bind
;;   (("C-c w s p" . powerthesaurus-transient))
;;)

  (use-package undo-tree
    :diminish undo-tree-mode
    :config
    (global-undo-tree-mode)
    :custom
    (undo-tree-auto-save-history nil)
    :bind
    (("C-c w u" . undo-tree-visualise)))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

;;(use-package dart-mode)
;;(use-package haskell-mode)
;;(use-package lua-mode)
;;(use-package php-mode)

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(require 'org-tempo)

(setq org-src-preserve-indentation t)

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(use-package org-modern
  ;; :custom
  ;; (org-modern-keyword nil)
  ;; (org-modern-checkbox nil)
  ;; (org-modern-table nil)
  :config
  (setq
    ;; Edit settings

    org-auto-align-tags nil
    org-tags-column 0
    org-catch-invisible-edits 'show-and-error
    org-insert-heading-respect-content t
  
    org-modern-star 'replace

  ;;   org-hide-emphasis-markers t
  ;;  org-pretty-entities t

    ;; Agenda styling
    org-agenda-tags-column 0
    org-agenda-block-separator ?─
    org-agenda-time-grid
    '((daily today require-timed)
      (800 1000 1200 1400 1600 1800 2000)
      " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
    org-agenda-current-time-string
    "◀── now ─────────────────────────────────────────────────")

    ;; Ellipsis styling
    (setq org-ellipsis "…")
    (set-face-attribute 'org-ellipsis nil :inherit 'default :box nil)
    (global-org-modern-mode))




(use-package org-modern-indent
  :ensure (org-modern-indent :host github :repo "jdtsmith/org-modern-indent")
  :hook (org-mode . org-modern-indent-mode)
 )

(elpaca
  '(org-menu
    :host github
    :repo "sheijk/org-menu"))

(use-package org-appear
 :after org
 :hook (org-mode-hook . org-appear-mode))

(use-package writegood-mode
  ;; :bind
 ;; (("C-c w s r" . writegood-reading-ease)
 ;;  ("C-c w s l" . writegood-grade-level))
  ;; :hook
  ;; (text-mode . writegood-mode)
)

(use-package pdf-tools
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  ;; :bind (: pdf-view-mode-map
  ;;             ("j" . pdf-view-next-line-or-next-page)
  ;;             ("k" . pdf-view-previous-line-or-previous-page)
  ;;             ("C-=" . pdf-view-enlarge)
  ;;             ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)
             (blink-cursor-mode -1)
             (doom-modeline-mode -1)))

(use-package perspective
  :custom
  ;; NOTE! I have also set 'SCP =' to open the perspective menu.
  ;; I'm only setting the additional binding because setting it
  ;; helps suppress an annoying warning message.
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :init 
  (persp-mode)
  :config
  ;; Sets a file to write to when we save states
  (setq persp-state-default-file "~/.emacs.d/sessions"))

;; This will group buffers by persp-name in ibuffer.
(add-hook 'ibuffer-hook
          (lambda ()
            (persp-ibuffer-set-filter-groups)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;; Automatically save perspective states to file when Emacs exits.
(add-hook 'kill-emacs-hook #'persp-state-save)

(use-package projectile
  :config
  (projectile-mode 1))

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package sudo-edit)

(use-package tldr)

;; Now you can use use-package to install and configure packages


(use-package transient)       
   
(elpaca-wait)
 
(transient-define-prefix my-transient-menu ()
  "A sample transient menu."
  [["Basic Commands"
    ("SPC" "consult-outl" (lambda () (interactive) (consult-outline)))
    ("o" "org-menu" (lambda () (interactive) (org-menu)))]
   ["Other Commands"
      ("TAB" "next window" next-window-any-frame)
    ("y" "Action Y" (lambda () (interactive) (message "Action Y executed!")))]
   ["Exit"
    ("<escape>" "" transient-quit-one)]])

;; Define the function to change the modeline color based on the meow state
(defun my-update-modeline-color-based-on-meow-state ()
  "Update the moody modeline color based on the state of Meow."
  (let ((insert-state-color  (modus-themes-get-color-value 'bg-sage))  ;; Green color for insert mode
        ;; Use modus theme aliases for the modeline in normal state
        (normal-state-color (modus-themes-get-color-value 'bg-mode-line-active)))
    (if (meow-insert-mode-p)
        ;; Change to green in insert mode
        (set-face-attribute 'mode-line nil :background insert-state-color)
      ;; Revert to the original alias from the Modus theme
      (set-face-attribute 'mode-line nil :background normal-state-color))))

;; Add the function to the meow state change hooks
(add-hook 'meow-insert-enter-hook #'my-update-modeline-color-based-on-meow-state)
(add-hook 'meow-insert-exit-hook #'my-update-modeline-color-based-on-meow-state)

;; Optionally hook into normal mode to ensure the color is reset there too
(add-hook 'meow-normal-enter-hook #'my-update-modeline-color-based-on-meow-state)

(use-package moody
  :config
  (moody-replace-mode-line-front-space)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(use-package minions
:config
	(setq minions-mode-line-lighter ""
				minions-mode-line-delimiters '("" . ""))
 (minions-mode 1))

;; Auto-revert in Emacs is a feature that automatically updates the
;; contents of a buffer to reflect changes made to the underlying file
;; on disk.
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; recentf is an Emacs package that maintains a list of recently
;; accessed files, making it easier to reopen files you have worked on
;; recently.
(add-hook 'after-init-hook #'recentf-mode)

;; savehist is an Emacs feature that preserves the minibuffer history between
;; sessions. It saves the history of inputs in the minibuffer, such as commands,
;; search strings, and other prompts, to a file. This allows users to retain
;; their minibuffer history across Emacs restarts.
(add-hook 'after-init-hook #'savehist-mode)

;; save-place-mode enables Emacs to remember the last location within a file
;; upon reopening. This feature is particularly beneficial for resuming work at
;; the precise point where you previously left off.
(add-hook 'after-init-hook #'save-place-mode)

(defun reader ()
  (interactive)
  (let ((choices '(("First"  . "Hi!")
                   ("Second" . 'second-choice)
                   ("Third"  . 'third-choice))))
    (alist-get
     (completing-read "Choose: " choices)
     choices nil nil 'message)))

(defun github-code-search ()
  "Search code on github for a given language."
  (interactive)
  (let ((language (completing-read
                   "Language: "
                   '("Emacs Lisp" "Python"  "Clojure" "R")))
        (code (read-string "Code: ")))
    (browse-url
     (concat "https://github.com/search?l=" language
             "&type=code&q=" code))))
  
(defun dm-search ()
  "Search various search engines."
  (interactive)
  (let ((engine (completing-read
                 "Search Engine: "
                 '("Arch Wiki" 
                   "Bing"
                   "Google"
                   "Wikipedia")))
        (query (read-string "Query: ")))
    (if (equal engine "Google")
      (browse-url
       (concat "https://www.google.com/search?q=" query)))))

(defun dt/key-value-completing (choice)                                     
  (interactive
   (list
    (let ((completions '(("1" "One") 
                         ("2" "Two")
                         ("3" "Three"))))              
      (cadr (assoc (completing-read "Choose: " completions) completions)))))
  (message "You choose `%s'" choice))
