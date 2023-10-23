;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Kalani Dissanayake
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;;
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000
	;; YOUR CODE HERE
	LD R2, STRING ; r2 = string
	AND R0, R0, 0 ; initialize isPalindrome
	ADD R0, R0, 1 ; set isPalindrome = 1
	AND R1, R1, 0 ; intialize r1 as length = 0
FIRSTWHILE ADD R3, R1, R2
	LDR R4, R3, 0
	BRz FIRSTEND
	ADD R1, R1, 1
	BR FIRSTWHILE
FIRSTEND NOP
	AND R3, R3, 0 ; intialize r3 as left
	ADD R4, R1, -1 ; intialize right = length -1
SECONDWHILE NOT R5, R4
	ADD R5, R5, 1
	ADD R5, R3, R5 ; r5 = left - right
	BRzp SECONDEND
	ADD R5, R2, R3 ; r5 = addr of string[left]
	LDR R5, R5, 0 ; r5 = string[left]
	ADD R6, R2, R4 ; r6 = addr of string[right]
	LDR R6, R6, 0 ; r6 = string[right]
	NOT R6, R6
	ADD R6, R6, 1
	ADD R7, R5, R6 ; does string[left] = string[right]
	BRz FIRSTIF
	; set palindrome to false (0)
	AND R0, R0, 0
	BR SECONDEND
FIRSTIF ADD R3, R3, 1 ; increment left
	ADD R4, R4, -1 ; decrement right
	BR SECONDWHILE
	; load address into answer
SECONDEND LD R3, ANSWERADDR
	; store the conetents of R0 (1 or 0) in the address stored in 43
	STR R0, R3, 0
	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004
	.stringz "aibohphobia" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end
