;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
 (setq doom-font (font-spec :family "Iosevka" :size 18 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ****************************************************************************
;; CUSTOMIZATIONS
;; This is where the default doom-emacs config.el ends and my stuff begins.
;;
;; The order is as follows:
;;
;; 1. Look & Feel mods
;; 2. Features
;; 3. Keyboard bindings
;;
;; ****************************************************************************

;; ****************************************************************************
;; LOOK & FEEL
;; ****************************************************************************

;; ----------------------------------------------------------------------------
;; ACTIVATE DIMMER
;; (for some reason, this has to be done before the theme)
(use-package dimmer
  :config
  (dimmer-mode t)
)

(setq catppuccin-flavor 'mocha)


;; ----------------------------------------------------------------------------
;; TERM WINDOW DIVIDER SETUP
(custom-theme-set-faces! 'catppuccin '(vertical-border :background "#1b1b29" :foreground "#111120"))
(set-face-inverse-video-p 'vertical-border nil)
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?┃))
(defun my-change-window-divider ()
  (let ((display-table (or buffer-display-table standard-display-table)))
    (set-display-table-slot display-table 5 ?│)
    (set-window-display-table (selected-window) display-table)))
(add-hook 'window-configuration-change-hook 'my-change-window-divider)
(set-display-table-slot standard-display-table 'vertical-border ?│)

;; ----------------------------------------------------------------------------
;; THEME SETUP
(custom-theme-set-faces! 'catppuccin
  '(default :background "#1b1b29")
  '(fringe :background "#1b1b29")
  '(avy-lead-face :background nil :foreground "#eeeeff")
  '(avy-lead-face-0 :background nil :foreground "#9999ff")
  '(avy-lead-face-1:background nil :foreground "#8888ff")
  '(avy-lead-face-2 :background nil :foreground "#7777ff")
  '(avy-background-face :background nil :foreground "#444466")
  '(line-number :foreground "#111120")
  '(hl-line :background "#111120")
  '(region :background "#303042")
  )


(setq doom-font (font-spec :family "CommitMono" :size 15 :weight 'Medium))

;; ----------------------------------------------------------------------------
;; COMPLETION ICONS
(use-package kind-icon
  :ensure t
  :after corfu
  ;:custom
  ; (kind-icon-blend-background t)
  ; (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; ----------------------------------------------------------------------------
;; Set symbol for the border
(set-display-table-slot standard-display-table
                        'vertical-border
                        (make-glyph-code ?│))

(setq lsp-modeline-code-action-fallback-icon "󰌵")

;; ----------------------------------------------------------------------------
;; BEGIN DIMMER Config
(use-package dimmer
  :ensure
  :defer
  :init
    (defun advise-dimmer-config-change-handler ()
      "Advise to only force process if no predicate is truthy."
      (let ((ignore (cl-some (lambda (f) (and (fboundp f) (funcall f)))
                             dimmer-prevent-dimming-predicates)))
        (unless ignore
          (when (fboundp 'dimmer-process-all)
            (dimmer-process-all t)))))

    (defun corfu-frame-p ()
      "Check if the buffer is a corfu frame buffer."
      (string-match-p "\\` \\*corfu" (buffer-name)))

     ;;; Instead of corfu-frame-p
      (defun show-paren-child-frame-p ()
        "Check if the buffer is a show-paren's context child frame."
        (string-prefix-p " *show-paren context*" (buffer-name)))
      ;;; instead of dimmer-configure-corfu
      (defun dimmer-configure-show-paren-child-frame ()
        "Convenience settings for show-paren’s child-frame users."
        (add-to-list
         'dimmer-prevent-dimming-predicates
         #'show-paren-child-frame-p))

     ;;; Instead of corfu-frame-p
      (defun lsp-signature-p ()
        "Check if the buffer is a show-paren's context child frame."
        ;; (string-prefix-p " *lsp-signature*" (buffer-name)))
        ;;(string-prefix-p "^ \\*.*posframe.*\\*$" (buffer-name)))
        (string-prefix-p " *Flycheck errors*" (buffer-name)))
      ;;; instead of dimmer-configure-corfu
      (defun dimmer-configure-lsp-signature ()
        "Convenience settings for show-paren’s child-frame users."
        (add-to-list
         'dimmer-prevent-dimming-predicates
         #'lsp-signature-p))

    (defun dimmer-configure-corfu ()
      "Convenience settings for corfu users."
      (add-to-list
       'dimmer-prevent-dimming-predicates
       #'corfu-frame-p))
    (defun dimmer-configure-minibuffers ()
      "Convenience settings for corfu users."
      (add-to-list
       'dimmer-prevent-dimming-predicates
       #'which-key--popup-showing-p))
  :custom
    (dimmer-watch-frame-focus-events nil)
    (dimmer-exclusion-regexp-list '("^\\*[h|H]elm.*\\*"
                                  "^\\*Minibuf-.*\\*"
                                  "^ \*which-key\*$"
                                  "^ \*LV\*$"
                                  "^ \*transient\*$"
                                  "^ \*Minibuf-[0-9]+\*$"
                                  "^ \*Echo.*\*$"
                                  ".*ransient.*" ; magit and dired keys
                                  ".*osfr.*" ; magit and dired keys
                                  "^ \*Help\*$"
                                  "^\\*Echo.*"
                                  "^.\\*which-key\\*$"
                                  "^ \\*.*Flycheck.*\\*$"
                                  "^ \\*.*posframe.*\\*$"))
  :config
    (advice-add
     'dimmer-config-change-handler
     :override 'advise-dimmer-config-change-handler)
    ;(dimmer-configure-show-paren-child-frame)
    (setq dimmer-fraction 0.8)
    (setq dimmer-adjustment-mode :foreground)
    (setq dimmer-use-colorspace :rgb)
    (dimmer-configure-which-key)
    (dimmer-configure-helm)
    (dimmer-configure-posframe)
    (dimmer-configure-company-box)
    (dimmer-configure-corfu)
    (dimmer-configure-lsp-signature)
    (dimmer-configure-minibuffers)
   )
;; END DIMMER Config
;; ----------------------------------------------------------------------------

;; ----------------------------------------------------------------------------
;; Make the mode-line shorter for rust buffers
;; https://github.com/seagle0128/doom-modeline/blob/master/doom-modeline.el#L90
(after! doom-modeline
    (doom-modeline-def-modeline 'my-rust-modeline
      '(bar matches buffer-info)
      '(misc-info minor-modes input-method buffer-encoding major-mode process vcs check))
    (add-hook 'doom-modeline-mode-hook
              (lambda ()
                (doom-modeline-set-modeline 'my-rust-modeline 'default)))
    (add-to-list 'doom-modeline-mode-alist '(rustic-mode . my-rust-modeline))
  )


;; ****************************************************************************
;; FEATURES
;; ****************************************************************************


(evil-define-motion my-evilem-forward-word-begin(count)
  (let ((last (point)))
    (call-interactively #'evil-forward-word-begin)
    (while (and (not (= (char-syntax (char-after (point))) ?w))
                (not (= last (point)))
             )
      (setq last (point))
      (call-interactively #'evil-forward-word-begin))
  ))

(use-package evil-easymotion
  :config
  (evilem-define (kbd "g s w") #'my-evilem-forward-word-begin)
)

(use-package evil-snipe
  :config
  (setq evil-snipe-scope 'buffer))


;; For all programming modes
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For all modes
(add-hook 'after-change-major-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))


(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))


;; ----------------------------------------------------------------------------
;; ELYSIUM config
;; (taken from the official docs)
(use-package elysium
  :custom
  (elysium-window-style 'nil)) ; vertical, horizontal or nil

(use-package gptel
  :config
  (defun gptel-api-key ()
    (shell-command-to-string "pass show openai/rlofc"))
  )

(use-package smerge-mode
  :ensure nil
  :hook
  (prog-mode . smerge-mode))


;; ----------------------------------------------------------------------------
;; ELYSIUM + SMERGE FIX
;; designed to enter smerge-mode automatically after applying elysium code
;; changes
(defun smerge-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (require 'smerge-mode)
      (smerge-mode 1))))
(add-hook 'elysium-apply-changes-hook 'smerge-try-smerge t)


;; ----------------------------------------------------------------------------
;; ORDERLESS
(defun my-orderless-non-greedy-flex (component)
  (rx-to-string
   `(seq ,@(cl-loop
            for (head . tail) on (string-to-list component)
            collect `(group ,head)
            when tail
            collect `(* (not ,(car tail)))))))

;; (thanks to https://kristofferbalintona.mposts/202202211546/)
(use-package orderless
  :custom
  (completion-styles '(orderless))
   (orderless-matching-styles
    '(
      my-orderless-non-greedy-flex
      ;orderless-literal
      ;orderless-flex
      ;orderless-prefixes
      ;orderless-initialism
      ;orderless-regexp
      ))
  )


(use-package whisper
  :bind ("C-," . whisper-run)
  :config
  (setq whisper-install-directory "/tmp/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil
        whisper-use-threads (/ (num-processors) 2)))


(add-hook 'rustic-before-save-hook 'rustic-format-buffer)
(add-hook! rustic-mode
   (setq rustic-format-trigger 'on-save))

;; When completing, automatically select the first options
(setq completion-ignore-case t)
(use-package corfu
  :hook (after-init . global-corfu-mode) ;; maybe?
  :custom
     (corfu-auto t)
     (corfu-preselect 'first)
  )

;; ****************************************************************************
;; KEYYBOARD BINDINGS
;; ****************************************************************************

(map! :after evil-easymotion
      :vn "C-/" #'avy-goto-char-timer)

(map! :after undo-fu
      :vn "u" #'undo-fu-only-undo)
(map! :after undo-fu
      :vn "C-r" #'undo-fu-only-redo)

(map! :after elysium
      :vn "SPC e" #'elysium-query)

(evil-define-key 'normal 'global (kbd "SPC") (make-sparse-keymap))
(evil-define-key 'normal 'global (kbd "SPC -") #'comment-line)
(evil-define-key 'visual 'global (kbd "SPC -") #'comment-line)
(evil-define-key 'normal 'global (kbd "SPC <left>") #'evil-window-left)
(evil-define-key 'normal 'global (kbd "SPC <right>") #'evil-window-right)
(evil-define-key 'normal 'global (kbd "SPC <up>") #'evil-window-up)
(evil-define-key 'normal 'global (kbd "SPC <down>") #'evil-window-down)
(evil-define-key 'normal 'global (kbd "C-h") #'evil-window-left)
(evil-define-key 'normal 'global (kbd "C-l") #'evil-window-right)
(evil-define-key 'normal 'global (kbd "C-k") #'evil-window-up)
(evil-define-key 'normal 'global (kbd "C-j") #'evil-window-down)

(global-set-key (kbd "<f12>") 'save-buffer)
(global-set-key (kbd "C-<f12>") 'evil-save-and-close)


;; Some unused but good to know snippets

;; ----------------------------------------------------------------------------
;; This is how to hook a message printing the buffer name
;;
;; (defun foo () (message "sig: The name of this buffer is: %s." (buffer-name)))
;; (add-hook 'minibuffer-setup-hook 'foo)

;; ----------------------------------------------------------------------------
;; Another way to set face attributes:
;;
;; (set-face-attribute
;;     'avy-lead-face
;;     nil
;;     :background nil
;;     :foreground "#eeeeff")


;; ----------------------------------------------------------------------------
;; Setting _ as part of words:
;;
;; Variant 1:
;;
;;(modify-syntax-entry ?_ "w"
;;
;; Variant 2:
;;
;;(defadvice evil-inner-word (around underscore-as-word activate)
;;  (let ((table (copy-syntax-table (syntax-table))))
;;    (modify-syntax-entry ?_ "w" table)
;;    (with-syntax-table table
;;      ad-do-it)))
;;
;; Variant 3:
;;
;; (modify-syntax-entry ?_ "w" rust-mode-syntax-table)



;; ----------------------------------------------------------------------------
;; Various font options:
;;
;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15 :weight 'Medium))
;; (setq doom-font (font-spec :family "PragmataPro" :size 14 :weight 'bold)
;;      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 13)
;;      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 15)
;;    )
;; (setq doom-font (font-spec :family "Iosevka" :size 15 :weight 'semi-light))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'catppuccin)

(setq lsp-signature-auto-activate nil)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-delay 3)
