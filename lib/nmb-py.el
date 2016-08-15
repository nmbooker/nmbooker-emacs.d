(defun nmb/py-get-to-getitem ()
  "Convert a foo.get(x) to a foo[x].

Before running this, your point should be on the dot (.) character
introducing the get method call."
  (interactive)
  (if (not (string= (thing-at-point 'char) "."))
      (message "Point is not on function call (dot)")
    (save-excursion
      (forward-char)
      (if (not (string= (thing-at-point 'word) "get"))
          (message "Point is not before get call")
        (progn
          (kill-word 1)
          (save-excursion
            (goto-match-paren nil)
            (backward-delete-char 1)
            (insert "]"))
          (delete-char 1)
          (backward-delete-char 1)
          (insert "["))))))

;; May be useful: http://ergoemacs.org/emacs/elisp_change_brackets.html

(defun nmb/python-extract-variable (start-pos end-pos varname)
  "Extract a variable with the selected point"
  (interactive "r\nsVariable name: ")
  (save-excursion
    (kill-region start-pos end-pos)
    (python-nav-beginning-of-statement)
    (let ((col (current-column)))
      (move-beginning-of-line nil)
      (open-line 1)
      (indent-to-column col)
      (insert varname " = ")
      (yank)))
  (insert varname))

;; https://www.wwwtech.de/articles/2013/may/emacs:-jump-to-matching-paren-beginning-of-block
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(provide 'nmb-py)
