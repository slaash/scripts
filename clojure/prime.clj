(

(defn is_div
[x]
(if (= 0 (mod x (range 2 (Math/sqrt x)))) true false)
)

(for [x (range 1 100)] (is_div x))
)
 
