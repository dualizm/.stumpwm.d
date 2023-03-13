(in-package :stumpwm)

(defmacro autostart-commands (&body commands)
  `(progn
     ,@(loop for command in commands
	     when (second command)
	       collect `(run-shell-command ,(first command)))))
