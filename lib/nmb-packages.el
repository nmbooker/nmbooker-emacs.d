;;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(setq nmb/package-list '(multiple-cursors
			 helm
			 helm-ls-git
			 magit
			 expand-region
			 ace-jump-mode
			 emmet-mode
			 yasnippet
			 html5-schema
			 markdown-mode
			 ace-window))

(defun nmb/install-packages ()
  "Install my packages"
  (interactive)
  (package-refresh-contents)
  (dolist (package nmb/package-list)
    (unless (package-installed-p package)
      (package-install package))))

(provide 'nmb-packages)
