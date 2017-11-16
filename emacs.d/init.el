(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(server-start)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(defvar my-packages '(better-defaults
                      exec-path-from-shell
                      paredit
                      idle-highlight-mode
                      ido-ubiquitous
                      find-file-in-project
                      ;magit
                      smex
                      scpaste
                      yaml-mode
                      yasnippet))

(package-initialize)
(package-refresh-contents)
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

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))

(setq ruby-insert-encoding-magic-comment nil)

(setq scss-compile-at-save nil)

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


;; org-mode
(setq org-agenda-files (list "~/Documents/todo.org"))
(global-set-key (kbd "C-c A") 'org-agenda)

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
                           140 :width normal :foundry "unknown" :family fontname))))
   '(minimap-font-face ((default (:height 20 :family "DejaVu Sans Mono")) (nil nil)))))

(defun set-fixed-font ()  (interactive) (set-frame-font "Inconsolata 12"))
(defun set-proportional-font ()  (interactive) (set-frame-font "Constantia 12"))

(set-fixed-font)
;;(set-proportional-font)
(global-set-key [f9] 'set-fixed-font)
(global-set-key [f10] 'set-proportional-font)
(global-set-key (kbd "C-+") (lambda () (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C--") (lambda () (interactive) (text-scale-decrease 1)))
(global-set-key [end] 'move-end-of-line)

;;; Some basic navigation customizations.

(setq line-move-visual t) ; makes Ctrl-n/Ctrl-p the same as up-arrow/down-arrow

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


(defun split-comma-lines (start end)
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (search-forward "," end t)
      (replace-match ",\n" nil t))
    (indent-region start end)))

(require 'yasnippet)
(add-hook 'ruby-mode-hook
          (function (lambda ()
                      (yas/minor-mode-on)
                      (ruby-tools-mode)
                      (rubocop-mode))))
(add-hook 'js-mode-hook
          (function (lambda ()
                      (yas/minor-mode-on)))
          (yas/reload-all))

(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(defun new-journaled-file* (ext)
  (let* ((dirname (expand-file-name "~/Documents/stash/"))
         (filename (concat dirname (format-time-string "%Y-%m-%dT%H:%M:%S") ext)))
    (find-file filename)))

(defun new-journaled-file ()
  "Make a new timestamped file under Documents/stash"
  (interactive)
  (new-journaled-file* ".txt"))

(defun new-journaled-markdown ()
  "Make a new timestamped markdown file under Documents/stash"
  (interactive)
  (new-journaled-file* ".md"))

(defun new-org-mode-buffer ()
  "Make a new org-mode buffer"
  (interactive)
  (switch-to-buffer (generate-new-buffer "org"))
  (org-mode))

(defun toggle-macro ()
  (interactive)
  (if (or defining-kbd-macro executing-kbd-macro)
      (kmacro-end-macro 0)
    (kmacro-start-macro 0)))


(global-set-key [f2] 'new-journaled-file)
(global-set-key [f3] 'new-journaled-markdown)
(global-set-key [f4] 'new-org-mode-buffer)
(global-set-key [f6] 'toggle-macro)
(global-set-key [f7] 'kmacro-call-macro)
(global-set-key (kbd "M-t") 'new-journaled-file)

(global-set-key (kbd "C-]") 'ffap)

(global-set-key [f7] 'magit-status)

(defvar-local highlight-region--highlighted-text "")

(define-minor-mode highlight-region-mode
  "Automatically highlight current region when mark is active."
  nil nil nil
  (highlight-region--unhighlight-region)
  (remove-hook 'activate-mark-hook #'highlight-region--highlight-region t)
  ;; as for GNU Emacs 25.0.93.1 (i686-pc-linux-gnu, X toolkit, Xaw scroll bars) of 2016-05-03
  ;; it seems that the following behaviour of activate-mark-hook described in its dosctring :
  ;; >> It is also run at the end of a command, if the mark is active and
  ;; >> it is possible that the region may have changed.
  ;; actually doesn't work. Thus let's add ourselves to post-command-hook...
  (remove-hook 'post-command-hook #'highlight-region--highlight-region t)
  (remove-hook 'deactivate-mark-hook #'highlight-region--unhighlight-region t)
  (when highlight-region-mode
    (add-hook 'activate-mark-hook #'highlight-region--highlight-region nil t)
    (add-hook 'post-command-hook #'highlight-region--highlight-region nil t)
    (add-hook 'deactivate-mark-hook #'highlight-region--unhighlight-region nil t)))

(defun highlight-region--highlight-region ()
  "Highlight currently active region"
  (when (use-region-p)
    (let ((str (buffer-substring-no-properties (region-beginning) (region-end))))
      (unless (or (string= "" str)
                  (string= str highlight-region--highlighted-text))
        (highlight-region--unhighlight-region)
        (setq highlight-region--highlighted-text str)
        ;; TODO: add a face `highlight-region' and use it.
        (highlight-regexp (regexp-quote str))))))

(defun highlight-region--unhighlight-region nil
  (unhighlight-regexp (regexp-quote highlight-region--highlighted-text))
  (setq highlight-region--highlighted-text ""))


(defun +x ()
  (interactive)
  (chmod buffer-file-name #o755))


;; (require 'whitespace)
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
;; (global-whitespace-mode t)

;; (defun ay-slim-edit-as-javascript (start end)
;;  (interactive "r")
;;  (let ((orig-buf (current-buffer))
;;        (buf (generate-new-buffer (generate-new-buffer-name "slim-js"))))
;;    (copy-to-buffer buf start end)
;;    (with-current-buffer buf
;;      (js-mode)
;;      (make-local-variable '*orig-start*)
;;      (make-local-variable '*orig-end*)
;;      (make-local-variable '*orig-buf*)
;;      (setq *orig-start* start)
;;      (setq *orig-end* end)
;;      (setq *orig-buf* orig-buf))
;;    (pop-to-buffer buf)))

(exec-path-from-shell-initialize)

(add-to-list 'load-path "~/.emacs.d/other/vagrant-tramp")
(require 'vagrant-tramp)

(add-to-list 'load-path "~/.emacs.d/other")
(require 'rubocop)
(put 'downcase-region 'disabled nil)

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

(require 'dired-x)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (haml-mode feature-mode zencoding-mode yasnippet yaml-mode smex slim-mode scss-mode scpaste ruby-tools request php-mode paredit markdown-mode magit logito livescript-mode jsx-mode ido-ubiquitous idle-highlight-mode haskell-mode go-mode flymake-ruby find-file-in-project exec-path-from-shell elm-mode dumb-jump dash-functional cider better-defaults alchemist))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
