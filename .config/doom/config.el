;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


;; ****************************************************************************
;; CUSTOMIZATIONS
;; This is where the default doom-emacs config.el ends and my stuff begins.
;;
;; The order is as follows:
;;
;; 1. Core behavior
;; 2. Look & Feel
;; 3. Packages setup
;; 4. Keyboard bindings
;;
;; ****************************************************************************


;; ****************************************************************************
;; CORE BEHAVIOUR
;; ****************************************************************************
;;
;; ViM Copy-Paste behavior
(setq evil-kill-on-visual-paste nil)

(setq lsp-signature-auto-activate nil)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-delay 3)

(setq org-directory "~/org/")
(setq org-return-follows-link  t)


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

(custom-theme-set-faces! 'catppuccin '(vertical-border :background "#1b1b29" :foreground "#111120"))
;; Set symbol for the border
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

(custom-theme-set-faces! 'catppuccin
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

(use-package catppuccin-theme
  :config
  (catppuccin-set-color 'base "#1b1b29") ;;
)
(after! catppuccin-theme
  (catppuccin-set-color 'base "#1b1b29") ;;
  (catppuccin-reload)
)

(setq display-line-numbers-type t)

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
      (let ((ignore (cl-some (lambda (f) (and (fboundp f) (funcall f)))
                             dimmer-prevent-dimming-predicates)))
        (unless ignore
          (when (fboundp 'dimmer-process-all)
            (dimmer-process-all t)))))

    (defun corfu-frame-p ()
      (string-match-p "\\` \\*corfu" (buffer-name)))

    (defun show-paren-child-frame-p ()
      (string-prefix-p " *show-paren context*" (buffer-name)))


    (defun lsp-signature-p ()
      (string-prefix-p " *Flycheck errors*" (buffer-name)))

    (defun dimmer-configure-lsp-signature ()
      (add-to-list 'dimmer-prevent-dimming-predicates #'lsp-signature-p))

    (defun dimmer-configure-corfu ()
      (add-to-list 'dimmer-prevent-dimming-predicates #'corfu-frame-p))

    (defun dimmer-configure-minibuffers ()
      (add-to-list 'dimmer-prevent-dimming-predicates #'which-key--popup-showing-p))

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
(defun dimmer-lsp-ui-doc-p ()
  (string-prefix-p " *lsp-ui-doc-" (buffer-name)))
(add-to-list 'dimmer-prevent-dimming-predicates #'dimmer-lsp-ui-doc-p)
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
;; PACKAGES SETUP
;; ****************************************************************************
;; ----------------------------------------------------------------------------

;; HOTFUZZ
(setq completion-styles '(hotfuzz))


;; For all programming modes
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; For all modes
(add-hook 'after-change-major-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol)
    ;; make evil-search-word look for symbol rather than word boundaries
    (setq-default evil-symbol-word-search t))


;; ----------------------------------------------------------------------------
;; WHISPER
(use-package whisper
  :config
  (setq whisper-install-directory "/files/bin/whisper/"
        whisper-model "base"
        whisper-language "en"
        whisper-translate nil
        whisper-use-threads (/ (num-processors) 2)))

(global-set-key (kbd "<f3>") 'whisper-run)

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
(add-hook! rustic-mode
   (setq corfu-preselect 'first))

;; ****************************************************************************
;; KEYYBOARD BINDINGS
;; ****************************************************************************

(map! :after undo-fu
      :vn "u" #'undo-fu-only-undo)
(map! :after undo-fu
      :vn "C-r" #'undo-fu-only-redo)

;(map! :vn "SPC -" #'comment-line)

(map! :vn "/" #'+default/search-buffer)
(evil-define-key 'normal 'global (kbd "SPC") (make-sparse-keymap))
(evil-define-key 'normal 'global (kbd "SPC s a") #'consult-lsp-file-symbols)
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
(map! "C-l" #'evil-window-right)
(evil-define-key 'normal 'global (kbd "`") #'evil-visual-line)
(evil-define-key 'normal 'global (kbd "C-`") #'er/expand-region)

(global-set-key (kbd "<f12>") 'save-buffer)
(global-set-key (kbd "C-<f12>") 'evil-save-and-close)
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-<next>") 'evil-jump-forward)
(global-set-key (kbd "C-<prior>") 'evil-jump-backward)
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-l") 'evil-window-right)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-j") 'evil-window-down)

;;(global-set-key (kbd "C-<f11>") "!~/bin/scwe.sh")



(evil-define-command evil-shell-command-on-region (beg end command)
 (interactive (let (cmd)
                 (unless (mark)
                   (user-error "No active region"))
                 (setq cmd (read-shell-command "Shell command on region: "))
                 (list (region-beginning) (region-end)
                       cmd)))
  (shell-command-on-region beg end command nil t shell-command-default-error-buffer t (region-noncontiguous-p)))
(defun run-scwe-script ()
  (interactive)
  (evil-shell-command-on-region (region-beginning) (region-end) "~/bin/scwgpt.sh")
  (smerge-mode 1)
  )
(global-set-key (kbd "C-<f11>") 'run-scwe-script)


(setq doom-theme 'catppuccin)
(catppuccin-set-color 'base "#1b1b29") ;;


(define-key evil-motion-state-map (kbd "RET") nil)

;;------------------------------------------------------------------------------------------------
;; BLAMER
(use-package blamer
  :custom
  (blamer-max-commit-message-length 100)
  (blamer-idle-time 2.0)
  (blamer-max-lines 1)
  (blamer-author-formatter "")
  (blamer-datetime-formatter "[%s]")
  (blamer-commit-formatter " ● %s")
  (blamer-min-offset 20)
  (blamer-max-lines 1)
  :config
  (global-blamer-mode 1))

;; (setq blamer-author-formatter "  ✎ %s ")
;; (setq blamer-datetime-formatter "[%s]")
;; (setq blamer-commit-formatter " ● %s")

(map! ;:after blamer-mode
      :leader
      :desc "Blamer popup" "g m" #'blamer-show-posframe-commit-info)
;;
;;------------------------------------------------------------------------------------------------

;;------------------------------------------------------------------------------------------------
;; AVY
(use-package avy
  :config
  (setq avy-timeout-seconds 0.2)
)
(map! :after avy :vn "SPC j" #'avy-goto-char-timer)
;;
;;------------------------------------------------------------------------------------------------


(add-hook 'lsp-mode-hook (lambda () (setq lsp-ui-doc-delay 5)))

;;------------------------------------------------------------------------------------------------
;; DIFF_HL
;; Setting diff symbols for emacs on tty
(use-package diff-hl
  :ensure t
  :custom ((diff-hl-draw-borders nil)
           ;; (diff-hl-side 'right)
           (diff-hl-margin-symbols-alist
            '((insert . "▐")
              (delete . "▐")
              (change . "▐")
              (unknown . "▐")
              (ignored . "▐"))))
  :config
  (map-keymap (lambda (_k cmd)
                (put cmd 'repeat-map 'diff-hl-command-map))
              diff-hl-command-map)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(custom-set-faces!
     '(fringe :foreground "#111120"))
;;
;;------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;; (setq read-process-output-max (* 1024 1024)) ;; 1mb
;; (setq lsp-idle-delay 0.500)
;; (setq lsp-log-io nil) ; if set to true can cause a performance hit0


; ---------------------------------------------------------------------------------------
; DISABLE $ SIGN IN FRINGES
(set-display-table-slot standard-display-table 0 ?\ )

(defvar gptel-lookup--history nil)

(require 'posframe)

(defun gptel-lookup (prompt)
  (interactive (list (read-string "Ask ChatGPT: " nil gptel-lookup--history)))
  (when (string= prompt "") (user-error "A prompt is required."))
  (gptel-request
   prompt
   :callback
   (lambda (response info)
     (if (not response)
         (message "gptel-lookup failed with message: %s" (plist-get info :status))
       (let ((posframe-buffer (get-buffer-create "*gptel-lookup*")))
         (with-current-buffer posframe-buffer
           (let ((inhibit-read-only t))
             (erase-buffer)
             (insert response)))
         (posframe-show posframe-buffer
                        :position (point)
                        :timeout 5
                        :width 60
                        :height 20
                        :min-width 20
                        :min-height 10))))))

(dolist (fn '(definition references))
  (fset (intern (format "+lookup/%s-other-window" fn))
        (lambda (identifier &optional arg)
          "TODO"
          (interactive (list (doom-thing-at-point-or-region)
                             current-prefix-arg))
          (let ((pt (point)))
            (switch-to-buffer-other-window (current-buffer))
            (goto-char pt)
            (funcall (intern (format "+lookup/%s" fn)) identifier arg)))))


;------------------------------------------------------------------------------------------------
; VERTICO POSFRAME POSITIONING
; ----------------------------
; this will position gui vertico in a centered low position
; using 300 pixels from the bottom of the screen
(defun my-vertico-posframe-positioner (info)
  (cons (/ (- (plist-get info :parent-frame-width)
              (plist-get info :posframe-width))
           2)
        (- (plist-get info :parent-frame-height)
           (plist-get info :posframe-height)
           (plist-get info :mode-line-height)
           (plist-get info :minibuffer-height)
           300)))
(setq vertico-posframe-poshandler 'my-vertico-posframe-positioner )
(setq vertico-posframe-width 120)
;
;------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------
; GPTEL AGENTS SETUP
(use-package gptel
  :config
  (defun gptel-api-key ()
    (shell-command-to-string "pass show openai/rlofc"))
  )

(defvar gptel-rewrite-with-instruction--history nil)

(defun gptel-rewrite-with-instruction (prompt)
  (interactive (list (read-string "Rewrite instruction: " nil gptel-rewrite-with-instruction--history)))
  (when (string= prompt "") (user-error "A prompt is required."))
  (setq gptel--rewrite-message prompt)
  (gptel-rewrite))

(defun gptel-rewrite-explain ()
  (interactive)
  (setq gptel--rewrite-message "Explain this code with inline comments without changing any actual line of code:")
  (gptel-rewrite))

(defun gptel-rewrite-evolve ()
  (interactive)
  (setq gptel--rewrite-message "Suggest an alternative method to implement the following code while retaining its exact functionality:")
  (gptel-rewrite))

(defun gptel-rewrite-document ()
  (interactive)
  (setq gptel--rewrite-message "Provide readable and concise code documentation above the following code. Correctly document any parameters or other language constructs according to the industry standard:")
  (gptel-rewrite))

(defun gptel-rewrite-refactor ()
  (interactive)
  (setq gptel--rewrite-message "Refactor the following code, prefering readability and then performance:")
  (gptel-rewrite))

(defun gptel-rewrite-optimize ()
  (interactive)
  (setq gptel--rewrite-message "Optimize the following code making it run as fast as possible:")
  (gptel-rewrite))

(defun gptel-rewrite-implement ()
  (interactive)
  (setq gptel--rewrite-message "Implement the provided code specification in the most efficient and readable way possible:")
  (gptel-rewrite))

(defun gptel-rewrite-specify ()
  (interactive)
  (setq gptel--rewrite-message "Using the following high-level software requirement, create a detailed specification or design using state-of-the-art design patterns:")
  (gptel-rewrite))

(map! :leader
        :prefix ("k" . "AI agents")
        :desc "refactor" "r" #'gptel-rewrite-refactor
        :desc "optimize" "o" #'gptel-rewrite-optimize
        :desc "implement" "i" #'gptel-rewrite-implement
        :desc "explain" "e" #'gptel-rewrite-explain
        :desc "evolve" "v" #'gptel-rewrite-evolve
        :desc "document" "d" #'gptel-rewrite-document
        :desc "custom" "k" #'gptel-rewrite-with-instruction
        :desc "specify" "s" #'gptel-rewrite-specify
        :desc "add to context" "a" #'gptel-add
        :desc "clear context" "c" #'gptel-context-remove-all
        :desc "window" "w" #'gptel
        :desc "send" "s" #'gptel-send)


(setq gptel-rewrite-default-action 'merge)

(add-hook 'smerge-mode-hook
          (lambda ()
            (if smerge-mode
                (flycheck-mode -1)
              (flycheck-mode 1))))
;
;------------------------------------------------------------------------------------------------
