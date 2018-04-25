TITLE FirstProgram
.686 
.model flat, stdcall
.stack 4096 

ExitProcess PROTO :DWORD 
MessageBoxA PROTO :DWORD, :DWORD, :DWORD, :DWORD 

.data 
	alphabet        BYTE "abcdefghijklmnopqrstuvwxyz", 0	; ������ �� �������� ��������
	MsgBoxCaption   BYTE "First program", 0
	MsgBoxText      BYTE 5 DUP (?), 0  

.code
 
main PROC
 
	mov ebx, "H"	               ; ���������������� ��������� 
	mov eax, ebx	               ; ����������� ��������� 
	mov ebx, OFFSET MsgBoxText	   ; ������ ��������� 
	mov [ebx], eax	               ; ������� ��������� ��������� ������ 
	mov eax, "e"		           ; ���������������� ���������
	mov [ebx + 1], eax	           ; ������� ��������� ��������� �� ��������� 
	mov ebx, OFFSET alphabet	   ; ������ ���������
	mov esi, 14		               ; ���������������� ��������� 
	mov eax, [ebx + esi - 3]	   ; ��������� �� ���� � ���������������
	mov ebx, OFFSET MsgBoxText	   ; ������ ��������� 
	mov [ebx + 2], eax  	       ; ������� ��������� ��������� �� ��������� 
	mov eax, "l"		           ; ���������������� ��������� 
	mov [ebx + 3], eax		       ; ������� ��������� ��������� �� ��������� 
	mov eax, "o"		           ; ���������������� ���������
	mov [ebx + 4], eax		       ; ������� ��������� ��������� �� ��������� 

    INVOKE MessageBoxA, 0, OFFSET MsgBoxText, OFFSET MsgBoxCaption, 0   ; �������� MessageBox  
	INVOKE ExitProcess, 0                                               ; ��������� �������

main ENDP 

END main