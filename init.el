(add-to-list 'load-path "~/.emacs.d/vendor")

;;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq nmb/packages '(multiple-cursors
		     tagedit
		     helm
		     helm-ls-git
		     magit))

(defun nmb/install-packages ()
  "Install my packages"
  (interactive)
  (mapcar 'package-install nmb/packages))

;;; global modes
(show-paren-mode 1)

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
 '(package-selected-packages
   (quote
    (magit helm-ls-git helm tagedit-nxml tagedit multiple-cursors))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
