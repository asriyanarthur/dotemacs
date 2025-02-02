
;; -> PACKAGE
;; Встроенный пакет.
;; Настройка архивов пакетов 
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-archive-priorities
   '(("gnu" . 50)
     ("nongnu" . 40)
     ("melpa-stable" . 30)
     ("melpa" . 20)))
 '(package-native-compile t)
 '(package-selected-packages
   '(lsp-mode go-mode helm-projectile helm region-bindings-mode multiple-cursors magit flycheck projectile nerd-icons-dired markdown-mode))
 '(ring-bell-function #'ignore)
 '(scroll-bar-mode nil))
(add-to-list 'package-pinned-packages '("use-package" . "gnu"))
;; Проверка наличия пакета `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package t))
(require 'use-package)


(defalias 'yes-or-no-p 'y-or-n-p)

(require 'menu-bar)






(require 'scroll-bar)





;; -> SAVEPLACE
;; Встроенный пакет.
;; Восстанавливает позицию курсора в файле при его открытии.
(require 'saveplace)
(save-place-mode 1)




;;-> DELSEL
;; Встроенный пакет
;; Управление выделенными фрагментами текста.
(require 'delsel)
(delete-selection-mode t) ;; Удалять выделенный фрагмент при вводе текста






(use-package markdown-mode
:ensure t
:pin "melpa-stable")




(defconst default-font-height 14 "Размер шрифта по умолчанию.") 
;; -> Настройки, специфичные для графического режима
(defun setup-gui-settings (frame-name)
"Настройки, необходимые при запуске EMACS в графической среде.
FRAME-NAME — имя фрейма, который настраивается."
(when (display-graphic-p frame-name)
(global-font-lock-mode t) ;; Отображать шрифты красиво, используя Font Face's
(defvar availiable-fonts (font-family-list)) ;; Какие есть семейства шрифтов?
(defvar default-font-family nil "Шрифт по умолчанию.")
;; Перебор шрифтов
(cond
((member "Fire Code Nerd" availiable-fonts)
(setq default-font-family "Fira Code Nerd"))
((member "Fira Code" availiable-fonts)
(setq default-font-family "Fira Code"))
((member "DejaVu Sans Mono Nerd" availiable-fonts)
(setq default-font-family "DejaVu Sans Mono Nerd"))
((member "DejaVu Sans Mono" availiable-fonts)
(setq default-font-family "DejaVu Sans Mono"))
((member "Source Code Pro" availiable-fonts)
(setq default-font-family "Source Code Pro"))
((member "Consolas" availiable-fonts)
(setq default-font-family "Consolas")))
(when default-font-family
;; Это формат X Logical Font Description Conventions, XLFD
;; https://www.x.org/releases/X11R7.7/doc/xorg-docs/xlfd/xlfd.html
(set-frame-font
(format "-*-%s-normal-normal-normal-*-%d-*-*-*-m-0-iso10646-1"
default-font-family
emacs-default-font-height) nil t)
(set-face-attribute 'default nil :family default-font-family))
(set-face-attribute 'default nil :height (* emacs-default-font-height 10))))
;; Правильный способ определить, что EMACS запущен в графическом режиме. Подробнее здесь:
;; https://emacsredux.com/blog/2022/06/03/detecting-whether-emacs-is-running-in-terminal-or-gui-mode/
(add-to-list 'after-make-frame-functions #'setup-gui-settings)





;; -> AUTOREVERT
;; Встроенный пакет
(use-package autorevert
:hook
(dired-mode . auto-revert-mode))


;; -> DIRED
;; Встроенный пакет для работы с файлами и каталогами.
;; Клавиши:
;; [+] - создание каталога.
;; [C-x C-f] - создание файла с последующим открытием буфера.
;;(use-package dired
;;:custom
;;(dired-kill-when-opening-new-dired-buffer t "Удалять буфер при переходе в другой каталог.")
;;(dired-listing-switches "-lah --group-directories-first") "Каталоги в начале списка")


;; -> NERD-ICONS-DIRED
;; https://github.com/rainstormstudio/nerd-icons-dired
;; Иконки в `dired'.
(use-package nerd-icons-dired
  :ensure t
  :after (dired nerd-icons)
  :hook (dired-mode . nerd-icons-dired-mode))



(use-package elisp-mode
	:config
	(setq-local tab-width 2))


;; -> PROJECTILE
;; https://docs.projectile.mx/projectile/installation.html
;; Управление проектами. Чтобы каталог считался проектом, он должен быть
;; под контролем любой системы версионирования, либо содержать специальные
;; файлы. В крайнем случае сгодится пустой файл .projectile
;; Подробнее здесь: https://docs.projectile.mx/projectile/projects.html
(use-package projectile
:ensure t
:diminish "PRJ"
:bind-keymap
("C-x p" . projectile-command-map)
:config
(projectile-mode 1))



;; -> FLYMAKE
;; Более свежая версия встроенного пакета из репозитория GNU
;; Используется для проверки `init.el'.
;; https://elpa.gnu.org/packages/flymake.html
(use-package flymake
  :pin "gnu"
  :ensure t
  :hook
  ((
    emacs-lisp-mode
    lisp-data-mode
    ) . flymake-mode))

;;;; -> FLYCHECK
;;;; https://www.flycheck.org/
;;;; Проверка синтаксиса на лету с помощью статических анализаторов
;;(use-package flycheck
;;  :pin "melpa-stable"
;;  :ensure t
;;  :defer t
;;  :custom
;;  (flycheck-check-syntax-automatically '(mode-enabled save new-line))
;;  (flycheck-highlighting-mode 'lines "Стиль отображения проблемных мест — вся строка")
;;  (flycheck-indication-mode 'left-fringe "Место размещения маркера ошибки — левая граница")
;;  (flycheck-locate-config-file-functions '(
;;					   flycheck-locate-config-file-by-path
;;					   flycheck-locate-config-file-ancestor-directories
;;					   flycheck-locate-config-file-home))
;;  (flycheck-markdown-markdownlint-cli-config "~/.emacs.d/.markdownlintrc" "Файл настроек
;;Markdownlint")
;;  (flycheck-textlint-config ".textlintrc.yaml" "Файл настроек Textlint")
;;  :hook
;;  ((
;;    adoc-mode
;;    conf-mode
;;    css-mode
;;    dockerfile-mode
;;    emacs-lisp-mode
;;    js2-mode
;;    json-mode
;;    latex-mode
;;    lisp-data-mode
;;    makefile-mode
;;    markdown-mode
;;    nxml-mode
;;    python-mode
;;    rst-mode
;;    ruby-mode
;;    sh-mode
;;    sql-mode
;;    terraform-mode
;;    web-mode
;;    yaml-mode
;;    ) . flycheck-mode))



;; -> MAGIT
;; https://magit.vc/
;; Magic + Git + Git-gutter. Лучшее средство для управления Git.
(use-package magit
	:pin "nongnu"
	:ensure t
	:defer t
	:custom
	(magit-define-global-key-bindings t "Включить глобальные сочетания Magit.")
	:config
	(add-hook 'after-save-hook 'magit-after-save-refresh-status t))


;; -> MARKDOWN MODE
;; https://github.com/jrblevin/markdown-mode
;; Режим для работы с файлами в формате Markdown
(use-package markdown-mode
	:ensure t
	:defer t
	:custom
	(markdown-fontify-code-blocks-natively t "Подсвечивать синтаксис в примерах кода")
	(markdown-header-scaling-values '(1.0 1.0 1.0 1.0 1.0 1.0) "Все заголовки одной высоты")
	(markdown-list-indent-width 4 "Размер отступа для выравнивания вложенных списков")
	:config (setq-local word-wrap t)
	:bind (
				 :map markdown-mode-map
				 ("M-." . markdown-follow-thing-at-point))
	:mode ("\\.md\\'" . markdown-mode))


(use-package multiple-cursors
  :ensure t
  :bind(("C-S-c C-S-c" . mc/edit-lines)
        ("C->" . mc/mark-next-like-this)
        ("C-<" . mc/mark-previous-like-this)
        ("C-c C-<" . mc/mark-all-like-this)
        ("C-c n" . mc/insert-numbers)
	("C-c m" . mc/mark-all-in-region)
	)
  :config
  (setq mc/insert-numbers-default 1))   


;;(use-package region-bindings-mode
;;  :ensure t
;;  :bind(( "g" . keyboard-quit)
;;	( "a" . mc/mark-all-like-this)
;;	( "p" . mc/mark-previous-like-this)
;;	( "n" . mc/mark-next-like-this)
;;	( "m" . mc/mark-more-like-this-extended)
;;	( "P" . mc/unmark-previous-like-this)	
;;	( "N" . mc/unmark-next-like-this)
;;	( "[" . mc/cycle-backward)
;;	( "]" . mc/cycle-forward)
;;	( "h" . mc-hide-unmatched-lines-mode)
;;	( "\\". mc/vertical-align-with-space)
;;	( "#" . mc/insert-numbers) 
;;	( "^" . mc/edit-beginnings-of-lines)
;;	( "$" . mc/edit-ends-of-lines)))

;;(region-bindings-mode-enable)

(use-package region-bindings-mode
  :ensure t)

(region-bindings-mode-enable)

(define-key region-bindings-mode-map "g" 'keyboard-quit)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
(define-key region-bindings-mode-map "P" 'mc/unmark-previous-like-this)
(define-key region-bindings-mode-map "N" 'mc/unmark-next-like-this)
(define-key region-bindings-mode-map "[" 'mc/cycle-backward)
(define-key region-bindings-mode-map "]" 'mc/cycle-forward)
(define-key region-bindings-mode-map "h" 'mc-hide-unmatched-lines-mode)
(define-key region-bindings-mode-map "\\" 'mc/vertical-align-with-space)
(define-key region-bindings-mode-map "#" 'mc/insert-numbers) ; use num prefix to set the starting number
(define-key region-bindings-mode-map "^" 'mc/edit-beginnings-of-lines)
(define-key region-bindings-mode-map "$" 'mc/edit-ends-of-lines)
  






;; -> HELM
;; https://github.com/emacs-helm/helm
;; Подсказки и автодополнение ввода.
;; [C-o] — переключение между источниками подсказок (история и полный список команд)
(use-package helm
:ensure t
:diminish ""
:config
(helm-mode 1)
:bind (:map global-map
("C-x C-f" . helm-find-files)
("C-x b" . helm-buffers-list)
("M-x" . helm-M-x)
("M-y" . helm-show-kill-ring)))


;; -> HELM-PROJECTILE
;; https://github.com/bbatsov/helm-projectile
;; Интеграция HELM с PROJECTILE
(use-package helm-projectile
  :ensure t
  :diminish ""
  :requires (helm projectile)
  :after (helm projectile)
  :config
  (helm-projectile-on))


(use-package go-mode
  :ensure t
  :mode "\\.go\\'")

(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'before-save-hook 'gofmt-before-save)



(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;;(use-package X-mode
;;  :init
;;  (add-to-list 'treesit-language-source-alist '(X "https://github.com/tree-sitter/tree-sitter-X"))
;;  ;; (treesit-install-language-grammar 'X)
;;  (add-to-list 'major-mode-remap-alist '(X-mode . X-ts-mode))
;;  ;; ...
;;  )
;;
;;(use-package go-ts-mode
;;  :hook
;;  (go-ts-mode . lsp-deferred)
;;  (go-ts-mode . go-format-on-save-mode)
;;  :init
;;  (add-to-list 'treesit-language-source-alist '(go "https://github.com/tree-sitter/tree-sitter-go"))
;;  (add-to-list 'treesit-language-source-alist '(gomod "https://github.com/camdencheek/tree-sitter-go-mod"))
;;  ;; (dolist (lang '(go gomod)) (treesit-install-language-grammar lang))
;;  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-ts-mode))
;;  (add-to-list 'auto-mode-alist '("/go\\.mod\\'" . go-mod-ts-mode))
;;  :config
;;  (reformatter-define go-format
;;    :program "goimports"
;;    :args '("/dev/stdin"))
;;;;:general
;;  ;; ...
;;  )




;; (use-package flycheck
;;  :ensure t)
;; 
;; (use-package lsp
;;  :ensure t)
;; 
;; 
;; (use-package lsp-mode
;;  :ensure t)


;;(use-package lsp-mode)
;;
;;;;(require 'lsp-mode)
;;;;(require 'go-mode)
;;
;;(add-hook 'go-mode-hook 'lsp-deferred)
;;(add-hook 'go-mode-hook 'subword-mode)
;;(add-hook 'before-save-hook 'gofmt-before-save)
;;
;;(add-hook 'go-mode-hook (lambda ()
;;                          (setq tab-width 4)
;;                          (flycheck-add-next-checker 'lsp 'go-vet)
;;                          (flycheck-add-next-checker 'lsp 'go-staticcheck)))





(use-package term
  :bind (("C-c t" . term)
         :map term-mode-map
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)
         :map term-raw-map
         ("M-o" . other-window)
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)))





(provide 'init.el)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
