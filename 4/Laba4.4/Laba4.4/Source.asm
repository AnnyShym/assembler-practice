TITLE Laba4.4

; �������� ��������� ������� ����� �� ���� ������ (������������ ������� scas). ������ ������� � �������� ������.

.686
.model flat, stdcall
.stack 4096

ExitProcess   PROTO :DWORD
MessageBoxA   PROTO :DWORD, :DWORD, :DWORD, :DWORD

.const
	MsgBoxCaption    BYTE   ' Result:', 0                    ; ��������� MessageBoxa
	 
.data
	string           BYTE	'Oh hai, Mark!', 0               ; �������� ������
	char             BYTE   'a'                              ; ������� ��� ������

.code
 
main PROC
	
	mov al, char                      ; ��������� �������
	mov ah, '0'                       ; ��������� ������
	mov edi, OFFSET string            ; ��������� ����� ������
	mov ecx, LENGTHOF string          ; �������� � ������� 'repne scasb' ���-�� ��������� ������
	cld                               ; ����������� ��������� - ����������

	scan:                             ; ���� ������ �������� � ������
		repne scasb                   ; ��������� ������, ���� �� ������ ������ ������� ��� ���� �� ��������� �������

		jnz exit                      ; ���� ������� � ������ �� ������ (ZF = 0 � ecx = 0), ������� �� �����
		
		mov [edi - 1], ah             ; ���� ������� ������, �������� ��� �����
		
		jmp scan                      ; ���������� ������������ �� ��� ���, ���� �� ���������� ������� exita

	exit:
		INVOKE MessageBoxA, 0, OFFSET string, OFFSET MsgBoxCaption, 0	  ; ������� ��������� � MessageBox
	    INVOKE ExitProcess, 0                                             ; ��������� �������

main ENDP 

END main
