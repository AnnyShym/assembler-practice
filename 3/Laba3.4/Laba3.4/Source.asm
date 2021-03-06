TITLE Laba3.4

; ��� ������������� ������ � ������� N. ���������� � ����� ������������� ������ B ���� �� ������� 
; ������� ��� �������� ��������� ������� � ������� ��������, � ����� - � ���������:
; A[2], A[4], A[6], ..., A[1], A[3], A[5]

.686
.model flat, stdcall
.stack 4096

ExitProcess   PROTO :DWORD
MessageBoxA   PROTO :DWORD, :DWORD, :DWORD, :DWORD

.const
	MsgBoxCaption    BYTE   '������ B:', 0                      ; ��������� MessageBoxa
	 
.data
	A                BYTE	 2, 1, 1, 9, 5, 3, 2, 3, 7, 0, 8      ; �������� ������������� ������ �� 11 ���������
	B                BYTE    11 DUP (?)                           ; �������������� ������ �� 11 ���������
	MsgBoxText       BYTE    '?  ?  ?  ?  ?  ?  ?  ?  ?  ?  ?'    ; ������ ������ MessageBox� (��� ���������)

.code
 
main PROC
	
	mov edx, 0				      ; �������� ������� ����� ��������
	mov eax, LENGTHOF A           ; ��������� � ������� ����� �������� ���-�� ��������� ������� A
	mov ebx, 2                    ; �������� - 2
	div ebx                       ; eax - ���-�� ������ �������; edx - �������

    mov esi, OFFSET A             ;\  ������������� ��������� �� 2 ������� ������� (������ ������ �����)
	add esi, TYPE A               ;/
	mov edi, OFFSET B             ; ��������� ����� ������� B
	mov ecx, eax                  ; ������������� ������� ����� �� ���-�� ������ �������
	cld                           ; ����������� - ����������

	evennumb:                     ; ���� ����������� ������ �������
		movsb                     ; �������� ������� ��� ������ �������
		add esi, TYPE A           ; ������������� ��������� ����� ���� ������� ������� A (��������� ������ �����)
		loop evennumb		      ; ��������� ����, ���� �������� ecx �� ������ ����� 0
    
	mov esi, OFFSET A             ; ������������� ��������� �� 1 ������� ������� (������ �������� �����)
	mov ecx, eax                  ;\  ������������� ������� ����� �� ���������� ������
	add ecx, edx                  ;/ 
	cld                           ; ����������� - ����������

	oddnumb:                      ; ���� ����������� �������� �������
		movsb                     ; �������� ������� ��� �������� �������
	    add esi, TYPE A           ; ������������� ��������� ����� ���� ������� ������� A (��������� ������ �����)
		loop oddnumb	          ; ��������� ����, ���� �������� ecx �� ������ ����� 0			

	mov edi, OFFSET MsgBoxText    ; ������������� ��������� �� ����� MessageBoxa
	mov esi, OFFSET B             ; ��������� ����� ������� B
	mov ecx, LENGTHOF B           ; ������������� ������� ����� �� ���-�� ��������� ������� B
	cld                           ; ����������� - ����������
	
	mov ah, 30h                   ; ��� �������������� ����� � ������

	print:                        ; ���� �������� ������ ��� ������ �� �����
		add [esi], ah             ; ��������������� ����� � ������
		movsb                     ; �������� ���� ������ � MsgBoxText 
		add edi, (2 * TYPE B)     ; ���������� 2 ������� (�� ������� MsgBoxTexta)
		loop print                ; ���� �� ��������� ���� ������ B
	
	INVOKE MessageBoxA, 0, OFFSET MsgBoxText, OFFSET MsgBoxCaption, 0     ; ������� ��������� � MessageBox
	INVOKE ExitProcess, 0                                                 ; ��������� �������

main ENDP 

END main
