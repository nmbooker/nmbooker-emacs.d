
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; I often have a .emacs file which is used to add private or location-specific
;; config.
;; You can do the same:
;;  (load-file (concat user-emacs-directory "/init.el"))

(load-file "~/.emacs.d/load-path.el")

(require 'nmb-packages)
(nmb/install-packages)

;;; global modes
(show-paren-mode 1)
(column-number-mode 1)
(add-hook 'prog-mode-hook 'linum-mode)	; want line numbers on programming modes
(require 'align)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; expand-region    ; seems to be behaving oddly in emacs 25
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
(global-set-key (kbd "C-c M") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")  'mc/mark-next-like-this)
(global-set-key (kbd "C-<")  'mc/mark-previous-like-this)
(global-set-key (kbd "C-x C-<") 'mc/mark-all-like-this)

;;; ace jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; ace-window
(global-set-key (kbd "C-x o") 'ace-window)

;;; emmet-mode (for XML, html etc)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
;; C-RET previews and offers to expand

;;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
;; may want to use minor modes instead:
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

;;;

;; ;;; tagedit
;; (eval-after-load "sgml-mode"
;;   '(progn
;;      (require 'tagedit)
;;      (tagedit-add-paredit-like-keybindings)
;;      ;; (tagedit-add-experimental-features)
;;      (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))))

;; (add-hook 'nxml-mode-hook
;; 	  (lambda ()
;; 	    (require 'tagedit)
;; 	    (tagedit-mode)
;; 	    (require 'tagedit-nxml)
;; 	    (enable-tagedit-nxml)))

;;; org
(require 'org)
(add-hook 'org-mode-hook 'linum-mode)
(setq org-default-notes-file (concat org-directory "/TODO.org"))
(setq org-agenda-files `(,org-directory))
(global-set-key (kbd "C-c o a") 'org-agenda)
(global-set-key (kbd "C-c o l") 'org-store-link)
(global-set-key (kbd "C-c o c") 'org-capture)
(global-set-key (kbd "C-c o b") 'org-iswitchb)

(defvar 'nmb/org-default-file "~/org/TODO.org"
  "my default org file")

(defun nmb/org-find-default-file ()
  "Open or focus my org file
To change path, override variable nmb/org-default-file"
  (interactive)
  (find-file nmb/org-default-file))

;;; perl
(require 'perl-mode)
(define-key perl-mode-map (kbd "C-,") "=> ")
(define-key perl-mode-map (kbd "C-.") "->")
  

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (xml-rpc paredit helm-ack ack ag helm-ag ace-window markdown-mode html5-schema magit helm-ls-git helm tagedit-nxml tagedit multiple-cursors)))
 '(perl-indent-parens-as-block t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
