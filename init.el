
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
 '(package-selected-packages '(markdown-mode))
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














(provide 'init.el)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
