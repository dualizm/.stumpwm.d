;; author: ezqb
;; file: stumpwm config

;; quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
				       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;; load stumpwm
(in-package :stumpwm)

;; bind prefix key
(set-prefix-key (kbd "C-t"))

;; color theme
(setf *color-white* "#ffffff"
      *color-orange* "#e68910"
      *color-magenta* "#d34474"
      *color-purple* "#1c1d36"
      *color-gray* "#161616"
      *color-black* "#0c0b16")

;; groups
(when *initializing*
  (grename "www")
  (gnewbg  "dev")
  (gnewbg  "tlg"))

;; color theme
(set-fg-color *color-orange*)
(set-bg-color *color-purple*)
(set-border-color *color-black*)
(set-msg-border-width 2)

;; mod-line config
(setf *mode-line-timeout* 1)
(setf *mode-line-border-width* 0)
(setf *mode-line-background-color* *color-purple*)
(setf *mode-line-border-color* *color-black*)
(setf *mode-line-foreground-color* *color-orange*)
(mode-line)

;;(setf *time-modeline-string* *time-modeline-string-default*)

(setf *screen-mode-line-format*
      (list "(%g) "       ; groups
	    "%W"              ; windows
	    "^>"              ; right align
	    ;;"%S"              ; swank status
	    ;;"%B"              ; battery percentage
	    "%C" ;cpu
	    ;"%M" ;ram
	    ;"%B" ;bat
            "%d"))            ; time/date


;; winddows config
(setf *window-format* "%m%n%s%20t")
(setf *mouse-focus-policy* :click)
(setf *message-window-padding* 20)
(set-msg-border-width 2)
(setf *timeout-wait 4)
(setf *message-window-gravite :top-right)
(setf *input-window-gravity* :top-right)

;; font
(set-font "Iosevka Nerd Font Mono:size=14")

;; wallpaper
(run-shell-command "feh --bg-fill /home/ez/pic/8-bit/pixelart-night-darkfantasy.jpg")

;; keyboard
(run-shell-command "setxkbmap -option ctrl:swapcasp")
(run-shell-command "setxkbmap -layout us,ru -option grp:rctl_toggle")

;; standalone compositor
(run-shell-command "picom")

;; audio server
;;(run-shell-command "pipewire")

;; mouse hidde
;;(run-shell-command "xsetroot -cursor_name left_ptr")

;; set terminal
(define-key *root-map* (kbd "Return") "exec alacritty")
(define-key *root-map* (kbd "c") "exec alacritty")
(define-key *root-map* (kbd "C-c") "exec alacritty")

;;(set-font (list
;;	   (make-instance 'xft:font
;;			  :family "Monoid"
;;			  :subfamily "Bold"
;;			  :size 13)
;;	   (make-instance 'xft:font
;;			  :family "Monoid"
;;			  :subfamily "Regular"
;;			  :size 12)))

;; slynk server
;;(defcommand slynk (port) ((:string "Port number: "))
;;  (sb-thread:make-thread
;;   (lambda ()
;;     (slynk:create-server :port (parse-integer port) :dont-close t))
;;   :name "slynk-manual"))

;;(defparameter *slynk-port-number* 4004)
;;(defvar *slynk-status-p* nil)
;;
;;(defcommand start-slynk () ()
;;  (if *slynk-status-p*
;;      (message "slynk server is already active on port ~a~%" *slynk-port-number*)
;;      (progn
;;	(slynk:create-server :port *slynk-port-number*
;;			     :style slynk:*communication-style*
;;			     :dont-close t)
;;	(setf *slynk-status-p* t)
;;	(message "slynk server run~%port: ~a~%" *port-number*))))
;;
;;(defcommand stop-slynk () ()
;;  (slynk:stop-server *slynk-port-number*)
;;  (setf *slynk-status-p* nil)
;;  (message "stopping slynk!~%closing port: ~a~%" *slynk-port-number*))

;; application
(defcommand firefox () ()
  "Start Forefox or switch to it, if it is already running"
  (run-or-raise "firefox" '(:class "Firefox")))

(define-key *root-map* (kbd "b") "firefox")

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
