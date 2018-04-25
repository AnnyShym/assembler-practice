program AssemblerInserts;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

type
  Select    = 1..2;
  ConstArr  = array [1..10] of Integer;
  Arr       = array [1..100] of Integer;

const
 Reserve: ConstArr  = (265, -123, 136, -99, -509, 348, 236, -376, -74, 0);

var
  option              : Select;
  A                   : Arr;
  i, n, sum, amount   : Integer;

begin

  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  // ���� �������� ������
  writeln('1 - ������ ������', #10, '2 - ������', #10);
  repeat
    write('��� �����: ');
    readln(option);
    writeln;
  until (option = 1) or (option = 2);
  writeln('---------------------------------------------------');
  writeln;
  if (option = 1) then
  begin
    repeat
      write('���������� ���������: ');
      readln(n);
      if (n > 100) or (n < 1) then
        writeln('����� ������ ���� �� ��������� [1..100].');
      writeln;
    until (n > 0) and (n <= 100);
    writeln('������� ������:');
    for i := 1 to n do
    begin
      write(i: 2, ' ������� = ');
      readln(A[i]);
    end;
  end
  else
  begin
    n := 10;
    for i := 1 to n do
      A[i] := Reserve[i];
    write('�������� ������: ');
    for i := 1 to n do
      write(A[i], '  ');
  end;

  // ���������� (������������ �������)
  asm

    mov eax, 0
    mov ebx, 0
    mov esi, OFFSET A
    mov ecx, n

    // ���� ���������� �����������
    @count:

      mov edx, 0
      add edx, [esi]

      js @negative

      // ���� ����� ������������� - ���������� �����
      add eax, [esi]
      jmp @continue

      // ���� ������������� - ���������� ���-��
      @negative:
        inc ebx

      @continue:
        add esi, 4

      loop @count

    mov sum, eax
    mov amount, ebx

  end;

  // ����� �����������
  writeln;
  writeln('����� ������������� ��������� �������: ', sum);
  writeln('���������� ������������� ��������� �������: ', amount);

  readln;

end.
