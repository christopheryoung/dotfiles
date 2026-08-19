;;; early-init.el --- Loaded before the GUI and package.el  -*- lexical-binding: t -*-

;; Packages are managed by straight.el (see custom-packages.el), so
;; package.el should not activate anything at startup.
(setq package-enable-at-startup nil)

;; Don't let the frame flash a toolbar on its way up.
(push '(tool-bar-lines . 0) default-frame-alist)

;;; early-init.el ends here
