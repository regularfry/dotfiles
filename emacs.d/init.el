(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(server-start)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'package)
(add-to-list 'package-archives
  '("marmalade" .  "https://marmalade-repo.org/packages/"))

(defvar my-packages '(better-defaults
                      paredit
                      idle-highlight-mode
                      ido-ubiquitous
                      find-file-in-project
                      magit
                      smex
                      scpaste
                      yaml-mode
                      yasnippet))

(package-initialize)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; filename matching
(add-to-list 'auto-mode-alist '("[rR]akefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))

; C-? reverts the buffer.  Logic is that C-/ is undo, so C-S-/ is
; more-undo.
(global-set-key (kbd "C-?") 'revert-buffer)

; make f12 edit this file
(defun edit-init-el ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key [f12] 'edit-init-el)

(defun swap-buffer-windows ()
  (interactive)
  (next-multiframe-window)
  (let ((bufa (current-buffer)))
    (previous-multiframe-window)
    (let ((bufb (current-buffer)))
      (switch-to-buffer bufa)
      (next-multiframe-window)
      (switch-to-buffer bufb))))

; Set C-pgup and C-pgdn to sane functions
(global-set-key [C-next] 'next-multiframe-window)
(global-set-key [C-prior] 'previous-multiframe-window)
(global-set-key [C-S-prior] 'swap-buffer-windows)
(global-set-key [C-S-next] 'swap-buffer-windows)

(global-set-key [?\C->] 'increase-left-margin)
(global-set-key [?\C-<] 'decrease-left-margin)


; Handy binding
(global-set-key (kbd "C-c a =")
                (lambda () (interactive)
                  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)=" 1 1 nil)))
(global-set-key (kbd "M-=") 'align-regexp)

(defun set-font (fontname)
  (custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "gray12"
                  :foreground "green" :inverse-video nil :box nil :strike-through nil
                  :overline nil :underline nil :slant normal :weight normal :height
                  100 :width normal :foundry "unknown" :family fontname))))
   '(minimap-font-face ((default (:height 20 :family "DejaVu Sans Mono")) (nil nil)))))

(defun set-fixed-font ()  (interactive) (set-frame-font "Inconsolata 12"))
(defun set-proportional-font ()  (interactive) (set-frame-font "Gentium 12"))

(set-fixed-font)
;;(set-proportional-font)
(global-set-key [f9] 'set-fixed-font)
(global-set-key [f10] 'set-proportional-font)

;;; Some basic navigation customizations.

(setq line-move-visual nil)             ; Default to logical line movement

;;; The following function are like previous-line/next-line, but move
;;; visually (and do so without changing the default behaviour).

(defun previous-visual-line ()
  "Move to previous visual line, without effecting the default behavior."
  (interactive)
  (let ((line-move-visual t))
    (previous-line)))

(defun next-visual-line ()
  "Move to next visual line, without effecting the default behavior."
  (interactive)
  (let ((line-move-visual t))
    (next-line)))


(global-set-key (kbd "<down>") 'next-visual-line)
(global-set-key (kbd "<up>") 'previous-visual-line)

(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C-s") 'isearch-forward)

;;; Meta *

(global-set-key (kbd "M-g") 'goto-line)

(defun move-line-region-up (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-up start end n) (move-line-up n)))

(defun move-line-region-down (start end n)
  (interactive "r\np")
  (if (region-active-p) (move-region-down start end n) (move-line-down n)))

(defun move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) -1 (- n))))

(defun move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (move-region start end (if (null n) 1 n)))

(global-set-key (kbd "M-n") 'move-region-down)
(global-set-key (kbd "M-p") 'move-region-up)


(require 'yasnippet)
(add-hook 'ruby-mode-hook 'yas/minor-mode-on)
(yas/reload-all)
