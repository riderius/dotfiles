;; Inhibit startup/splash screen (setq inhibit-splash-screen   t)
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t) ;; welcome screen C-h C-a

;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1)
(tool-bar-mode     -1)
(scroll-bar-mode   -1)
(blink-cursor-mode -1)
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)

;; Coding-system settings
(set-language-environment 'UTF-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq-default coding-system-for-read    'utf-8)
(setq file-name-coding-system           'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system        'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(prefer-coding-system                   'utf-8)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Show-paren-mode settings
(show-paren-mode t)
;;(setq show-paren-style 'expression)

;; Disable backup/autosave files
(setq make-backup-files          t)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;; Display file size/time in mode-line
(setq display-time-24hr-format t)
(display-time-mode             t)
(size-indication-mode          t)

;; IDO plugin
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;; Linum plugin
(require 'linum)
(line-number-mode   t)
(global-linum-mode  t)
(column-number-mode t)
(setq linum-format " %d")

;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'package-archives
             (cons "nongnu" (format "http%s://elpa.nongnu.org/nongnu/"
                                    (if (gnutls-available-p) "s" ""))))

(require 'evil)
(evil-mode 1)

(require 'auto-complete)
(ac-config-default)
(add-hook 'c++-mode-hook 'irony-mode)

;color theme https://github.com/bkruczyk/badwolf-emacs
(load-theme 'badwolf t)

