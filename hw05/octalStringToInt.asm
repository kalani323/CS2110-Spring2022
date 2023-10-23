;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Kalani Dissanayake
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2110";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    ;; YOUR CODE HERE
  LD R0, LENGTH ; r0 is length
  AND R1, R1, 0
  AND R2, R2, 0
FIRSTWHILELOOP NOT R3, R0
  ADD R3, R3, 1
  ADD R4, R2, R3
  BRzp FIRSTEND
  AND R3, R3, 0 ; initialize leftshifts
  ADD R3, R3, 3 ; leftshifts = 3
SECONDWHILELOOP ADD R3, R3, 0
  BRnz SECONDEND
  ADD R1, R1, R1 ; increment value by value
  ADD R3, R3, -1 ; decrement leftshift
  BR SECONDWHILELOOP
SECONDEND LD R5, OCTALSTRING
  ADD R5, R5, R2
  LDR R5, R5, 0 ; r5 = octalString[i]
  LD R6, ASCII ; r6 = -48
  ADD R7, R5, R6 ; r7 = octalstring at i - 48
  ADD R1, R1, R7
  ADD R2, R2, 1 ; increment i by 1
  BR FIRSTWHILELOOP
  ; load address of result into the resultaddr
FIRSTEND LD R3, RESULTADDR
  STR R1, R3, 0
  ; end program
  HALT

;; Do not change these values!
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
