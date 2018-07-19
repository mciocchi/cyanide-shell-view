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
(require 'cyanide-view-simple)

(cyanide-view-simple
 :id 'cyanide-shell-view
 :teardown-hook '((lambda nil
                    (delete-frame cyanide-shell-frame)))
 :load-hook '((lambda nil
                (progn
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
