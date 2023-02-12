;;;; author: ezqb
;;;; file: stumpwm config

;;; load stumpwm	  
(in-package :stumpwm)

;;; bind prefix key		   
(set-prefix-key (kbd "C-t"))	   

;;; quicklisp
(init-load-path #p"~/.stumpwm.d/modules/")
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
				       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;;; color theme
(defparameter *color-white*	"#ffffff")
(defparameter *color-orange*	"#e68910")
(defparameter *color-magenta*   "#d34474")
(defparameter *color-purple*	"#1c1d36")
(defparameter *color-gray*	"#161616")
(defparameter *color-black*     "#0c0b16")

;;; groups
(when *initializing*
  (grename "www")
  (gnewbg  "dev")
  (gnewbg  "d2v")
  (gnewbg  "spk")
  (gnewbg  "gam"))

;;; color theme
(set-fg-color *color-magenta*)
(set-bg-color *color-purple*)
(set-border-color *color-black*)
(set-msg-border-width 2)

;;; mod-line config
(defparameter *mode-line-timeout*          1)
(defparameter *mode-line-border-width*     0)
(defparameter *mode-line-border-color*     *color-black*)
(defparameter *mode-line-background-color* *color-purple*)
(defparameter *mode-line-foreground-color* *color-magenta*)
(mode-line)

;;(setf *time-modeline-string* *time-modeline-string-default*)

(defparameter *screen-mode-line-format*
      (list "(%g) "       ; groups
	    "'(%W)"              ; windows
	    "^>"              ; right align
	    ;;"%S"              ; swank status
	    ;;"%B"              ; battery percentage
	    ;;"%C" ;cpu
	    ;;"%M" ;ram
	    ;;"%B" ;bat
            "(%d)"))            ; time/date


;;; winddows config
(defparameter *window-format* "%m%n:%20t")
(defparameter *mouse-focus-policy* :click)
(defparameter *message-window-padding* 20)
(defparameter *timeout-wait 4)
(defparameter *message-window-gravite :top-right)
(defparameter *input-window-gravity* :top-right)
(set-msg-border-width 2)

;;; font
;;(ql:quickload 'truetype-clx)
;;(require 'truetype-clx)
;;(load-module "ttf-fonts")
;;(set-font (list
;;	   (make-instance 'xft:font
;;			  :family "Iosevka Nerd Font Mono"
;;			  :size 14
;;			  :subfamily "Regular")))

(set-font "-UKWN-VictorMono NFM-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")

;;; wallpaper
;;(run-shell-command "feh --bg-fill ~/pic/8-bit/pixelart-night-darkfantasy.jpg")

;;; standalone compositor    
;;(run-shell-command "picom")  

;;; set terminal
;;(define-key *root-map* (kbd "Return") "exec alacritty")
;;(define-key *root-map* (kbd "c") "exec alacritty")
;;(define-key *root-map* (kbd "C-c") "exec alacritty")

;; slynk server
(ql:quickload :slynk)
(defvar *slynk-port* (+ slynk::default-server-port 1))
(defparameter *slynk-session* nil)

(defcommand slynk-start () ()
  (defparameter *slynk-session*
    (slynk:create-server
     :port *slynk-port*
     :dont-close t))
  (message "slynk server start!~%port: ~a~%" *slynk-port*))
  
(defcommand slynk-restart () ()
  (slynk-stop)
  (slynk-start))

(defcommand slynk-stop () ()
  (slynk:stop-server *slynk-port*)
  (defparameter *slynk-session* nil)
  (message "Stop slynk!~%closing port: ~a~%" *slynk-port*))

(defcommand slynk-status () ()
  (if *slynk-session*
      (message "Slynk running on port: ~a~%" *slynk-port*)
      (message "Slynk not running~%")))

;;; application
(defcommand firefox () ()
  "Start Forefox or switch to it, if it is already running"
  (run-or-raise "firefox" '(:class "Firefox")))

(define-key *root-map* (kbd "b") "firefox")

;;; keyboard
(defparameter *caps-lock-behavior* :swapped)
(run-shell-command "exec setxkbmap -layout us,ru -option grp:rctl_toggle")	 
(run-shell-command "exec xsetroot -cursor_name left_ptr")			 

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
