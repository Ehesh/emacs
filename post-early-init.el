  ;;; post-early-init.el --- Early configurations -*- no-byte-compile: t; lexical-binding: t; -*-

(use-package modus-themes
  ;; :load-path "~/.emacs.d/src/modus-themes"
  :ensure
  :demand
  :init
(setq modus-themes-mode-line '(accented borderless)
      modus-themes-bold-constructs t
      modus-themes-italic-constructs t
      modus-themes-fringes 'subtle
      modus-themes-tabs-accented t
      modus-themes-paren-match '(bold intense)
      modus-themes-prompts '(bold intense)
      modus-themes-completions       '((matches . (extrabold underline))
                                       (selection . (semibold italic)))
      modus-themes-org-blocks 'tinted-background
      modus-themes-scale-headings t
      modus-themes-region '(bg-only)
      modus-themes-headings
      '((1 . (rainbow overline background 1.4))
        (2 . (rainbow background 1.3))
        (3 . (rainbow bold 1.2))
        (t . (semilight 1.1))))

;; Load the deuteranopia theme by default
(load-theme 'modus-operandi-deuteranopia t)
(setq modus-themes-to-toggle '(modus-operandi-deuteranopia modus-vivendi-deuteranopia))

)



(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

(use-package diminish)
  (elpaca-wait)

(add-to-list 'default-frame-alist '(alpha-background . 100)) ; For all new frames henceforth

;; (use-package general
;;   :config
;;   (general-evil-setup)
;;   
;;   ;; set up 'SPC' as the global leader key
;;   (general-create-definer dt/leader-keys
;;     :states '(normal insert visual emacs)
;;     :keymaps 'override
;;     :prefix "SPC" ;; set leader
;;     :global-prefix "M-SPC") ;; access leader in insert mode
;; 
;;   (dt/leader-keys
;;     "SPC" '(counsel-M-x :wk "Counsel M-x")
;;     "." '(find-file :wk "Find file")
;;     "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
;;     "TAB TAB" '(comment-line :wk "Comment lines")
;;     "u" '(universal-argument :wk "Universal argument"))
;; 
;;   (dt/leader-keys
;;     "b" '(:ignore t :wk "Bookmarks/Buffers")
;;     "b b" '(switch-to-buffer :wk "Switch to buffer")
;;     "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
;;     "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
;;     "b d" '(bookmark-delete :wk "Delete bookmark")
;;     "b i" '(ibuffer :wk "Ibuffer")
;;     "b k" '(kill-current-buffer :wk "Kill current buffer")
;;     "b K" '(kill-some-buffers :wk "Kill multiple buffers")
;;     "b l" '(list-bookmarks :wk "List bookmarks")
;;     "b m" '(bookmark-set :wk "Set bookmark")
;;     "b n" '(next-buffer :wk "Next buffer")
;;     "b p" '(previous-buffer :wk "Previous buffer")
;;     "b r" '(revert-buffer :wk "Reload buffer")
;;     "b R" '(rename-buffer :wk "Rename buffer")
;;     "b s" '(basic-save-buffer :wk "Save buffer")
;;     "b S" '(save-some-buffers :wk "Save multiple buffers")
;;     "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))
;; 
;;   (dt/leader-keys
;;     "d" '(:ignore t :wk "Dired")
;;     "d d" '(dired :wk "Open dired")
;;     "d f" '(wdired-finish-edit :wk "Writable dired finish edit")
;;     "d j" '(dired-jump :wk "Dired jump to current")
;;     "d n" '(neotree-dir :wk "Open directory in neotree")
;;     "d p" '(peep-dired :wk "Peep-dired")
;;     "d w" '(wdired-change-to-wdired-mode :wk "Writable dired"))
;; 
;;   (dt/leader-keys
;;     "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")    
;;     "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
;;     "e d" '(eval-defun :wk "Evaluate defun containing or after point")
;;     "e e" '(eval-expression :wk "Evaluate and elisp expression")
;;     "e f" '(ediff-files :wk "Run ediff on a pair of files")
;;     "e F" '(ediff-files3 :wk "Run ediff on three files")
;;     "e h" '(counsel-esh-history :which-key "Eshell history")
;;     "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
;;     "e r" '(eval-region :wk "Evaluate elisp in region")
;;     "e R" '(eww-reload :which-key "Reload current page in EWW")
;;     "e s" '(eshell :which-key "Eshell")
;;     "e w" '(eww :which-key "EWW emacs web wowser"))
;; 
;;   (dt/leader-keys
;;     "f" '(:ignore t :wk "Files")    
;;     "f c" '((lambda () (interactive)
;;               (find-file "~/.emacs.d/config.org")) 
;;             :wk "Open emacs config.org")
;;     "f e" '((lambda () (interactive)
;;               (dired "~/.emacs.d/")) 
;;             :wk "Open user-emacs-directory in dired")
;;     "f d" '(find-grep-dired :wk "Search for string in files in DIR")
;;     "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
;;     "f i" '((lambda () (interactive)
;;               (find-file "~/.emacs.d/init.el")) 
;;             :wk "Open emacs init.el")
;;     "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
;;     "f l" '(counsel-locate :wk "Locate a file")
;;     "f r" '(counsel-recentf :wk "Find recent files")
;;     "f u" '(sudo-edit-find-file :wk "Sudo find file")
;;     "f U" '(sudo-edit :wk "Sudo edit file"))
;; 
;;   (dt/leader-keys
;;     "g" '(:ignore t :wk "Git")    
;;     "g /" '(magit-displatch :wk "Magit dispatch")
;;     "g ." '(magit-file-displatch :wk "Magit file dispatch")
;;     "g b" '(magit-branch-checkout :wk "Switch branch")
;;     "g c" '(:ignore t :wk "Create") 
;;     "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
;;     "g c c" '(magit-commit-create :wk "Create commit")
;;     "g c f" '(magit-commit-fixup :wk "Create fixup commit")
;;     "g C" '(magit-clone :wk "Clone repo")
;;     "g f" '(:ignore t :wk "Find") 
;;     "g f c" '(magit-show-commit :wk "Show commit")
;;     "g f f" '(magit-find-file :wk "Magit find file")
;;     "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
;;     "g F" '(magit-fetch :wk "Git fetch")
;;     "g g" '(magit-status :wk "Magit status")
;;     "g i" '(magit-init :wk "Initialize git repo")
;;     "g l" '(magit-log-buffer-file :wk "Magit buffer log")
;;     "g r" '(vc-revert :wk "Git revert file")
;;     "g s" '(magit-stage-file :wk "Git stage file")
;;     "g t" '(git-timemachine :wk "Git time machine")
;;     "g u" '(magit-stage-file :wk "Git unstage file"))
;; 
;;  (dt/leader-keys
;;     "h" '(:ignore t :wk "Help")
;;     "h a" '(counsel-apropos :wk "Apropos")
;;     "h b" '(describe-bindings :wk "Describe bindings")
;;     "h c" '(describe-char :wk "Describe character under cursor")
;;     "h d" '(:ignore t :wk "Emacs documentation")
;;     "h d a" '(about-emacs :wk "About Emacs")
;;     "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
;;     "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
;;     "h d m" '(info-emacs-manual :wk "The Emacs manual")
;;     "h d n" '(view-emacs-news :wk "View Emacs news")
;;     "h d o" '(describe-distribution :wk "How to obtain Emacs")
;;     "h d p" '(view-emacs-problems :wk "View Emacs problems")
;;     "h d t" '(view-emacs-todo :wk "View Emacs todo")
;;     "h d w" '(describe-no-warranty :wk "Describe no warranty")
;;     "h e" '(view-echo-area-messages :wk "View echo area messages")
;;     "h f" '(describe-function :wk "Describe function")
;;     "h F" '(describe-face :wk "Describe face")
;;     "h g" '(describe-gnu-project :wk "Describe GNU Project")
;;     "h i" '(info :wk "Info")
;;     "h I" '(describe-input-method :wk "Describe input method")
;;     "h k" '(describe-key :wk "Describe key")
;;     "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
;;     "h L" '(describe-language-environment :wk "Describe language environment")
;;     "h m" '(describe-mode :wk "Describe mode")
;;     "h r" '(:ignore t :wk "Reload")
;;     "h r r" '((lambda () (interactive)
;;                 (load-file "~/.emacs.d/init.el")
;;                 (ignore (elpaca-process-queues)))
;;               :wk "Reload emacs config")
;;     "h t" '(load-theme :wk "Load theme")
;;     "h v" '(describe-variable :wk "Describe variable")
;;     "h w" '(where-is :wk "Prints keybinding for command if set")
;;     "h x" '(describe-command :wk "Display full documentation for command"))
;; 
;;   (dt/leader-keys
;;     "m" '(:ignore t :wk "Org")
;;     "m a" '(org-agenda :wk "Org agenda")
;;     "m e" '(org-export-dispatch :wk "Org export dispatch")
;;     "m i" '(org-toggle-item :wk "Org toggle item")
;;     "m t" '(org-todo :wk "Org todo")
;;     "m B" '(org-babel-tangle :wk "Org babel tangle")
;;     "m T" '(org-todo-list :wk "Org todo list"))
;; 
;;   (dt/leader-keys
;;     "m b" '(:ignore t :wk "Tables")
;;     "m b -" '(org-table-insert-hline :wk "Insert hline in table"))
;; 
;;   (dt/leader-keys
;;     "m d" '(:ignore t :wk "Date/deadline")
;;     "m d t" '(org-time-stamp :wk "Org time stamp"))
;; 
;;   (dt/leader-keys
;;     "o" '(:ignore t :wk "Open")
;;     "o d" '(dashboard-open :wk "Dashboard")
;;     "o e" '(elfeed :wk "Elfeed RSS")
;;     "o f" '(make-frame :wk "Open buffer in new frame")
;;     "o F" '(select-frame-by-name :wk "Select frame by name"))
;; 
;;   ;; projectile-command-map already has a ton of bindings 
;;   ;; set for us, so no need to specify each individually.
;;   (dt/leader-keys
;;     "p" '(projectile-command-map :wk "Projectile"))
;;   
;;   (dt/leader-keys
;;     "r" '(:ignore t :wk "Radio")
;;     "r p" '(eradio-play :wk "Eradio play")
;;     "r s" '(eradio-stop :wk "Eradio stop")
;;     "r t" '(eradio-toggle :wk "Eradio toggle"))
;; 
;; 
;;   (dt/leader-keys
;;     "s" '(:ignore t :wk "Search")
;;     "s d" '(dictionary-search :wk "Search dictionary")
;;     "s m" '(man :wk "Man pages")
;;     "s o" '(pdf-occur :wk "Pdf search lines matching STRING")
;;     "s t" '(tldr :wk "Lookup TLDR docs for a command")
;;     "s w" '(woman :wk "Similar to man but doesn't require man"))
;; 
;;   (dt/leader-keys
;;     "t" '(:ignore t :wk "Toggle")
;;     "t e" '(eshell-toggle :wk "Toggle eshell")
;;     "t f" '(flycheck-mode :wk "Toggle flycheck")
;;     "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
;;     "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
;;     "t o" '(org-mode :wk "Toggle org mode")
;;     "t r" '(rainbow-mode :wk "Toggle rainbow mode")
;;     "t t" '(visual-line-mode :wk "Toggle truncated lines")
;;     "t v" '(vterm-toggle :wk "Toggle vterm"))
;; 
;;   (dt/leader-keys
;;     "w" '(:ignore t :wk "Windows/Words")
;;     ;; Window splits
;;     "w c" '(evil-window-delete :wk "Close window")
;;     "w n" '(evil-window-new :wk "New window")
;;     "w s" '(evil-window-split :wk "Horizontal split window")
;;     "w v" '(evil-window-vsplit :wk "Vertical split window")
;;     ;; Window motions
;;     "w h" '(evil-window-left :wk "Window left")
;;     "w j" '(evil-window-down :wk "Window down")
;;     "w k" '(evil-window-up :wk "Window up")
;;     "w l" '(evil-window-right :wk "Window right")
;;     "w w" '(evil-window-next :wk "Goto next window")
;;     ;; Move Windows
;;     "w H" '(buf-move-left :wk "Buffer move left")
;;     "w J" '(buf-move-down :wk "Buffer move down")
;;     "w K" '(buf-move-up :wk "Buffer move up")
;;     "w L" '(buf-move-right :wk "Buffer move right")
;;     ;; Words
;;     "w d" '(downcase-word :wk "Downcase word")
;;     "w u" '(upcase-word :wk "Upcase word")
;;     "w =" '(count-words :wk "Count words/lines for buffer"))
;; )

(define-key minibuffer-local-map (kbd "C-i") 'next-line)
(define-key minibuffer-local-map (kbd "C-k") 'next-line)

(defun meow-setup ()
    (meow-motion-overwrite-define-key
     '("j" . meow-next) 
     '("k" . meow-prev) 
     '("SPC" . my-transient-menu)
     '("<escape>" . ignore))

    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
;;     '("SPC" . my-transient-menu)
     '("j" . "H-j")
     '("k" . "H-k")
;;     '("SPC" . e6-meow-leader)
;;      ;; --- File Navigation ---
;;      '("." . find-file) 
;;      '("=" . perspective-map)
;;      ;; --- Editing ---
;;      '("TAB" . comment-line)
;;      '("u" . universal-argument)
;;      ;; Use SPC (0-9) for digit arguments.
;;      '("1" . meow-digit-argument)
;;      '("2" . meow-digit-argument)
;;      '("3" . meow-digit-argument)
;;      '("4" . meow-digit-argument)
;;      '("5" . meow-digit-argument)
;;      '("6" . meow-digit-argument)
;;      '("7" . meow-digit-argument)
;;      '("8" . meow-digit-argument)
;;      '("9" . meow-digit-argument)
;;      '("0" . meow-digit-argument)
;;      ;; --- Meow Help ---
;;      '("/" . meow-keypad-describe-key)
;;      '("?" . meow-cheatsheet)
;; 
;;      ;; --- Transient Menu Example (Buffers) ---
;;      '("b" . e6-buffer-menu)
     )
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . execute-extended-command)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . kill-ring-save)
    ;; '("d" . meow-delete)
    ;; '("D" . meow-backward-delete)
     '("e" . meow-append)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-backward-delete)
     '("H" . meow-delete)
     '("i" . meow-prev)
     '("I" . meow-open-above)
     '("j" . meow-back-word)
     '("J" . meow-back-expand)
     '("k" . meow-next)
     '("K" . meow-open-below)
     '("l" . meow-next-word)
     '("L" . meow-expand-next-word)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-inner-of-thing)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-grab)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . clipboard-yank)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-kill)
     '("X" . meow-goto-line)
     '("y" . undo-redo)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)
     '("SPC" . my-transient-menu)
))

  (use-package meow
 
  :ensure t
  :config
  ;; set colors in theme
  (setq meow-use-dynamic-face-color nil)
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (setq meow-keypad-leader-dispatch nil) 
  
;;;; Cool cursor stuffs
;; (defun meow--update-cursor-custom ()
;;   (progn
;;     (meow--set-cursor-type 'hollow)
;;     (meow--set-cursor-color 'meow-insert-cursor)))
;; (add-to-list 'meow-update-cursor-functions-alist
;;              '((lambda () (and (meow-insert-mode-p)
;;                                (eq major-mode 'org-mode)))
;;                . meow--update-cursor-custom))

  (meow-setup)
  (meow-global-mode 1))

(global-set-key [escape] 'keyboard-escape-quit)
