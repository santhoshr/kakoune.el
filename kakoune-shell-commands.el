;;; kakoune-shell-commands.el --- Shell command integration for kakoune.el -*- lexical-binding: t; -*-

;; Author: Joseph Morag <jm4157@columbia.edu>
;;; Commentary:
;; Provides shell command functionality for kakoune.el

;;; Code:
(require 'multiple-cursors)

(defun kakoune-shell-pipe ()
  "Run a shell command on each of the current regions separately and replace the current regions with its output."
  (interactive)
  (let ((command (read-string "Pipe: ")))
    (mc/for-each-cursor-ordered
     (shell-command-on-region (mc/cursor-beg cursor)
                              (mc/cursor-end cursor)
                              command
                              nil
                              1))))
(defun kakoune-shell-command ()
  "Run a shell command on each of the current regions separately and insert its output before the respective regions."
  (interactive)
  (mc/save-excursion
   (let ((command (read-string "Pipe: ")))
     (mc/for-each-cursor-ordered
      (mc/save-excursion
       (goto-char (mc/cursor-beg cursor))
       (insert
        (with-output-to-string
          (shell-command-on-region (mc/cursor-beg cursor)
                                   (mc/cursor-end cursor)
                                   command
                                   standard-output))))))))

(provide 'kakoune-shell-commands)
;;; kakoune-shell-commands ends here
