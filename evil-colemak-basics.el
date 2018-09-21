;;; evil-colemak-basics.el --- Basic Colemak key bindings for evil-mode

;; Author: Wouter Bolsterlee <wouter@bolsterl.ee>
;; Version: 2.0.0
;; Package-Requires: ((emacs "24") (evil "1.2.12") (evil-snipe "2.0.3"))
;; Keywords: colemak evil
;; URL: https://github.com/wbolster/evil-colemak-basics
;;
;; This file is not part of GNU Emacs.

;;; License:

;; Licensed under the same terms as Emacs.

;;; Commentary:

;; This package provides basic key rebindings for evil-mode with the
;; Colemak keyboard layout.  See the README for more information.
;;
;; To enable globally, use:
;;
;;   (global-evil-colemak-basics-mode)
;;
;; To enable for just a single buffer, use:
;;
;;   (evil-colemak-basics-mode)

;;; Code:

(require 'evil)
(require 'evil-snipe)

(defgroup evil-colemak-basics nil
  "Basic key rebindings for evil-mode with the Colemak keyboard layout."
  :prefix "evil-colemak-basics-"
  :group 'evil)

(defcustom evil-colemak-basics-rotate-t-f-j t
  "Whether to keep find-char and end of word jumps at their qwerty position.

When non-nil, this will rotate the t, f, and j keys, so that f
jumps to the end of the word (qwerty e, same position), t jumps to a
char (qwerty f, same position), and j jumps until a char (qwerty t,
different position)."
  :group 'evil-colemak-basics
  :type 'boolean)

(defcustom evil-colemak-basics-char-jump-commands nil
  "The set of commands to use for jumping to characters.

By default, the built-in evil commands evil-find-char (and
variations) are used; when set to the symbol 'evil-snipe, this
behaves like evil-snipe-override-mode, but adapted to the right
keys.

This setting is only used when the character jump commands are
rotated; see evil-colemak-basics-rotate-t-f-j."
  :group 'evil-colemak-basics
  :type '(choice (const :tag "default" nil)
                 (const :tag "evil-snipe" evil-snipe)))

(defun evil-colemak-basics--make-keymap ()
  "Initialise the keymap baset on the current configuration."
  (let ((keymap (make-sparse-keymap)))
    (evil-define-key '(motion normal visual) keymap
      "u" 'evil-previous-visual-line
      "e" 'evil-next-visual-line
      "a" 'evil-backward-char
      "o" 'evil-forward-char
      (kbd "M-u") 'evil-open-above
      (kbd "M-e") 'evil-open-below
      (kbd "M-a") 'evil-insert
      (kbd "M-o") 'evil-append
      "f" 'evil-backward-word-begin
      "b" 'evil-forward-word-begin
      "F" 'evil-beginning-of-line
      "B" 'evil-end-of-line
      (kbd "M-f") 'evil-insert-line
      (kbd "M-b") 'evil-append-line)
    (evil-define-key 'operator keymap
      "o" 'evil-forward-char)
    keymap))

(defvar evil-colemak-basics-keymap
  (evil-colemak-basics--make-keymap)
  "Keymap for evil-colemak-basics-mode.")

(defun evil-colemak-basics--refresh-keymap ()
  "Refresh the keymap using the current configuration."
  (setq evil-colemak-basics-keymap (evil-colemak-basics--make-keymap)))

;;;###autoload
(define-minor-mode evil-colemak-basics-mode
  "Minor mode with evil-mode enhancements for the Colemak keyboard layout."
  :keymap evil-colemak-basics-keymap
  :lighter " hnei")

;;;###autoload
(define-globalized-minor-mode global-evil-colemak-basics-mode
  evil-colemak-basics-mode
  (lambda () (evil-colemak-basics-mode t))
  "Global minor mode with evil-mode enhancements for the Colemak keyboard layout.")

(provide 'evil-colemak-basics)

;;; evil-colemak-basics.el ends here

