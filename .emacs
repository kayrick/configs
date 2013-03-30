(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(menu-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "xos4" :family "Terminus")))))


;; Prevent emacs from creation the backup *~ files
(setq make-backup-files nil)
;; End.

;; Remove splash screen
(setq inhibit-splash-screen t)

;; Enable semantic mode
(semantic-mode 1)
;; End.

;; Save history
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(setq savehist-file "~/.emacs.d/savehist")
;; End.

;; Enable TAB completion for lisp
(setq tab-always-indent 'complete)


;; Autoindentation.
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Enable list completion.
(add-hook 'lisp-mode-hook (lambda () (local-set-key [tab] 'lisp-complete-symbol)))

;; Undo.
(global-set-key (kbd "C-z") 'undo)