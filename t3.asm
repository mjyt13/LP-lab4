.ORIG x3000

; Выводим первый запрос
LEA R0, FIRSTPROMPT
PUTS

; Выводим второй запрос
LEA R0, SPACE
PUTS

; Выводим пример ввода
LEA R0, SAMPLE
PUTS

; Инициализация регистров и счетчиков
LD R3, POINTER
LD R6, IOCOUNTER

; Цикл ввода
INPUT
    IN
    AND R2, R2, #0     ; Очищаем регистр R2
    AND R5, R5, #0     ; Очищаем регистр R5
    LD R5, PLACEHUNDRED
    LD R2, HEXN48
    ADD R0, R0, R2
    ADD R2, R0, #0
    AND R0, R0, #0

FIRST_NUM
    ADD R0, R0, R2
    ADD R5, R5, #-1
    BRp FIRST_NUM
    ADD R1, R0, #0
    AND R0, R0, #0

    IN
    AND R2, R2, #0
    AND R5, R5, #0
    LD R5, PLACETEN
    LD R2, HEXN48
    ADD R0, R0, R2
    ADD R2, R0, #0
    AND R0, R0, #0

SECOND_NUM
    ADD R0, R0, R2
    ADD R5, R5, #-1
    BRp SECOND_NUM
    ADD R4, R0, #0
    AND R0, R0, #0

    IN
    AND R2, R2, #0
    LD R2, HEXN48
    ADD R0, R0, R2
    AND R2, R2, #0

    ADD R2, R1, R4
    ADD R2, R0, R2
    STR R2, R3, #0
    ADD R3, R3, #1
    ADD R6, R6, #-1
    BRp INPUT

    JSR BUBBLESORT
    JSR PRODUCTLOOP
    HALT

; Подпрограмма сортировки пузырьком
BUBBLESORT
    AND R3, R3, #0
    LD R3, POINTER
    AND R4, R4, #0
    LD R4, IOCOUNTER
    AND R5, R5, #0
    LD R5, IOCOUNTER

FINALOUT_LOOP
    ADD R4, R4, #-1
    BRz SORTED
    ADD R5, R4, #0
    LD R3, POINTER

FINALIN_LOOP
    LDR R0, R3, #0
    LDR R1, R3, #1
    AND R2, R2, #0
    NOT R2, R1
    ADD R2, R2, #1
    ADD R2, R0, R2
    BRn AUTOSWAP

    STR R1, R3, #0
    STR R0, R3, #1

AUTOSWAP
    ADD R3, R3, #1
    ADD R5, R5, #-1
    BRp FINALIN_LOOP
    BRzp FINALOUT_LOOP

SORTED
    RET

; Подпрограмма для вывода результата
PRODUCTLOOP
    LEA R0, PROMPTEXECUTE
    PUTS
    LD R3, POINTER
    LD R6, IOCOUNTER

RESULTLOOP
    AND R1, R1, #0
    AND R2, R2, #0
    AND R4, R4, #0
    AND R5, R5, #0
    AND R0, R0, #0
    LD R0, SPACE
    OUT
    AND R0, R0, #0
    LDR R0, R3, #0

    LD R2, PLACEHUNDRED
    NOT R2, R2
    ADD R2, R2, #1

MINUS01
    ADD R1, R1, #1
    ADD R0, R0, R2
    BRzp MINUS01

REMAINDER01
    AND R2, R2, #0
    LD R2, PLACEHUNDRED
    ADD R0, R0, R2
    ADD R1, R1, #-1
    STI R1, FIRSTNUM

    AND R2, R2, #0
    LD R2, PLACETEN
    NOT R2, R2
    ADD R2, R2, #1

MINUS02
    ADD R4, R4, #1
    ADD R0, R0, R2
    BRzp MINUS02

REMAINDER2
    AND R2, R2, #0
    LD R2, PLACETEN
    ADD R5, R0, R2
    STI R5, THIRDNUM
    ADD R4, R4, #-1
    STI R4, SECONDNUM

    AND R0, R0, #0
    LDI R0, FIRSTNUM
    AND R2, R2, #0
    LD R2, HEX48
    ADD R0, R0, R2
    OUT
    AND R0, R0, #0
    LDI R0, SECONDNUM
    AND R2, R2, #0
    LD R2, HEX48
    ADD R0, R0, R2
    OUT

    AND R0, R0, #0
    LDI R0, THIRDNUM
    AND R2, R2, #0
    LD R2, HEX48
    ADD R0, R0, R2
    OUT

    ADD R3, R3, #1
    ADD R6, R6, #-1
    BRp RESULTLOOP
    HALT

; Строковые константы и инициализация данных
FIRSTPROMPT .STRINGZ "Input 10 numbers ranging from 000 - 100 with 3 digits."
SAMPLE .STRINGZ "Ex: Input 15 as 015 or 5 as 005"
PROMPTEXECUTE .STRINGZ "Numbers in Ascending Order: "
SPACE .STRINGZ "\n"
HEXN48 .FILL xFFD0
HEX48 .FILL x0030
PLACEHUNDRED .FILL x0064
PLACETEN .FILL x000A
POINTER .FILL x4000
IOCOUNTER .FILL #10
FIRSTNUM .FILL x400A
SECONDNUM .FILL x400B
THIRDNUM .FILL x400C
.END
