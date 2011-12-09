(setq-default transient-mark-mode t)
(setq x-select-enable-clipboard t)
(setq inhibit-startup-message t)
(show-paren-mode t)
(tool-bar-mode nil)
(menu-bar-mode nil)
(server-start)
(ido-mode t)

;; filename matching
(add-to-list 'auto-mode-alist '("[rR]akefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("^Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))



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



;; set up for slime (obsolete, replace)
(add-to-list 'load-path "~/.emacs.d/slime")
(eval-after-load "slime" 
  '(progn (slime-setup '(slime-repl))))
(require 'slime)
(slime-setup)


;; set up for clojure-mode (obsolete, replace)
(add-to-list 'load-path "/home/zander/.emacs.d/clojure-mode")
(require 'clojure-mode)

(defun lisp-enable-paredit-hook ()
  (paredit-mode 1))
(add-hook 'clojure-mode-hook 'lisp-enable-paredit-hook)


;; Set up snippets
(add-to-list 'load-path
	     "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")




; make f12 edit this file
(defun edit-init-el ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key [f12] 'edit-init-el)

; Set C-pgup and C-pgdn to sane functions
(global-set-key [C-next] 'next-multiframe-window)
(global-set-key [C-prior] 'previous-multiframe-window)

(global-set-key [?\C->] 'increase-left-margin)
(global-set-key [?\C-<] 'decrease-left-margin)


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
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 82 :width normal :foundry "bitstream" :family "Bitstream Vera Sans Mono")))))
