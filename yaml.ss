;; -*- Gerbil -*-
;;;; set of tools for lists
(import :std/text/yaml
        :std/sugar)

(export #t)

(def (yaml-safe-load file_name)
  (try (yaml-load file_name)
    (catch _ #f)))