;;; Time-stamp: <2015-09-14 21:15:52 davidwallin>


;;; Code:

(setq user-full-name "David Wallin")
(setq user-mail-address "dwa@havanaclub.org")
(setq ps-paper-type 'a4)

(add-to-list 'Info-default-directory-list (expand-file-name "~/info/"))

;(define-key read-expression-map (kbd "TAB") #'lisp-complete-symbol)

(add-to-list 'exec-path (expand-file-name "~/bin"))

;;
;; keep all backup files in the same place:
(add-to-list 'backup-directory-alist
	     (cons ".*" (expand-file-name "~/.emacs.d/backups/")))

;; Prefer woman to man for man pages
(require 'man)
(require 'woman)
(fset 'man-ext (symbol-function 'man))
(defalias 'man 'woman)
(setq woman-use-own-frame nil)

;; use the 'Delete' key as C-d
(global-set-key [kp-delete] 'delete-char)

(fset 'yes-or-no-p 'y-or-n-p)           ;replace y-e-s by y
(setq inhibit-startup-message t)        ;no splash screen

(setq info-lookup-other-window-flag nil)

(add-hook 'Info-mode-hook 'hl-line-mode)
(add-hook 'occur-mode-hook 'hl-line-mode)
(add-hook 'tar-mode-hook 'hl-line-mode)
(add-hook 'proced-mode-hook 'hl-line-mode)

(put 'downcase-region 'disabled nil)

;;
;; from http://www.emacswiki.org/emacs/CommentingCode:

;; I am addicted to the M-; comment-dwim command. However I wanted to change the
;; default behaviour a bit. If no region is selected, comment-dwim inserts
;; comment at the end of the line. Instead, I wanted to comment out whole line,
;; if we are currently not at the end of the line. This does the trick:

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
          (interactive "*P")
          (comment-normalize-vars)
          (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
              (comment-or-uncomment-region (line-beginning-position) (line-end-position))
            (comment-dwim arg)))

;; (global-set-key "\M-;" 'comment-dwim-line)


(defun dired-w3m-find-file ()
  "In Dired, visit the file or directory named on this line."
  (interactive)
  ;; Bind `find-file-run-dired' so that the command works on directories
  ;; too, independent of the user's setting.
  (let ((find-file-run-dired t))
    (w3m-find-file (dired-get-file-for-visit))))

(defun my-dired-keybindings ()
  (local-set-key (kbd "C-c v") 'dired-w3m-find-file)
  (local-set-key (kbd "C-c m") 'dired-do-moccur))

(add-hook 'dired-mode-hook 'my-dired-keybindings)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

(setq-default indent-tabs-mode nil)

(setq-default indicate-empty-lines t)

(setq vc-follow-symlinks t)

;; http://www.method-combination.net/blog/archives/2011/03/11/speeding-up-emacs-saves.html
(setq vc-handled-backends nil)

(setq transient-mark-mode 'lambda)

(setq-default fill-column 80)

(global-set-key (kbd "M-<right>") 'forward-sexp)
(global-set-key (kbd "M-<left>") 'backward-sexp)

;(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; we want to save ourselves from having to do a chmod on newly created scripts:
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'write-file-hooks 'time-stamp)

(use-package tramp
  :init
  (setq tramp-default-method "scp"))

;; no blinking cursor
(blink-cursor-mode -1)

(when (eq system-type 'gnu/linux)
  (mouse-wheel-mode t))

;; smooth scrolling
(setq scroll-conservatively 10000)

(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

(global-set-key [f11] 'highlight-changes-mode)

(setq european-calendar-style t)

(global-set-key (kbd "<f5> c") 'calendar)
(global-set-key (kbd "<f5> b") 'bbdb)
(global-set-key (kbd "<f5> d") 'diary-show-all-entries)

;;; ------------------------------------------------------------------- [browse]

(setq browse-url-firefox-program "firefox-bin"
      browse-url-firefox-new-window-is-tab t
      browse-url-browser-function 'browse-url-firefox)

(if (eq system-type 'darwin)
    (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  ;;(setq browse-url-browser-function 'browse-url-firefox-new-tab)
  )

(global-set-key (kbd "C-c b") 'browse-url-at-point)


(require 'xfrp_find_replace_pairs)
(defun swap-brackets-in-region (start end)
  (interactive "r")
  (replace-pairs-region start end '(["(" "["]
                                    [")" "]"]
                                    ["[" "("]
                                    ["]" ")"])))

(require 'keyremapping)
(swap-bracket-keymapping-1)

(setq gc-cons-threshold 20000000)

;;; ----------------------------------------------------------------- [the end]
