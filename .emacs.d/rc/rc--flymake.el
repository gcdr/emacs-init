;;; Time-stamp: <2015-08-06 15:40:41 davidwallin>
;;; Code:

(use-package flymake
  :commands (flymake-find-file-hook)
  :init
  (setq flymake-gui-warnings-enabled nil)
  (setq flymake-log-level 1)

  ;; Instead of manually activating flymake-mode, you can configure Flymake to
  ;; automatically enable flymake-mode upon opening any file for which syntax
  ;; check is possible. To do so, place the following line in .emacs:
  (add-hook 'find-file-hook 'flymake-find-file-hook)

  (defun my-flymake-show-next-error ()
    (interactive)
    (flymake-goto-next-error)
    (when flymake-gui-warnings-enabled
      (flymake-display-err-menu-for-current-line)))

  (defun my-flymake-show-prev-error ()
    (interactive)
    (flymake-goto-prev-error)
    (when flymake-gui-warnings-enabled
      (flymake-display-err-menu-for-current-line)))

  (defun my-flymake-keybindings ()
    (interactive)
    ;; (local-set-key (kbd "C-c C-k") 'compile)
    (local-set-key (kbd "C-c C-k") 'flymake-compile)
    (local-set-key (kbd "M-n") 'my-flymake-show-next-error)
    (local-set-key (kbd "M-p") 'my-flymake-show-prev-error))
  :config
  (defun flymake-get-tex-args (file-name)
     (list "chktex" (list "-q" "-v0" file-name)))
  ;; '(defun flymake-get-tex-args (file-name)
  ;;   (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

  (setq flymake-allowed-file-name-masks
        (remove-if (lambda (x) (string-match ".*\\(\\\\.tex\\|\\\\.xml\\|\\\\.html\\?\\)\\\\'" (first x)))
                   flymake-allowed-file-name-masks))
  :ensure t)
