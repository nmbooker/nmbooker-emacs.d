;;; Functions to help deal with Odoo projects and code

(require 'dash)

;; (unless (macrop 'if-let)
;;   (defmacro* if-let ((var value) then &rest else)
;;     `(let ((,var ,value))
;;        (if ,var ,then ,@else))))  ;; TODO test this on an emacs without if-let

(defun dired-odoo-addon-root ()
  "Dired the Odoo addon root corresponding to the current buffer"
  (interactive)
  (-dired-odoo-addon-root 'dired))

(defun -dired-odoo-addon-root (dired-fun)
  (--if-let (get-odoo-addon-root default-directory)
      (apply dired-fun `(,it))
    (message "Error: default-directory not inside Odoo addon")))

(defun dired-odoo-addon-root-other-window ()
  "Dired the Odoo addon root corresponding to the current buffer, in other window"
  (interactive)
  (-dired-odoo-addon-root 'dired-other-window))

(defun -find-odoo-addon-manifest (find-file-fun)
  (--if-let (get-odoo-addon-manifest-path default-directory)
      (apply find-file-fun `(,it))
    (message "Error: default-directory not inside Odoo addon")))

(defun find-odoo-addon-manifest ()
  "Find the Odoo manifest file corresponding to the current buffer"
  (interactive)
  (-find-odoo-addon-manifest 'find-file))

(defun find-odoo-addon-manifest-other-window ()
  "Find the Odoo manifest file corresponding to the current buffer, in other window"
  (interactive)
  (-find-odoo-addon-manifest 'find-file-other-window))

(defun get-odoo-addon-manifest-path (subordinate-path)
  "Return the path to the __openerp__.py file for the module containing subordinate-path.  Nil if not in an Odoo module"
  (search-file-in-ancestors subordinate-path "__openerp__.py" 'full))

(defun get-odoo-addon-root (subordinate-path)
  "Return the root of the addon"
  (search-file-in-ancestors subordinate-path "__openerp__.py" 'dir))

(defun search-file-in-ancestors (subordinate-path target-filename what)
  "Find target-filename in subordinate-path or an ancestor.  Nil if not found.
what should be 'full to get the full path of the found file, or 'dir for the directory containing it"
  (let* ((checking-dir (file-name-as-directory (expand-file-name subordinate-path)))
	 (checking-file (concat checking-dir target-filename))
	 result)
    (if (file-exists-p checking-file)
	(cond ((eq what 'full) checking-file)
	      ((eq what 'dir) checking-dir))
      (if (string= checking-dir "/")
	  nil
	(search-file-in-ancestors (expand-file-name (concat checking-dir "..")) target-filename what)))))

(provide 'py-odoo)
