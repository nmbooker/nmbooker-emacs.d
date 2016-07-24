#!/usr/bin/emacs --script

(require 'cl-lib)
(cl-dolist (x (mapcar (lambda (y) (+ y 1)) '(1 2 3 4 5))) (message (format "%d" x)))
