; Vedant36's emacs configuration
;;; probuse packages: flycheck(syntax checker, )

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;; use https://github.com/jwiegley/use-package ?

;;; builtins
;;;   interface cleanup
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(if window-system
    (scroll-bar-mode 0))
(tool-bar-mode 0)
(set-frame-font "Iosevka Mayukai CodePro-10")
;; (setq-default cursor-type 'bar)
(global-display-line-numbers-mode)
(setq display-line-numbers 'relative)
;(display-line-numbers-mode)
;;;   convinience stuff
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(windmove-default-keybindings)
(electric-pair-mode 1)

;;; bindings
nil

;; ;; Enable Evil
;; (require 'evil)
;; (evil-mode 1)
;; (evil-emacs-state)
;; (setq evil-default-state 'emacs)

;;; org-mode
(setq org-special-ctrl-a/e t)
;; to get >greentext in org-mode documents
(defun u/greentext ()
  "Highlight >greentext in current buffer."
  (interactive)
  (highlight-lines-matching-regexp "^>" 'hi-green-b))

(add-hook 'org-mode-hook #'u/greentext)
;; [Babel: Languages](https://orgmode.org/worg/org-contrib/babel/languages/index.html)
(org-babel-do-load-languages
  'org-babel-load-languages
  '((python . t)
    (C . t)
    (lisp . t)))

;;; LaTeX
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)

;;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; multiple cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; SLIME
(setq inferior-lisp-program "sbcl")

;;; [highlight-indent-guides](https://github.com/DarthFennec/highlight-indent-guides)
(setq highlight-indent-guides-method 'character)
(highlight-indent-guides-mode)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; Save the "emacs autosaving" files to a seperate directory
;(setq backup-directory-alist '(("." . "~/.emacs_saves")))

;; lcs: from https://www.kernel.org/doc/html/v4.10/process/coding-style.html
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
   '("b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "2ff9ac386eac4dffd77a33e93b0c8236bb376c5a5df62e36d4bfa821d56e4e20" "72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(display-line-numbers-type 'relative)
 '(package-selected-packages
   '(gruvbox-theme cdlatex flycheck evil auctex haskell-mode dracula-theme rainbow-delimiters monokai-theme lua-mode highlight-indent-guides slime multiple-cursors smex gruber-darker-theme)))

;;; function to check free keys
;; (setq free-keys-modifiers (list "C" "M" "C-M" "C-c C" "C-x C"))
;; (setq free-keys-keys "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.,/§1234567890-=[];'\\`±!@#$%^&*()_+}{:\"|?><~")

;; (defun free-keys ()
;;   (interactive)
;;   (let ((buf (get-buffer-create "*Free keys*")))
;;     (display-buffer buf)
;;     (with-current-buffer buf
;;       (erase-buffer)
;;       (mapc (lambda (modifier)
;;               (insert "\nFree keys with modifier " modifier "\n=========================\n")
;;               (mapc (lambda (key)
;;                       (let* ((full-name
;;                               (concat modifier "-" (char-to-string key)))
;;                              (binding
;;                               (key-binding (read-kbd-macro full-name))))
;;                         (when (not binding)
;;                           (insert
;;                            full-name
;;                            " maps to "
;;                            (symbol-name binding)
;;                            "\n"))))
;;                     free-keys-keys))
;;             free-keys-modifiers)
;;       (setq buffer-read-only t)
;;       (make-local-variable 'buffer-read-only)
;;       (goto-char 0))))

;; (provide 'free-keys)

(defvar infu-bionic-reading-face nil "a face for `infu-bionic-reading-region'.")

(setq infu-bionic-reading-face 'error)
;; try
;; 'bold
;; 'error
;; 'warning
;; 'highlight
;; or any value of M-x list-faces-display

(defun infu-bionic-reading-buffer ()
  "Bold the first few chars of every word in current buffer.
Version 2022-05-21"
  (interactive)
  (infu-bionic-reading-region (point-min) (point-max)))

(defun infu-bionic-reading-region (Begin End)
  "Bold the first few chars of every word in region.
Version 2022-05-21"
  (interactive "r")
  (let (xBounds xWordBegin xWordEnd)
    (save-restriction
      (narrow-to-region Begin End)
      (goto-char (point-min))
      (while (forward-word)
        ;; bold the first half of the word to the left of cursor
        (setq xBounds (bounds-of-thing-at-point 'word))
        (setq xWordBegin (car xBounds))
        (setq xWordEnd (cdr xBounds))
        (setq xBoldEndPos (+ xWordBegin (1+ (/ (- xWordEnd xWordBegin) 2))))
        (put-text-property xWordBegin xBoldEndPos
                           'font-lock-face infu-bionic-reading-face)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )