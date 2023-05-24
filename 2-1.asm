; 定义数据段
DATA SEGMENT
DD1 DB 35H,78H,85H ; DD1 是一个字节的数据，其值为 35H,78H,85H
DD2 DB ? ; 定义一个字节的数据，但未初始化
DATA ENDS ; 数据段结束

; 定义代码段
CODE SEGMENT
MAIN PROC FAR ; 定义一个远调用的过程，名为 MAIN
ASSUME CS:CODE,DS:DATA ; 告诉编译器 CS 寄存器指向代码段，DS 寄存器指向数据段

START: ; 定义一个名为 START 的标签
PUSH DS ; 将 DS 寄存器的值压入堆栈
SUB AX,AX ; 将 AX 寄存器的值清零
PUSH AX ; 将 AX 寄存器的值压入堆栈
MOV AX,DATA ; 将数据段的地址加载到 AX 寄存器中
MOV DS,AX ; 将 AX 寄存器的值（即数据段的地址）加载到 DS 寄存器中
MOV AL,DD1 ; 将 DD1 的第一个字节的值加载到 AL 寄存器中
CMP AL,DD1+1 ; 将 AL 寄存器的值与 DD1 的第二个字节的值进行比较
JA AAA1 ; 如果 AL 寄存器的值大于 DD1 的第二个字节的值，则跳转到 AAA1 标签处
MOV AL,DD1+1 ; 将 DD1 的第二个字节的值加载到 AL 寄存器中
AAA1: ; 定义一个名为 AAA1 的标签
CMP AL,DD1+2 ; 将 AL 寄存器的值与 DD1 的第三个字节的值进行比较
AAA2: ; 定义一个名为 AAA2 的标签
MOV DD2,AL ; 将 AL 寄存器的值存储到 DD2 变量中
RET ; 返回到调用该过程的指令处
MAIN ENDP ; 过程 MAIN 结束
CODE ENDS ; 代码段结束
END START ; 程序结束

