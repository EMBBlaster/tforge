{
  pi / 4 = 4 * arctan(1 / 5) - arctan(1 / 239)
  arctan(x) = x - x^3 / 3 + x^5 / 5 - x^7 / 7 + ..
}
program PiBench;

{$mode delphi}

uses
  SysUtils, tfNumerics;

const
  MillisPerDay = 24 * 60 * 60 * 1000;

var
  StartTime: TDateTime;
  ElapsedMillis: Integer;
  ValidDigits: BigCardinal;
  S: string;

procedure BenchMark;
var
  Factor, Num, Den: BigCardinal;
  Term: BigCardinal;
  PiDigits: BigCardinal;
  N, M: Cardinal;
  MaxError: Cardinal;

begin
  PiDigits:= 0;
  Factor:= BigCardinal.Pow(10, 10000);    // = 10^10000;
  Num:= 16 * Factor;
  Den:= 5;
  N:= 1;
  repeat
    Term:= Num div (Den * (2 * N - 1));
    if Term = 0 then Break;
    if Odd(N)
      then PiDigits:= PiDigits + Term
      else PiDigits:= PiDigits - Term;
    Den:= Den * 25;
    Inc(N);
  until N = 0;
  M:= N;
  Num:= 4 * Factor;
  Den:= 239;
  N:= 1;
  repeat
    Term:= Num div (Den * (2 * N - 1));
    if Term = 0 then Break;
    if Odd(N)
      then PiDigits:= PiDigits - Term
      else PiDigits:= PiDigits + Term;
    Den:= Den * 239 * 239;
    Inc(N);
  until N = 0;
  MaxError:= (M + N) div 2 + 2;
  Term:= 1;
  repeat
    Term:= Term * 10;
  until Term > MaxError;
  repeat
    ValidDigits:= BigCardinal.DivRem(PiDigits, Term, Num);
    if Num > MaxError then Break;
    Term:= Term * 10;
  until False;
end;

begin
//  ReportMemoryLeaksOnShutdown:= True;
  try
    Writeln('Benchmark test started ...');
    StartTime:= Now;
    BenchMark;
    ElapsedMillis:= Round((Now - StartTime) * MillisPerDay);
    S:= ValidDigits.ToString;
    Writeln('Pi = ', S[1] + '.' + Copy(S, 2, Length(S) - 1));
    ValidDigits.Free;
    Writeln;
    Writeln('Time elapsed: ', ElapsedMillis, ' ms.');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.

