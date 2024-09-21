  ;;; pre-early-init.el --- Early configurations -*- no-byte-compile: t; lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "1f669e8abe4dc2855268c9a607b5e350e2811b3c5afd09af5939ff0c01a89c5a" default))
 '(package-selected-packages
   '(doom-modeline ivy-rich all-the-icons-ivy-rich flycheck dashboard all-the-icons))
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "smtp.1and1.com")
 '(smtpmail-smtp-service 587))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
;;  '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
;;  '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
;;  '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
;;  '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
;;  '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
;;  '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(setq default-directory "G:/Other computers/Lenny/Documents/Story-Weaver")

(add-to-list 'load-path "~/.emacs.d/var/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager
(require 'buffer-move)   ;; Buffer-move for better window management
(require 'app-launchers) ;; Use emacs as a run launcher like dmenu (experimental)

;; Reducing clutter in ~/.emacs.d by redirecting files to ~/emacs.d/var/
(setq minimal-emacs-var-dir (expand-file-name "var/" minimal-emacs-user-directory))
;;(setq package-user-dir (expand-file-name "elpa" minimal-emacs-var-dir))
;;(setq package-user-dir (expand-file-name "elpaca" minimal-emacs-var-dir))
(setq user-emacs-directory minimal-emacs-var-dir)

  (global-prettify-symbols-mode t)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(setq use-file-dialog nil)   ;; No file dialog
(setq use-dialog-box nil)    ;; No dialog box
(setq pop-up-windows nil)    ;; No popup windows

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))
