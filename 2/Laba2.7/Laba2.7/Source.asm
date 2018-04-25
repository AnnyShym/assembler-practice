TITLE Laba2.7 

; ����� ���������� ������. ������� �� ����� ����� ������������� � ����� ������������� ��������� �������. ������ ������ � �������� ������. 

.686 
.model flat, stdcall 
.stack 4096 

ExitProcess PROTO :DWORD 
MessageBoxA PROTO :DWORD, :DWORD, :DWORD, :DWORD 

.const 
MsgBoxCaption   BYTE   '���������:', 0      ; ��������� MessageBoxa 

.data 
array           BYTE    2, -1, 1, -9, -5, 3, 2, -3, -7, -1            ; �������� ������ 
MsgBoxText      BYTE    '����� = ?', 0Dh, 0Ah, '���-�� = ?', 0        ; ������ ������ MessageBoxa (��� ���������)

.code 

main PROC 

	mov ah, 0                          ; �������� ������� ��� �������� ����� ������������� ��������� 
	mov bh, 0                          ; �������� ������� ��� �������� ���-�� ������������� ��������� 
	mov esi, OFFSET array              ; ��������� ����� ������� array 
	mov ecx, LENGTHOF array            ; ������������� ������� ����� �� ���-�� ��������� ������� 

	count:                             ; ���� ��� ���������� ����� � ���-�� 
		mov dh, 0                      ; �������� ������� ��� ����������� ����� ��������  
		add dh, [esi]                  ; ��������� � 0 ������� ������� (���������� ����) 

		js negative                    ; ���� SF = 1, ��������� � ����� negative 

		add ah, [esi]				   ; ���� SF = 0, ���������� �������� �������� �������� ������� 
		jmp continue			       ; ��������� �� ����� continue 

		negative:                      ; ���� ����� ������������� 
			inc bh                     ; ����������� ���-�� 

		continue:                      ; ����� ��� �������� �� negative 
			add esi, TYPE array        ; ������������� ��������� �� ��������� ������� ������� 

		loop count                     ; ��������� ����, ���� �������� ecx �� ������ ����� 0 

	add ah, 30h                        ; ��������������� ����� � ������ ASCII 
	add bh, 30h                        ; ��������������� ���-�� � ������ ASCII

	mov esi, (OFFSET MsgBoxText + 8)   ; �������� � ������� MsgBoxText
	mov [esi], ah                      ; ��������� �����
	add esi, 12                        ; �������� � ������� MsgBoxText
	mov [esi], bh                      ; ��������� ���-��

	INVOKE MessageBoxA, 0, OFFSET MsgBoxText, OFFSET MsgBoxCaption, 0         ; ������� ��������� � MessageBox 
	INVOKE ExitProcess, 0                                                     ; ��������� ������� 

main ENDP 

END main