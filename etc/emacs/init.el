; Vedant36's emacs configuration

(package-initialize)
;(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
;; use https://github.com/jwiegley/use-package for convinience??

;;; builtins
;;;   interface cleanup
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-frame-font "Iosevka Mayukai CodePro-10")
(display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
;;;   convinience stuff
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(windmove-default-keybindings 'meta)

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
;;(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

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
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(package-selected-packages
   '(lua-mode highlight-indent-guides slime multiple-cursors smex gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
