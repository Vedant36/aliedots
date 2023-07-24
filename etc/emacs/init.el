;;;; Vedant36's emacs configuration
;;;; TODO: undo tree
;;;; mods: ivy,lsp(has eldoc like thing for other langs)
;;;; check out for rgb highlighting: emacs-color, rainbow-mode
;;;; check out for delemiters rainbow-delimiters: pair-colorizer
;;;; fix being able to get italics in comments

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

;;; builtins
;;;   interface cleanup
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode 1)
(idle-highlight-mode 1)
(setq display-line-numbers 'relative)
(setq fill-column 79)
;(display-line-numbers-mode)
;;;   convinience stuff
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(windmove-default-keybindings)
(electric-pair-mode 1)
;; SYSTEM_SPECIFIC::Save the "emacs autosaving" files to a seperate directory
(setq backup-directory-alist '(("." . "~/.local/var/lib/emacs")))
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

;;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;;; builtins
(use-package dired
  :ensure nil
  :config
  (add-hook 'dired-mode-hook 'auto-revert-mode)
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always))
(use-package org-mode
  :ensure nil
  :defer t
  :init
  (setq org-html-validation-link nil)
  (setq org-special-ctrl-a/e t)
  (setq org-startup-indented t)
  ;; to get >greentext in org-mode documents
  (defun u/greentext ()
    "Highlight >greentext in current buffer."
    (interactive)
    (highlight-lines-matching-regexp "^>" 'hi-green-b))
  (add-hook 'org-mode-hook 'u/greentext))
(use-package org-download
  :ensure org-download
  :config (setq org-download-screenshot-method "xclip -selection clipboard -t image/png -o > %s")
  :hook (dired-mode-hook . org-download-enable))

;;; themes
(use-package gruber-darker-theme)
(use-package gruvbox-theme
  :defer t)
;;; major modes
(use-package tex
  :defer t
  :ensure auctex)
(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4)
  :defer t)
(use-package company-graphviz-dot
  :ensure nil)
(use-package haskell-mode
  :commands (haskell-mode
	     haskell-session-change
	     haskell-interactive-switch))
(use-package highlight-indent-guides
  :hook prog-mode-hook
  :config
  (setq highlight-indent-guides-method 'character))
(use-package lua-mode
  :defer t)
;;; minor modes
(use-package paredit) ; for S-expr
(use-package cdlatex
  :hook (LaTeX-mode-hook . turn-on-cdlatex))
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->"         . mc/mark-next-like-this)
	 ("C-<"         . mc/mark-previous-like-this)
	 ("C-c C-<"     . mc/mark-all-like-this)
	 ("C-\""        . mc/skip-to-next-like-this)
	 ("C-:"         . mc/skip-to-previous-like-this))
  :config
  (require 'multiple-cursors))
(use-package rainbow-delimiters
  :hook (prog-mode-hook . rainbow-delimiters-mode)
  :config
  (require 'rainbow-delimiters)
  (set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")   ; red
  (set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")   ; green
  (set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")   ; blue
  (set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")   ; yellow
  (set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")   ; cyan
  (set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")   ; magenta
  (set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")   ; light gray
  (set-face-foreground 'rainbow-delimiters-depth-8-face "#999")   ; medium gray
  (set-face-foreground 'rainbow-delimiters-depth-9-face "#666"))  ; dark gray
(use-package sly
  :commands (sly sly-mode)
  :defer t
  :config
  (setq inferior-lisp-program "sbcl")
  (setq sly-command-switch-to-existing-lisp 'always))
(use-package sly-quicklisp
  :commands sly-quickload)
(use-package flycheck
  :commands flycheck-mode)
(use-package company
  :hook prog-mode
  :bind (:map company-active-map
	 ("C-n" . nil)
	 ("C-p" . nil)
	 ("M-n" . 'company-select-next)
	 ("M-p" . 'company-select-previous)
	 ("TAB" . company-complete-selection)
	 ("RET" . nil)))
(use-package yasnippet
  :commands (yas-reload-all yas-minor-mode)
  :hook (prog-mode-hook . yas-minor-mode)
  :config
  (yas-reload-all))
(use-package ligature
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers.  You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

;;; useful
(use-package helpful
  :bind (("C-h f" . #'helpful-callable)
	 ("C-h v" . #'helpful-variable)
	 ("C-h k" . #'helpful-key)))
(use-package smex
  :bind
  ("M-x"         . smex)
  ("M-X"         . smex-major-mode-commands)
  ("C-c C-c M-x" . execute-extended-command))
(use-package magit
  :defer magit)

;;; useless
(use-package evil
  :commands evil-mode
  :config
  (require 'evil)
  (evil-mode -1)
  (evil-emacs-state)
  (setq evil-default-state 'emacs))

;;; lcs: from https://www.kernel.org/doc/html/v4.10/process/coding-style.html
(add-hook 'c-mode-hook
	            (lambda () (local-set-key (kbd "C-c C-c") #'compile)))
(defvar c-syntactic-element)
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Add kernel style
	    (c-add-style
	     "linux-tabs-only"
	     '("linux" (c-offsets-alist
			(arglist-cont-nonempty
			 c-lineup-gcc-asm-reg
			 c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
	  (lambda ()
	    ;(let ((filename (buffer-file-name)))
	    ;  ;; Enable kernel mode for the appropriate files
	    ;  (when (and filename
	    ;             (string-match (expand-file-name "~/src/linux-trees")
	    ;                           filename))
	    (setq indent-tabs-mode t)
	    (setq show-trailing-whitespace t)
	    (c-set-style "linux-tabs-only")))

; Emacs sets shit below this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Zathura")
     (output-html "xdg-open")))
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("19a2c0b92a6aa1580f1be2deb7b8a8e3a4857b6c6ccf522d00547878837267e7" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(default-frame-alist
    '((font . "-UKWN-Iosevka Mayukai CodePro-normal-normal-normal-*-13-*-*-*-d-0-iso10646-1")
      (width . 137)
      (height . 30)
      (vertical-scroll-bars)))
 '(display-line-numbers-type 'relative)
 '(package-selected-packages
   '(sly slime org-download paredit helpful tree-sitter-langs tree-sitter org-drill ligature yasnippet company rainbow-delimiters magit use-package graphviz-dot-mode gruvbox-theme cdlatex flycheck evil auctex haskell-mode lua-mode highlight-indent-guides multiple-cursors smex gruber-darker-theme)))

;;; function to check free keys
(setq free-keys-modifiers (list "C" "M" "C-M" "C-c C" "C-x C"))
(setq free-keys-keys "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,/§1234567890-=[];'\\`±!@#$%^&*()_+}{:\"|?><~")

(defun free-keys ()
  (interactive)
  (let ((buf (get-buffer-create "*Free keys*")))
    (display-buffer buf)
    (with-current-buffer buf
      (erase-buffer)
      (mapc (lambda (modifier)
              (insert "\nFree keys with modifier " modifier "\n=========================\n")
              (mapc (lambda (key)
                      (let* ((full-name
                              (concat modifier "-" (char-to-string key)))
                             (binding
                              (key-binding (read-kbd-macro full-name))))
                        (when (not binding)
                          (insert
                           full-name
                           " maps to "
                           (symbol-name binding)
                           "\n"))))
                    free-keys-keys))
            free-keys-modifiers)
      (setq buffer-read-only t)
      (make-local-variable 'buffer-read-only)
      (goto-char 0))))

(provide 'free-keys)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
