#lang racket


(define (retorno deposito)
 (cond
        [(>= 40000 deposito) (* deposito 0.035)]
        [(>= 260000 deposito) (* deposito 0.04)]
        [else (* deposito 0.045)]

    ))
   

(retorno 20000)

(retorno 240000)

(retorno 265000)