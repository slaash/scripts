(

(defn is_div
[x]
#(if (= (mod x 2) 0) (println "mumu") (println x))
(println x)
)

(for [x (range 1 100)] (is_div x))
)
 
