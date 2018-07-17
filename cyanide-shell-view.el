;; This file is part of CyanIDE.
;;
;; CyanIDE is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; CyanIDE is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with CyanIDE.  If not, see <http://www.gnu.org/licenses/>.

(require 'cyanide-project)
(require 'cyanide-view)

(cyanide-view
 :id 'cyanide-shell-view
 :display-name "cyanide-shell-view"
 :teardown-hook '(cyanide-default-disabler)
 :load-hook '((lambda nil
                (progn
                  (when cyanide-current-project
                    (setq frame-title-format
                          (cyanide-project-and-views-frame-title)))
                  ;; Prevent annoying emacs habit of splitting
                  ;; windows without prompting from the user.
                  ;; Remember original values so that they can
                  ;; be restored when the view is torn down.
                  (setq split-height-threshold-orig
                        split-height-threshold)
                  (setq split-width-threshold-orig
                        split-width-threshold)
                  (setq split-height-threshold 80)
                  (setq split-width-threshold 9999)
                  (if cyanide-current-project
                      (cyanide-render-menu-with-tasks cyanide-current-project
                                                      'cyanide-default-menu-with-tasks)
                    (cyanide-menu-render (cyanide-get-one-by-slot 'cyanide-default-menu
                                                                  cyanide-menu-item-collection
                                                                  ":id"
                                                                  'eq)
                                         'cyanide-default-menu
                                         cyanide-mode-map))
                  (cd-proj-root)
                  (setq frame-orig (selected-frame))
                  (setq window-orig (selected-window))
                  (setq cyanide-shell-frame (make-frame))
                  (select-frame cyanide-shell-frame)
                  (shell)
                  (delete-other-windows)
                  (toggle-frame-maximized)
                  (select-frame frame-orig)
                  (select-window window-orig)))))

(provide 'cyanide-shell-view)
