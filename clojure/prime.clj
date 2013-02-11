(

(defn is_div
[x]
#(if (= (mod x 2) 0) (println "mumu") (println x))
(if (== (mod (x 0) 2) 0) (println (format "aaa: %s" x)))
)

(for [x (range 1 100)] (is_div x))
)
 
