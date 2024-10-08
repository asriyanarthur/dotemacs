;;; region-bindings-mode-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from region-bindings-mode.el

(autoload 'region-bindings-mode "region-bindings-mode" "\
Enable special bindings when working with an active region.

Do not invoke `region-bindings-mode' directly!

Toggling the mode on and off via this function will simply
enable/disable the bindings, but it will not honour
`region-bindings-mode-disabled-modes' or
`region-bindings-mode-disable-predicates', or toggle activation
of the hooks which automatically enable/disable the bindings when
the mark is activated or deactivated.

Instead, call `region-bindings-mode-enable' and
`region-bindings-mode-enable'.

This is a minor mode.  If called interactively, toggle the
`Region-Bindings mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `region-bindings-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(register-definition-prefixes "region-bindings-mode" '("region-bindings-mode-"))

;;; End of scraped data

(provide 'region-bindings-mode-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; region-bindings-mode-autoloads.el ends here
