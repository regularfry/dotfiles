(setq-default transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(tool-bar-mode nil)
(menu-bar-mode nil)
(server-start)
(ido-mode t)


(require 'uniquify)
(setq
  uniquify-buffer-name-style 'forward
  uniquify-separator ":")


;; filename matching
(add-to-list 'auto-mode-alist '("[rR]akefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("^Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))


(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'write-file-functions
                         'delete-trailing-whitespace)))


(defun make-variable ()
   (let ((var-name (read-string "Variable name: ")))     
     (kill-append " = " t)
     (kill-append var-name t)
     (insert-string var-name)
     (end-of-line 0)
     (newline-and-indent)
     (yank)))

(defun extract-region-to-variable ()
   (interactive)
   (kill-region (region-beginning) (region-end))
   (make-variable))

(defun extract-sexp-to-variable ()
  (interactive)
  (kill-sexp)
  (make-variable))



(defun lisp-enable-paredit-hook ()
  (paredit-mode 1))
(add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)


;; Set up snippets
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")


;; Set up marmalade
(add-to-list 'load-path
	     "~/.emacs.d/plugins/package")
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)


(defun make-journal-entry ()
  (interactive)
  (let ((filename
         (apply 'format "%d-%d-%d_%d:%d:%d.md"
                (cdddr (reverse (decode-time))))))
    (switch-to-buffer
     (find-file (concat "/ssh:alex@81.187.127.205:journal/" filename)))))
(global-set-key [f9] 'make-journal-entry)


; make f12 edit this file
(defun edit-init-el ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key [f12] 'edit-init-el)

; C-? reverts the buffer.  Logic is that C-/ is undo, so C-S-/ is
; more-undo.
(global-set-key (kbd "C-?") 'revert-buffer)


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

; Set to hippie-expand by default
(global-set-key (kbd "M-/") 'hippie-expand)


; Handy binding
(global-set-key (kbd "C-c a =")
                (lambda () (interactive)
                  (align-regexp (region-beginning) (region-end) "\\(\\s-*\\)=" 1 1 nil)))
(global-set-key (kbd "M-=") 'align-regexp)


(require 'color-theme)
(color-theme-initialize)
(color-theme-calm-forest)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray12" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "unknown" :family "Inconsolata")))))
