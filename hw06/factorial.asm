;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Factorial
;;=============================================================
;;  Name: Kalani Dissanayake
;;============================================================

;;  In this file, you must implement the 'MULTIPLY' and 'FACTORIAL' subroutines.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'MULTIPLY' or 'FACTORIAL' labels
;;      * Add the [a, b] or [n] params separated by a comma (,)
;;        (e.g. 3, 5 for 'MULTIPLY' or 6 for 'FACTORIAL')
;;      * Proceed to run, step, add breakpoints, etc.
;;      * Remember R6 should point at the return value after a subroutine
;;        returns. So if you run the program and then go to
;;        'View' -> 'Goto Address' -> 'R6 Value', you should find your result
;;        from the subroutine there (e.g. 3 * 5 = 15 or 6! = 720)

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  MULTIPLY Pseudocode (see PDF for explanation and examples)
;;
;;  MULTIPLY(int a, int b) {
;;      int ret = 0;
;;      while (b > 0) {
;;          ret += a;
;;          b--;
;;      }
;;      return ret;
;;  }

MULTIPLY ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the MULTIPLY subroutine here!
    ADD R6, R6, #-4 ;; allocate space
    STR R7, R6, #2 ;; save the return address
    STR R5, R6, #1 ;; save old frame pointer
    ADD R5, R6, #0 ;; copy SP to FP
    ADD R6, R6, #-5 ;; room for 5 registers
    ;; register 1 - 5
    STR R0, R5, #-1
    STR R1, R5, #-2
    STR R2, R5, #-3
    STR R3, R5, #-4
    STR R4, R5, #-5
    AND R0, R0, #0 ;; R0 = 0
    STR R0, R5, #0 ;; answer = R0
    LDR R2, R5, #4 ;; R2 = A
MULTIPLYLOOP
    BRnz ENDMULTIPLYLOOP
    LDR R0, R5, #0 ;; R0 = answer
    LDR R1, R5, #5 ;; R1 = B
    ADD R0, R0, R1 ;; R0 = answer + B
    STR R0, R5, #0 ;; answer = R0
    ADD R2, R2, #-1 ; a--
    BR MULTIPLYLOOP
ENDMULTIPLYLOOP
    LDR R0, R5, #0 ;; ret value = answer
    STR R0, R5, #3 ;;
    ;; restore R4 - R0
    LDR R4, R5, #-5
    LDR R3, R5, #-4
    LDR R2, R5, #-3
    LDR R1, R5, #-2
    LDR R0, R5, #-1
    ADD R6, R5, #0 ;; restore SP
    LDR R5, R6, #1 ;; restore FP
    LDR R7, R6, #2 ;; restore return address
    ADD R6, R6, #3 ;; pop RA, FP, local variable 1
RET

;;  FACTORIAL Pseudocode (see PDF for explanation and examples)
;;
;;  FACTORIAL(int n) {
;;      int ret = 1;
;;      for (int x = 2; x <= n; x++) {
;;          ret = MULTIPLY(ret, x);
;;      }
;;      return ret;
;;  }

FACTORIAL ;; Do not change this label! Treat this as like the name of the function in a function header
;; Code your implementation for the FACTORIAL subroutine here!
  ADD R6, R6, #-4 ;; allocate space
  STR R7, R6, #2 ;; save the return address
  STR R5, R6, #1 ;; save old frame pointer
  ADD R5, R6, #0 ;; copy SP to FP
  ADD R6, R6, #-5 ;; room for 5 registers
  STR R0, R5, #-1 ;; register 1 - 5
  STR R1, R5, #-2
  STR R2, R5, #-3
  STR R3, R5, #-4
  STR R4, R5, #-5
  AND R1, R1, #0
  ADD R1, R1, #1 ;; R1 = ret = 1
  AND R0, R0, #0
  ADD R0, R0, #2 ;; R0 = 2
FACTORIALLOOP
  LDR R2, R5, #4 ;; R2 = n
  NOT R2, R2
  ADD R2, R2, #1
  ADD R2, R0, R2 ;; R2 = x - n
  BRp FACTORIALELSE ;;
  ADD R6, R6, #-1
  STR R0, R6, #0 ;; push A
  ADD R6, R6, #-1
  STR R1, R6, #0 ;; push B
  JSR MULTIPLY ;; calling MULTIPLY
  LDR R1, R6, #0 ;; saving it in R1
  ADD R6, R6, #1
  ADD R6, R6, #2
  ADD R0, R0, #1 ;; x ++
  BR FACTORIALLOOP
FACTORIALELSE
  STR R1, R5, #3
  LDR R4, R5, #-5 ;; restore R4 - R0
  LDR R3, R5, #-4
  LDR R2, R5, #-3
  LDR R1, R5, #-2
  LDR R0, R5, #-1
  ADD R6, R5, #0 ;; restore SP
  LDR R5, R6, #1 ;; restore FP
  LDR R7, R6, #2 ;; restore return address
  ADD R6, R6, #3 ;; pop RA, FP, local variable 1
RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end
