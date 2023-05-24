
DATA SEGMENT
NOTIC DB "Please input the word !",0AH,0DH ;0AH,0DH 为换行符
DATA ENDS
CODE SEGMENT; 代码段
ASSUME CS:CODE,DS:DATA ; 定义段寄存器的默认值
START: MOV AX,DATA ; 将数据段的段地址加载到 AX 寄存器中
MOV DS,AX ; 将 AX 寄存器中的值赋给 DS 寄存器，设置 DS 寄存器的值为数据段的段地址
MOV CX,19H ; 将 CX 寄存器的值设置为 19H，即字符串的长度
LEA BX,[NOTIC] ; 将 NOTIC 变量的地址加载到 BX 寄存器中
AA0: MOV DL,[BX] ; 将 BX 寄存器指向的内存单元中的值加载到 DL 寄存器中，即输出提示信息
MOV AH,2 ; 将 AH 寄存器的值设置为 2，表示调用 DOS 的 21H 中断，输出字符
INT 21H ; 调用 DOS 的 21H 中断，输出字符
INC BX ; 将 BX 寄存器的值加 1，指向下一个字符
LOOP AA0 ; 循环执行 AA0 标签处的指令，直到 CX 寄存器的值为 0
AA1: MOV AH,1 ; 将 AH 寄存器的值设置为 1，表示调用 DOS 的 21H 中断，读取字符
INT 21H ; 调用 DOS 的 21H 中断，读取字符
CMP AL,1BH ; 将 AL 寄存器的值与 1BH 进行比较，判断是否为 ESC 键
JZ AA3 ; 如果是 ESC 键，跳转到 AA3 标签处执行
CMP AL,61H ; 将 AL 寄存器的值与 61H 进行比较，判断是否为小写字母
JS AA2 ; 如果是小写字母，跳转到 AA2 标签处执行
CMP AL,7AH ; 将 AL 寄存器的值与 7AH 进行比较，判断是否为小写字母
JNS AA2 ; 如果不是小写字母，跳转到 AA2 标签处执行
SUB AL,20H ; 将 AL 寄存器的值减去 20H，即将小写字母转换为大写字母
AA2: MOV DL,AL ; 将 AL 寄存器的值赋给 DL 寄存器，即输出字符
MOV AH,2 ; 将 AH 寄存器的值设置为 2，表示调用 DOS 的 21H 中断，输出字符
INT 21H ; 调用 DOS 的 21H 中断，输出字符
LOOP AA1 ; 循环执行 AA1 标签处的指令，直到 CX 寄存器的值为 0
AA3: MOV AH,4CH ; 将 AH 寄存器的值设置为 4CH，表示调用 DOS 的 21H 中断，程序结束
INT 21H; 调用 DOS 的 21H 中断，程序结束
CODE ENDS
END START