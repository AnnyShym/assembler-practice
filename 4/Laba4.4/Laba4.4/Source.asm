TITLE Laba4.4

; Заменить указанный элемент нулем по всей строке (использовать команду scas). Строку описать в сегменте данных.

.686
.model flat, stdcall
.stack 4096

ExitProcess   PROTO :DWORD
MessageBoxA   PROTO :DWORD, :DWORD, :DWORD, :DWORD

.const
	MsgBoxCaption    BYTE   ' Result:', 0                    ; заголовок MessageBoxa
	 
.data
	string           BYTE	'Oh hai, Mark!', 0               ; исходная строка
	char             BYTE   'a'                              ; элемент для замены

.code
 
main PROC
	
	mov al, char                      ; загружаем элемент
	mov ah, '0'                       ; загружаем замену
	mov edi, OFFSET string            ; загружаем адрес строки
	mov ecx, LENGTHOF string          ; помещаем в счетчик 'repne scasb' кол-во элементов строки
	cld                               ; направление сравнения - восходящее

	scan:                             ; цикл поиска элемента в строке
		repne scasb                   ; сканируем строку, пока не найден нужный элемент или пока не обнулился счетчик

		jnz exit                      ; если элемент в строке не найден (ZF = 0 и ecx = 0), выходим из цикла
		
		mov [edi - 1], ah             ; если элемент найден, заменяем его нулем
		
		jmp scan                      ; продолжаем сканирование до тех пор, пока не выполнятся условия exita

	exit:
		INVOKE MessageBoxA, 0, OFFSET string, OFFSET MsgBoxCaption, 0	  ; выводим результат в MessageBox
	    INVOKE ExitProcess, 0                                             ; завершаем процесс

main ENDP 

END main
