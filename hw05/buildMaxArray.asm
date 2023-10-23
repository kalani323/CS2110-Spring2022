;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Kalani Dissanayake
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-2, 2, 1};
;;	int B[] = {1, 0, 3};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] >= B[length - i - 1]) {
;;			C[i] = 1;
;;		}
;;		else {
;;			C[i] = 0;
;;		}
;;		i++;
;;	}

.orig x3000
	;; YOUR CODE HERE
	AND R0, R0, 0 ; initialize i
	LD R1, LENGTH ; set r1 to length
	NOT R1, R1 ; NOT length
	ADD R1, R1, 1 ; add 1 to get -length
	; if (i-length < 0)
WHILELOOP ADD R2, R0, R1
	BRzp END
	LD R5, A ; set r5 to A
	ADD R3, R0, R5
	NOT R4, R0
	ADD R4, R4, 1
	LD R5, LENGTH ; set r5 to length
	ADD R5, R5, R4
	ADD R5, R5, -1
	LD R4, B ; set r4 to B
	ADD R5, R5, R4
	LDR R3, R3, 0
	LDR R5, R5, 0
	NOT R5, R5
	ADD R5, R5, 1
	LD R7, C ; set r7 to C
	ADD R7, R0, R7
	AND R4, R4, 0
	ADD R6, R3, R5
	BRn ELSE
	ADD R4, R4, 1
	STR R4, R7, 0 ; C[r7] = 1
	BR ENDIF
ELSE STR R4, R7, 0
ENDIF ADD R0, R0, 1 ; C[r7] = 0
	BR WHILELOOP
END NOP
	; end program
	HALT

;; Do not change these addresses!
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200
B 		.fill x3300
C 		.fill x3400
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end
