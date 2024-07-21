/;;;; Vedant36's emacs configuration
;;;; TODO: undo tree
;;;; mods: ivy,lsp(has eldoc like thing for other langs)
;;;; check out for rgb highlighting: emacs-color, rainbow-mode
;;;; check out for delemiters rainbow-delimiters: pair-colorizer
;;;; fix being able to get italics in comments

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(if (daemonp) (package-refresh-contents))

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
(setq mouse-yank-at-point t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-file-extensions-order '(".tex" ".org"
				  t
				  ".elc" ".png" ".pdf" ""))
(windmove-default-keybindings)
(electric-pair-mode 1)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-c o") 'occur)
(setq bookmark-alist
      '(("todo.org" (filename . "~/dox/org/todo.org"))
	("schedule.org" (filename . "~/dox/org/schedule.org"))
	("init.el" (filename . "~/.local/etc/emacs/init.el"))))
;; SYSTEM_SPECIFIC::Save the "emacs autosaving" files to a seperate directory
(setq backup-directory-alist '(("." . "~/.local/var/lib/emacs")))
(setq find-function-C-source-directory "~/.local/opt/emacs/src")
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

;;; org-mode
(setq org-agenda-files '("~/dox/org/"))
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(require 'org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)))
(use-package org-mode
  :ensure nil
  :defer t
  :init
  (setq org-html-validation-link nil)
  (setq org-special-ctrl-a/e t)
  (setq org-startup-indented t)
  (setq org-startup-folded 'overview)
  (setq org-agenda-span 14)
  (setq fill-column 79)
  ;; to get >greentext in org-mode documents
  (defun u/greentext ()
    "Highlight >greentext in current buffer."
    (interactive)
    (highlight-lines-matching-regexp "^>" 'hi-green-b))
  (add-hook 'org-mode-hook 'u/greentext)
  ;; redisplay images after executing org-babel
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append))
(use-package org-download
  :ensure org-download
  :commands (org-download-yank org-download-screenshot)
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
  :defer t
  :hook (graphviz-dot-mode-hook . company-mode))
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
  ;; (set-face-foreground 'rainbow-delimiters-depth-1-face "#f00")   ; red
  ;; (set-face-foreground 'rainbow-delimiters-depth-2-face "#0f0")   ; green
  ;; (set-face-foreground 'rainbow-delimiters-depth-3-face "#00f")   ; blue
  ;; (set-face-foreground 'rainbow-delimiters-depth-4-face "#ff0")   ; yellow
  ;; (set-face-foreground 'rainbow-delimiters-depth-5-face "#0ff")   ; cyan
  ;; (set-face-foreground 'rainbow-delimiters-depth-6-face "#f0f")   ; magenta

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
	 ("RET" . nil))
  :config (setq company-format-margin-function 'company-text-icons-margin))
(use-package yasnippet
  :defer nil
  :commands (yas-reload-all yas-minor-mode)
  ;; :hook (prog-mode-hook . yas-minor-mode)
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))
;; (require 'yasnippet)
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)
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
  (setq evil-default-state 'emacs))

;; Python
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
	python-shell-interpreter-args "-i --autocall=2 --nosep --simple-prompt"))

;; C
(add-hook 'c-mode-hook
	            (lambda () (local-set-key (kbd "C-c C-c") #'compile)))
;;; lcs: from https://www.kernel.org/doc/html/v4.10/process/coding-style.html
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
   '("ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" default))
 '(default-frame-alist
   '((font . "-UKWN-Iosevka Mayukai CodePro-normal-normal-normal-*-13-*-*-*-d-0-iso10646-1")
     (width . 137)
     (height . 30)))
 '(display-line-numbers-type 'relative)
 '(org-startup-folded 'fold)
 '(package-selected-packages
   '(epresent org-tree-slide rainbow-mode graphviz-dot-mode proof-general sly slime org-download paredit helpful tree-sitter-langs tree-sitter org-drill ligature yasnippet company rainbow-delimiters magit use-package gruvbox-theme cdlatex flycheck evil auctex haskell-mode lua-mode highlight-indent-guides multiple-cursors smex gruber-darker-theme)))

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
(put 'downcase-region 'disabled nil)
