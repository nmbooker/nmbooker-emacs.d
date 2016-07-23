(load-file "~/.emacs.d/load-path.el")

(require 'nmb-packages)
(nmb/install-packages)

;;; global modes
(show-paren-mode 1)
(column-number-mode 1)
(add-hook 'prog-mode-hook 'linum-mode)	; want line numbers on programming modes

;;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
;; https://github.com/magnars/expand-region.el
;; Select current object.  Repeated presses expand further to enclosing object

;;; Clipboard
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;; Helm
(require 'helm-config)
(require 'helm-ls-git)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)

;;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")  'mc/mark-next-like-this)
(global-set-key (kbd "C-<")  'mc/mark-previous-like-this)
(global-set-key (kbd "C-x C-<") 'mc/mark-all-like-this)

;;; tegedit

(eval-after-load "sgml-mode"
  '(progn
     (require 'tagedit)
     (tagedit-add-paredit-like-keybindings)
     ;; (tagedit-add-experimental-features)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

(add-hook 'nxml-mode-hook
	  (lambda ()
	    (require 'tagedit)
	    (tagedit-mode)
	    (require 'tagedit-nxml)
	    (enable-tagedit-nxml)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen nil)
 '(package-selected-packages
   (quote
    (magit helm-ls-git helm tagedit-nxml tagedit multiple-cursors)))
 '(perl-indent-parens-as-block t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
