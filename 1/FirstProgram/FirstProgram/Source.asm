TITLE FirstProgram
.686 
.model flat, stdcall
.stack 4096 

ExitProcess PROTO :DWORD 
MessageBoxA PROTO :DWORD, :DWORD, :DWORD, :DWORD 

.data 
	alphabet        BYTE "abcdefghijklmnopqrstuvwxyz", 0	; строка из символов алфавита
	MsgBoxCaption   BYTE "First program", 0
	MsgBoxText      BYTE 5 DUP (?), 0  

.code
 
main PROC
 
	mov ebx, "H"	               ; непосредственная адресация 
	mov eax, ebx	               ; регистровая адресация 
	mov ebx, OFFSET MsgBoxText	   ; прямая адресация 
	mov [ebx], eax	               ; базовая индексная адресация памяти 
	mov eax, "e"		           ; непосредственная адресация
	mov [ebx + 1], eax	           ; базовая индексная адресация со смещением 
	mov ebx, OFFSET alphabet	   ; прямая адресация
	mov esi, 14		               ; непосредственная адресация 
	mov eax, [ebx + esi - 3]	   ; адресация по базе с индексированием
	mov ebx, OFFSET MsgBoxText	   ; прямая адресация 
	mov [ebx + 2], eax  	       ; базовая индексная адресация со смещением 
	mov eax, "l"		           ; непосредственная адресация 
	mov [ebx + 3], eax		       ; базовая индексная адресация со смещением 
	mov eax, "o"		           ; непосредственная адресация
	mov [ebx + 4], eax		       ; базовая индексная адресация со смещением 

    INVOKE MessageBoxA, 0, OFFSET MsgBoxText, OFFSET MsgBoxCaption, 0   ; вызываем MessageBox  
	INVOKE ExitProcess, 0                                               ; завершаем процесс

main ENDP 

END main