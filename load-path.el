;; load path for my extra libraries
;; usage: (load-file "~/.emacs.d/load-path.el")

(require 'cl-lib)
(cl-loop for path in '("~/.emacs.d/vendor" "~/.emacs.d/lib") do
      (add-to-list 'load-path path))
