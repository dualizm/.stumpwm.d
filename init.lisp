;; author: ezqb
;; file: stumpwm config

(in-package :stumpwm)

;; bind prefix key
(set-prefix-key (kbd "C-t"))

;; color background
;;(setf (xlib:window-background (screen-root (current-screen))) #x691984)

;; wallpaper
(run-shell-command "feh --bg-fill /home/ez/pic/city/nightcity-puprle-cool-skamya.jpg")

;; keyboard
(run-shell-command "setxkbmap -option ctrl:swapcasp")
(run-shell-command "setxkbmap -layout us,ru -option grp:rctl_toggle")

;; standalone compositor
(run-shell-command "picom")

;; set terminal
(define-key *root-map* (kbd "Return") "exec kitty")
(define-key *root-map* (kbd "c") "exec kitty")
(define-key *root-map* (kbd "C-c") "exec kitty")

;;(set-font (list
;;	   (make-instance 'xft:font
;;			  :family "Monoid"
;;			  :subfamily "Bold"
;;			  :size 13)
;;	   (make-instance 'xft:font
;;			  :family "Monoid"
;;			  :subfamily "Regular"
;;			  :size 12)))

;; color theme
(set-fg-color "#d34474")
(set-bg-color "#161616")
(set-border-color "#000000")
(set-msg-border-width 2)

;; font
(set-font "Monoid")

;; config
(setf *message-window-padding* 20
      *message-window-gravity* :center
      *input-window-gravity* :center
      *timeout-wait* 7)
      

;; swank server
(require :swank)
(swank-loader:init)

(defparameter *port-number* 4004
  "My default port number for Swank")

(defvar *swank-server-p* nil
  "Keep track of swank server, turned off by default on startup")

(defcommand start-swank () ()
  "Start Swank if it is not already running"
  (if *swank-server-p*
      (message "Swank server is already active on Port^5 ~a^n" *port-number*)
      (progn
	(swank:create-server :port *port-number*
			     :style swank:*communication-style*
			     :dont-close t)
	(setf *swank-server-p* t)
	(message "Swank server is now active on Port^5 ~a^n.
Use^4 M-x slime-connect^n in Emacs. 
Type^2 (in-package :stumpwm)^n in Slime REPL." *port-number*))))

(defcommand stop-swank () ()
  "Stop Swank"
  (swank:stop-server *port-number*)
  (setf *swank-server-p* nil)
  (message "Stopping Swank Server! Closing Port^5 ~a^n." *port-number*))

(defcommand toggle-swank () ()
  (if *swank-server-p*
      (run-commands "stop-swank")
      (run-commands "start-swank")))

(define-key *top-map* (kbd "s-s") "toggle-swank")

;; modeline status
;;(defun get-swank-status ()
;;  (if *swank-server-p*
;;      (setf *swank-ml-status* (format nil "Swank ^3^f1^f0^n Port:^5 ~a^n " *port-number*))
;;      (setf *swank-ml-status* "")))

;;(defun ml-fmt-swank-status (ml)
;;  (declare (ignore ml))
;;  (get-swank-status))

;;(add-screen-mode-line-formatter #\S #'ml-fmt-swank-status)

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
;;(defcommand colon1 (&optional (initial "")) (:rest)
;;  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
;;    (when cmd
;;      (eval-command cmd t))))
;;
;;;; Read some doc
;;;;(define-key *root-map* (kbd "d") "exec gv")
;;;; Browse somewhere
;;(define-key *root-map* (kbd "b") "colon1 exec firefox http://www.")
;;;; Ssh somewhere
;;(define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
;;;; Lock screen
;;(define-key *root-map* (kbd "C-l") "exec xlock")
;;
;;;; Web jump (works for DuckDuckGo and Imdb)
;;(defmacro make-web-jump (name prefix)
;;  `(defcommand ,(intern name) (search) ((:rest ,(concatenate 'string name " search: ")))
;;    (nsubstitute #\+ #\Space search)
;;    (run-shell-command (concatenate 'string ,prefix search))))
;;
;;(make-web-jump "duckduckgo" "firefox https://duckduckgo.com/?q=")
;;(make-web-jump "imdb" "firefox http://www.imdb.com/find?q=")
;;
;;;; C-t M-s is a terrble binding, but you get the idea.
;;(define-key *root-map* (kbd "M-s") "duckduckgo")
;;(define-key *root-map* (kbd "i") "imdb")
;;
;;;; Message window font
;;(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")
;;
;;;; Swap ctrl and caps
;;(setf *caps-lock-behavior* :swapped)
;;
;;;;; Define window placement policy...
;;
;;;; Clear rules
;;(clear-window-placement-rules)
;;
;;;; Last rule to match takes precedence!
;;;; TIP: if the argument to :title or :role begins with an ellipsis, a substring
;;;; match is performed.
;;;; TIP: if the :create flag is set then a missing group will be created and
;;;; restored from *data-dir*/create file.
;;;; TIP: if the :restore flag is set then group dump is restored even for an
;;;; existing group using *data-dir*/restore file.
;;(define-frame-preference "Default"
;;  ;; frame raise lock (lock AND raise == jumpto)
;;  (0 t nil :class "Konqueror" :role "...konqueror-mainwindow")
;;  (1 t nil :class "XTerm"))
;;
;;(define-frame-preference "Ardour"
;;  (0 t   t   :instance "ardour_editor" :type :normal)
;;  (0 t   t   :title "Ardour - Session Control")
;;  (0 nil nil :class "XTerm")
;;  (1 t   nil :type :normal)
;;  (1 t   t   :instance "ardour_mixer")
;;  (2 t   t   :instance "jvmetro")
;;  (1 t   t   :instance "qjackctl")
;;  (3 t   t   :instance "qjackctl" :role "qjackctlMainForm"))
;;
;;(define-frame-preference "Shareland"
;;  (0 t   nil :class "XTerm")
;;  (1 nil t   :class "aMule"))
;;
;;(define-frame-preference "Emacs"
;;  (1 t t :restore "emacs-editing-dump" :title "...xdvi")
;;  (0 t t :create "emacs-dump" :class "Emacs"))
