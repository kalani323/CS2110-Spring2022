;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Kalani Dissanayake
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,)
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  INSERTION_SORT **RESURSIVE** Pseudocode (see PDF for explanation and examples)
;;
;;  INSERTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;        return;
;;      }
;;
;;      INSERTION_SORT(arr, length - 1);
;;
;;      int last_element = arr[length - 1];
;;      int n = length - 2;
;;
;;      while (n >= 0 && arr[n] > last_element) {
;;          arr[n + 1] = arr[n];
;;          n--;
;;      }
;;
;;      arr[n + 1] = last_element;
;;  }

INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the INSERTION_SORT subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
;; BUILD STACK ?
    ADD R6, R6, -4
    STR R7, R6, 2
    STR R5, R6, 1
    ADD R5, R6, 0
    ADD R6, R6, -5
    STR R4, R6, 4
    STR R3, R6, 3
    STR R2, R6, 2
    STR R1, R6, 1
    STR R0, R6, 0
    AND R0, R0, 0
    STR R0, R5, 0
    ADD R0, R0, 1
    LENGTH
      AND R2, R2, 0
      ADD R2, R2, -1
      LDR R1, R5, 5
      ADD R2, R2, R1
      BRn TEARDOWN
      BRz TEARDOWN
    LOOP
      LDR R2, R5, 5
      NOT R2, R2
      ADD R2, R2, 1
      ADD R2, R0, R2
      BRz DONTLOOP
      BRp DONTLOOP
      LDR R1, R5, 4
      ADD R2, R0, R1
      LDR R2, R2, 0
      LDR R3, R5, 0
      ADD R3, R1, R3
      LDR R3, R3, 0
      NOT R3, R3
      ADD R3, R3, 1
      ADD R3, R3, R2
      BRn DONTSWAP
      BRz DONTSWAP
      STR R0, R5, 0
    DONTSWAP
      ADD R0, R0, 1
      BR LOOP
    DONTLOOP
      LDR R0, R5, 0
      LDR R1, R5, 4
      LDR R2, R5, 5
      ADD R0, R1, R0
      ADD R2, R2, -1
      LDR R3, R0, 0
      ADD R2, R1, R2
      LDR R4, R2, 0
      STR R3, R2, 0
      STR R4, R0, 0
      LDR R1, R5, 4
      LDR R2, R5, 5
      ADD R6, R6, -2
      ADD R2, R2, -1
      STR R1, R6, 0
      STR R2, R6, 1
      JSR INSERTION_SORT
      ADD R6, R6, #3
    TEARDOWN
      LDR R4, R6, 4
      LDR R3, R6, 3
      LDR R2, R6, 2
      LDR R1, R6, 1
      LDR R0, R6, 0
      ADD R6, R5, 0
      LDR R5, R6, 1
      LDR R7, R6, 2
      ADD R6, R6, 3
RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end
