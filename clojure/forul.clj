;(println (for [x (range 1 10)] (+ x 1)))
;(println (loop [x (range 1 10)] x))
(
(defn myprint
[x]
(println (format "I made this! %s" x))
)

(for [x (range 1 10)] (myprint x))
)
