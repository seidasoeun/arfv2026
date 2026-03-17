(set-option :produce-models true)

(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-const d Int)
(declare-const e Int)

(define-fun is-digit ((x Real)) Bool (and (>= x 0) (<= x 9)))

(assert (is-digit a))
(assert (is-digit b))
(assert (is-digit c))
(assert (is-digit d))
(assert (is-digit e))

; the 1st and last digit differ
(assert (not (= a e)))
; as do the 2dn and 3rd
(assert (not (= b c)))

; the second digit is twice the 1st
(assert (= b (* 2 a)))
; and the 4th is one less than the last
(assert (= d (- e 1)))

; no digit appears more than twice
(assert (and
  (=> (= a b) (not (or (= a c) (= a d) (= a e))))
  (=> (= a c) (not (or (= a d) (= a e))))
  (=> (= a d) (not (= a e)))
  (=> (= b c) (not (or (= b d) (= b e))))
  (=> (= b d) (not (= b e)))
  (=> (= c d) (not (= c e)))
))

; the password cannot be sorted
; ascending
(assert (not (and
  (<= a b) (<= b c) (<= c d) (<= d e)
)))
; descending
(assert (not (and
  (>= a b) (>= b c) (>= c d) (>= d e)
)))

; the 1st and the last digits are odd, the others are even
(assert (= 1 (mod a 2)))
(assert (= 0 (mod b 2)))
(assert (= 0 (mod c 2)))
(assert (= 0 (mod d 2)))
(assert (= 1 (mod e 2)))

; the digits' sum equals the 4th digit plus twice the 3rd
(assert (= (+ a b c d e) (+ d (* 2 c))))

(check-sat)
(get-model)

; check uniqueness
(assert (not (and 
  (= a 1) (= b 2) (= c 8) (= d 4) (= e 5)
)))
(check-sat)
(get-model)
