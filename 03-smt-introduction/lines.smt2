(set-option :produce-models true)
(declare-const m Real)
(declare-const q Real)
(define-fun f ((x Real)) Real (+ (* m x) q))

(define-const xa Real 1)
(define-const ya Real (/ 3 2))
(define-const xb Real (/ 1 2))
(define-const yb Real 7)
(declare-const xi Real) ; x-intercept
(declare-const yi Real) ; y-intercept

(assert (= (f xa) ya))
(assert (= (f xb) yb))
(assert (= (f xi) 0))
(assert (= (f 0) yi))

(check-sat)
(get-model)
