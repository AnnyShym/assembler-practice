TITLE Laba2.7 

; Задан одномерный массив. Вывести на экран сумму положительных и число отрицательных элементов массива. Массив задать в сегменте данных. 

.686 
.model flat, stdcall 
.stack 4096 

ExitProcess PROTO :DWORD 
MessageBoxA PROTO :DWORD, :DWORD, :DWORD, :DWORD 

.const 
MsgBoxCaption   BYTE   'Результат:', 0      ; заголовок MessageBoxa 

.data 
array           BYTE    2, -1, 1, -9, -5, 3, 2, -3, -7, -1            ; исходный массив 
MsgBoxText      BYTE    'Сумма = ?', 0Dh, 0Ah, 'Кол-во = ?', 0        ; шаблон текста MessageBoxa (наш результат)

.code 

main PROC 

	mov ah, 0                          ; обнуляем регистр для хранения суммы положительных элементов 
	mov bh, 0                          ; обнуляем регистр для хранения кол-ва отрицательных элементов 
	mov esi, OFFSET array              ; загружаем адрес массива array 
	mov ecx, LENGTHOF array            ; устанавливаем счетчик цикла на кол-во элементов массива 

	count:                             ; цикл для нахождения суммы и кол-ва 
		mov dh, 0                      ; обнуляем регистр для определения знака элемента  
		add dh, [esi]                  ; добавляем к 0 текущий элемент (определяем знак) 

		js negative                    ; если SF = 1, переходим к метке negative 

		add ah, [esi]				   ; если SF = 0, прибавляем значение текущего элемента массива 
		jmp continue			       ; переходим на метку continue 

		negative:                      ; если число отрицательное 
			inc bh                     ; увеличиваем кол-во 

		continue:                      ; метка для перехода от negative 
			add esi, TYPE array        ; устанавливаем указатель на следующий элемент массива 

		loop count                     ; повторяем цикл, пока значение ecx не станет равно 0 

	add ah, 30h                        ; преобразовываем сумму в символ ASCII 
	add bh, 30h                        ; преобразовываем кол-во в символ ASCII

	mov esi, (OFFSET MsgBoxText + 8)   ; смещение в шаблоне MsgBoxText
	mov [esi], ah                      ; загружаем сумму
	add esi, 12                        ; смещение в шаблоне MsgBoxText
	mov [esi], bh                      ; загружаем кол-во

	INVOKE MessageBoxA, 0, OFFSET MsgBoxText, OFFSET MsgBoxCaption, 0         ; выводим результат в MessageBox 
	INVOKE ExitProcess, 0                                                     ; завершаем процесс 

main ENDP 

END main