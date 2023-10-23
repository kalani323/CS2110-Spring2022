;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Kalani Dissanayake
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 17;
;;  int mod = 5;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000
    ;; YOUR CODE HERE
    LD R0, X  ;set R0=X
    LD R1, MOD ;set R1=MOD
LOOP AND R2, R0, R0
    NOT R3, R1 ; negate MOD and put it into R4
    ADD R3, R3, #1 ; add 1 to get twos complement
    ADD R2, R2, R3
    BRn ENDLOOP
    ADD R0, R0, R3 ; set R0 = X-MOD
    BR LOOP
ENDLOOP ST R0, ANSWER ; store x in memory at ANSWER
; end program
HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17
    MOD    .fill 5
    ANSWER .blkw 1
.end
