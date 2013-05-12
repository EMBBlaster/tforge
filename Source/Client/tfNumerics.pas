{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2012         * }
{ * ------------------------------------------------------- * }
{ *   # client unit                                         * }
{ *   # exports: BigCardinal, BigInteger                    * }
{ *********************************************************** }

unit tfNumerics;

{$I TFL.inc}

{$IFDEF TFL_LIMB32}
  {$DEFINE LIMB32}
{$ENDIF}

interface

uses SysUtils, tfTypes,
    {$IFDEF TFL_DLL} tfImport {$ELSE} tfNumbers {$ENDIF};

type
  BigCardinal = record
  private
    FNumber: IBigNumber;
  public
    function ToString: string;
    function ToHexString(Digits: Cardinal; TwoCompl: Boolean): string;
    function ToBytes: TBytes;
    function TryParse(const S: string): Boolean;
    procedure Free;

    class function Compare(const A, B: BigCardinal): Integer; static;
    function CompareTo(const B: BigCardinal): Integer; overload;

    class function Pow(const Base: BigCardinal; Value: Cardinal): BigCardinal; static;
    class function DivRem(const Dividend, Divisor: BigCardinal;
                          var Remainder: BigCardinal): BigCardinal; overload; static;

    class operator Explicit(const Value: BigCardinal): Cardinal;
    class operator Explicit(const Value: BigCardinal): Integer;
    class operator Implicit(const Value: Cardinal): BigCardinal;
    class operator Explicit(const Value: Integer): BigCardinal;
    class operator Explicit(const Value: TBytes): BigCardinal;
    class operator Explicit(const Value: string): BigCardinal;

    class operator Equal(const A, B: BigCardinal): Boolean; inline;
    class operator NotEqual(const A, B: BigCardinal): Boolean; inline;
    class operator GreaterThan(const A, B: BigCardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A, B: BigCardinal): Boolean; inline;
    class operator LessThan(const A, B: BigCardinal): Boolean; inline;
    class operator LessThanOrEqual(const A, B: BigCardinal): Boolean; inline;

    class operator Add(const A, B: BigCardinal): BigCardinal;
    class operator Subtract(const A, B: BigCardinal): BigCardinal;
    class operator Multiply(const A, B: BigCardinal): BigCardinal;
    class operator IntDivide(const A, B: BigCardinal): BigCardinal;
    class operator Modulus(const A, B: BigCardinal): BigCardinal;

    class operator LeftShift(const A: BigCardinal; Shift: Cardinal): BigCardinal;
    class operator RightShift(const A: BigCardinal; Shift: Cardinal): BigCardinal;

    class operator BitwiseAnd(const A, B: BigCardinal): BigCardinal;
    class operator BitwiseOr(const A, B: BigCardinal): BigCardinal;

{$IFDEF LIMB32}
    function CompareToCard(const B: Cardinal): Integer;
    function CompareToInt(const B: Integer): Integer;
    function CompareTo(const B: Cardinal): Integer; overload; inline;
    function CompareTo(const B: Integer): Integer; overload; inline;
    class operator Equal(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator Equal(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator Equal(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator Equal(const A: Integer; const B: BigCardinal): Boolean; inline;
    class operator NotEqual(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator NotEqual(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator NotEqual(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator NotEqual(const A: Integer; const B: BigCardinal): Boolean; inline;
    class operator GreaterThan(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator GreaterThan(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator GreaterThan(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator GreaterThan(const A: Integer; const B: BigCardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator GreaterThanOrEqual(const A: Integer; const B: BigCardinal): Boolean; inline;
    class operator LessThan(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator LessThan(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator LessThan(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator LessThan(const A: Integer; const B: BigCardinal): Boolean; inline;
    class operator LessThanOrEqual(const A: BigCardinal; const B: Cardinal): Boolean; inline;
    class operator LessThanOrEqual(const A: Cardinal; const B: BigCardinal): Boolean; inline;
    class operator LessThanOrEqual(const A: BigCardinal; const B: Integer): Boolean; inline;
    class operator LessThanOrEqual(const A: Integer; const B: BigCardinal): Boolean; inline;

    class function DivRem(const Dividend: BigCardinal; Divisor: Cardinal;
                          var Remainder: Cardinal): BigCardinal; overload; static;

    class operator Add(const A: BigCardinal; const B: Cardinal): BigCardinal;
    class operator Add(const A: Cardinal; const B: BigCardinal): BigCardinal;
    class operator Subtract(const A: BigCardinal; const B: Cardinal): BigCardinal;
    class operator Subtract(const A: Cardinal; const B: BigCardinal): Cardinal;
    class operator Multiply(const A: BigCardinal; const B: Cardinal): BigCardinal;
    class operator Multiply(const A: Cardinal; const B: BigCardinal): BigCardinal;
    class operator IntDivide(const A: BigCardinal; const B: Cardinal): BigCardinal;
    class operator IntDivide(const A: Cardinal; const B: BigCardinal): Cardinal;
    class operator Modulus(const A: BigCardinal; const B: Cardinal): Cardinal;
    class operator Modulus(const A: Cardinal; const B: BigCardinal): Cardinal;
{$ENDIF}
  end;

  BigInteger = record
  private
    FNumber: IBigNumber;
    function GetSign: Integer;
  public
    function ToString: string;
    function ToHexString(Digits: Cardinal; TwoCompl: Boolean): string;
    function ToBytes: TBytes;
    function TryParse(const S: string): Boolean;
    procedure Free;

    property Sign: Integer read GetSign;

    class function Compare(const A, B: BigInteger): Integer; overload; static;
    class function Compare(const A: BigInteger; const B: BigCardinal): Integer; overload; static;
    class function Compare(const A: BigCardinal; const B: BigInteger): Integer; overload; static;
    function CompareTo(const B: BigInteger): Integer; overload; inline;
    function CompareTo(const B: BigCardinal): Integer; overload; inline;

    class function Abs(const A: BigInteger): BigInteger; static;
    class function Pow(const Base: BigInteger; Value: Cardinal): BigInteger; static;
    class function DivRem(const Dividend, Divisor: BigCardinal;
                          var Remainder: BigCardinal): BigCardinal; static;

    class operator Implicit(const Value: BigCardinal): BigInteger; inline;
    class operator Explicit(const Value: BigInteger): BigCardinal; inline;

    class operator Explicit(const Value: BigInteger): Cardinal;
    class operator Explicit(const Value: BigInteger): Integer;
    class operator Implicit(const Value: Cardinal): BigInteger;
    class operator Implicit(const Value: Integer): BigInteger;
    class operator Explicit(const Value: TBytes): BigInteger;
    class operator Explicit(const Value: string): BigInteger;

    class operator Equal(const A, B: BigInteger): Boolean; inline;
    class operator Equal(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator Equal(const A: BigCardinal; const B: BigInteger): Boolean; inline;
    class operator NotEqual(const A, B: BigInteger): Boolean; inline;
    class operator NotEqual(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator NotEqual(const A: BigCardinal; const B: BigInteger): Boolean; inline;
    class operator GreaterThan(const A, B: BigInteger): Boolean; inline;
    class operator GreaterThan(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator GreaterThan(const A: BigCardinal; const B: BigInteger): Boolean; inline;
    class operator GreaterThanOrEqual(const A, B: BigInteger): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigCardinal; const B: BigInteger): Boolean; inline;
    class operator LessThan(const A, B: BigInteger): Boolean; inline;
    class operator LessThan(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator LessThan(const A: BigCardinal; const B: BigInteger): Boolean; inline;
    class operator LessThanOrEqual(const A, B: BigInteger): Boolean; inline;
    class operator LessThanOrEqual(const A: BigInteger; const B: BigCardinal): Boolean; inline;
    class operator LessThanOrEqual(const A: BigCardinal; const B: BigInteger): Boolean; inline;

    class operator Add(const A, B: BigInteger): BigInteger;
    class operator Subtract(const A, B: BigInteger): BigInteger;
    class operator Multiply(const A, B: BigInteger): BigInteger;
    class operator IntDivide(const A, B: BigInteger): BigInteger;
    class operator Modulus(const A, B: BigInteger): BigInteger;

    class operator LeftShift(const A: BigInteger; Shift: Cardinal): BigInteger;
    class operator RightShift(const A: BigInteger; Shift: Cardinal): BigInteger;

    class operator BitwiseAnd(const A, B: BigInteger): BigInteger;
    class operator BitwiseOr(const A, B: BigInteger): BigInteger;
    class operator BitwiseXor(const A, B: BigInteger): BigInteger;

{$IFDEF LIMB32}
    function CompareToCard(const B: Cardinal): Integer;
    function CompareToInt(const B: Integer): Integer;
    function CompareTo(const B: Cardinal): Integer; overload; inline;
    function CompareTo(const B: Integer): Integer; overload; inline;
    class operator Equal(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator Equal(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator Equal(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator Equal(const A: Integer; const B: BigInteger): Boolean; inline;
    class operator NotEqual(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator NotEqual(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator NotEqual(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator NotEqual(const A: Integer; const B: BigInteger): Boolean; inline;
    class operator GreaterThan(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator GreaterThan(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator GreaterThan(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator GreaterThan(const A: Integer; const B: BigInteger): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator GreaterThanOrEqual(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator GreaterThanOrEqual(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator GreaterThanOrEqual(const A: Integer; const B: BigInteger): Boolean; inline;
    class operator LessThan(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator LessThan(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator LessThan(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator LessThan(const A: Integer; const B: BigInteger): Boolean; inline;
    class operator LessThanOrEqual(const A: BigInteger; const B: Cardinal): Boolean; inline;
    class operator LessThanOrEqual(const A: Cardinal; const B: BigInteger): Boolean; inline;
    class operator LessThanOrEqual(const A: BigInteger; const B: Integer): Boolean; inline;
    class operator LessThanOrEqual(const A: Integer; const B: BigInteger): Boolean; inline;

    class operator Add(const A: BigInteger; const B: Cardinal): BigInteger;
    class operator Add(const A: Cardinal; const B: BigInteger): BigInteger;
    class operator Add(const A: BigInteger; const B: Integer): BigInteger;
    class operator Add(const A: Integer; const B: BigInteger): BigInteger;
    class operator Subtract(const A: BigInteger; const B: Cardinal): BigInteger;
    class operator Subtract(const A: Cardinal; const B: BigInteger): BigInteger;
    class operator Subtract(const A: BigInteger; const B: Integer): BigInteger;
    class operator Subtract(const A: Integer; const B: BigInteger): BigInteger;
{$ENDIF}
  end;

type
  EBigNumberError = class(Exception)
  private
    FCode: HResult;
  public
    constructor Create(ACode: HResult; const Msg: string);
    property Code: HResult read FCode;
  end;

procedure BigNumberError(ACode: HResult; const Msg: string);

implementation

{ EBigNumberError }

constructor EBigNumberError.Create(ACode: HResult; const Msg: string);
begin
  inherited Create(Msg);
  FCode:= ACode;
end;

procedure BigNumberError(ACode: HResult; const Msg: string);
begin
  raise EBigNumberError.Create(ACode, Msg);
end;

procedure HResCheck(Value: HResult; const ErrMsg: string); inline;
begin
  if Value <> S_OK then
    BigNumberError(Value, ErrMsg);
end;

{ BigCardinal }

function BigCardinal.ToString: string;
{$IFDEF TFL_DLL}
var
  S: WideString;

begin
  HResCheck(FNumber.ToWideString(S),
    'BigCardinal -> string conversion error');
  Result:= S;
{$ELSE}
begin
  HResCheck(TBigNumber.ToString(PBigNumber(FNumber), Result),
    'BigCardinal -> string conversion error');
{$ENDIF}
end;

function BigCardinal.ToHexString(Digits: Cardinal; TwoCompl: Boolean): string;
{$IFDEF TFL_DLL}
var
  S: WideString;

begin
  HResCheck(FNumber.ToWideHexString(S, Digits, TwoCompl),
    'BigCardinal -> hex string conversion error');
  Result:= S;
{$ELSE}
begin
  HResCheck(TBigNumber.ToHexString(PBigNumber(FNumber), Result, Digits, TwoCompl),
    'BigCardinal -> hex string conversion error');
{$ENDIF}
end;

function BigCardinal.ToBytes: TBytes;
{$IFDEF TFL_DLL}
var
  HR: HResult;
  L: Cardinal;

begin
  L:= 0;
  HR:= FNumber.ToPByte(nil, L);
  if (HR = TFL_E_INVALIDARG) and (L > 0) then begin
    SetLength(Result, L);
    HR:= FNumber.ToPByte(Pointer(Result), L);
  end;
  HResCheck(HR,
{$ELSE}
begin
  HResCheck(TBigNumber.ToBytes(PBigNumber(FNumber), Result),
{$ENDIF}
    'BigCardinal -> TBytes conversion error');
end;

function BigCardinal.TryParse(const S: string): Boolean;
{$IFDEF TFL_DLL}
//var
//  WS: WideString;

begin
//  WS:= WideString(S);
//  Result:= WideStringToBigNumberU(FNumber, WS) = TFL_S_OK;
  Result:= BigNumberFromPWideChar(FNumber, Pointer(S), Length(S),
              False) = TFL_S_OK;
{$ELSE}
begin
  Result:= BigNumberFromPWideChar(PBigNumber(FNumber), Pointer(S), Length(S),
              False) = TFL_S_OK;
{$ENDIF}
end;

class function BigCardinal.Compare(const A, B: BigCardinal): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= A.FNumber.CompareNumberU(B.FNumber);
{$ELSE}
  Result:= TBigNumber.CompareNumbersU(PBigNumber(A.FNumber),
                      PBigNumber(B.FNumber));
{$ENDIF}
end;

function BigCardinal.CompareTo(const B: BigCardinal): Integer;
begin
  Result:= Compare(Self, B);
end;

class function BigCardinal.Pow(const Base: BigCardinal; Value: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Base.FNumber.PowU(Value, Result.FNumber), 'BigCardinal.Power');
{$ELSE}
  HResCheck(TBigNumber.PowU(PBigNumber(Base.FNumber), Value,
                       PBigNumber(Result.FNumber)), 'BigCardinal.Power');
{$ENDIF}
end;

class operator BigCardinal.Equal(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) = 0;
end;

class operator BigCardinal.NotEqual(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) <> 0;
end;

class operator BigCardinal.GreaterThan(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) > 0;
end;

class operator BigCardinal.GreaterThanOrEqual(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) >= 0;
end;

class operator BigCardinal.LessThan(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) < 0;
end;

class operator BigCardinal.LessThanOrEqual(const A, B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) <= 0;
end;

class operator BigCardinal.LeftShift(const A: BigCardinal; Shift: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.ShlNumber(Shift, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.ShlNumber(PBigNumber(A.FNumber), Shift,
                       PBigNumber(Result.FNumber)),
{$ENDIF}
   'BigCardinal.Shl');
end;

class operator BigCardinal.RightShift(const A: BigCardinal; Shift: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.ShrNumber(Shift, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.ShrNumber(PBigNumber(A.FNumber), Shift,
                       PBigNumber(Result.FNumber)),
{$ENDIF}
   'BigCardinal.Shr');
end;

class operator BigCardinal.Explicit(const Value: string): BigCardinal;
{$IFDEF TFL_DLL}
//var
//  WS: WideString;

begin
//  WS:= WideString(S);
//  HResCheck(WideStringToBigNumberU(FNumber, WS),
  HResCheck(BigNumberFromPWideChar(Result.FNumber, Pointer(Value),
            Length(Value), False),
{$ELSE}
begin
  HResCheck(BigNumberFromPWideChar(PBigNumber(Result.FNumber), Pointer(Value),
            Length(Value), False),
{$ENDIF}
    'string -> BigCardinal conversion error');
end;

class operator BigCardinal.Explicit(const Value: TBytes): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(BigNumberFromPByte(Result.FNumber,
{$ELSE}
  HResCheck(BigNumberFromPByte(PBigNumber(Result.FNumber),
{$ENDIF}
            Pointer(Value), Length(Value), False),
    'TBytes -> BigCardinal conversion error');
end;

procedure BigCardinal.Free;
begin
  FNumber:= nil;
end;

class operator BigCardinal.Explicit(const Value: BigCardinal): Cardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Value.FNumber.ToCardinal(Result),
{$ELSE}
  HResCheck(TBigNumber.ToCardinal(PBigNumber(Value.FNumber), Result),
{$ENDIF}
    'BigCardinal -> Cardinal conversion error');
end;

class operator BigCardinal.Explicit(const Value: BigCardinal): Integer;
begin
{$IFDEF TFL_DLL}
  HResCheck(Value.FNumber.ToInteger(Result),
{$ELSE}
  HResCheck(TBigNumber.ToInteger(PBigNumber(Value.FNumber), Result),
{$ENDIF}
    'BigCardinal -> Integer conversion error');
end;

class operator BigCardinal.Explicit(const Value: Integer): BigCardinal;
begin
  if Value < 0 then
    BigNumberError(TFL_E_INVALIDARG,
      'Integer -> BigCardinal conversion error')
  else begin
{$IFDEF TFL_DLL}
    HResCheck(BigNumberFromInteger(Result.FNumber, Cardinal(Value)),
{$ELSE}
    HResCheck(BigNumberFromInteger(PBigNumber(Result.FNumber), Cardinal(Value)),
{$ENDIF}
            'TBigNumber.FromInteger');
  end;
end;

class operator BigCardinal.Implicit(const Value: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(BigNumberFromCardinal(Result.FNumber, Value),
{$ELSE}
  HResCheck(BigNumberFromCardinal(PBigNumber(Result.FNumber), Value),
{$ENDIF}
            'TBigNumber.FromCardinal');
end;

class operator BigCardinal.BitwiseAnd(const A, B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AndNumberU(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AndNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.And');
end;

class operator BigCardinal.BitwiseOr(const A, B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.OrNumberU(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.OrNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.Or');
end;

class operator BigCardinal.Add(const A, B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AddNumberU(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.Add');
end;

class operator BigCardinal.Subtract(const A, B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.SubNumberU(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.Subtract');
end;

class operator BigCardinal.Multiply(const A, B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.MulNumberU(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.MulNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.Multiply');
end;

class operator BigCardinal.IntDivide(const A, B: BigCardinal): BigCardinal;
var
  Remainder: IBigNumber;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemNumberU(B.FNumber, Result.FNumber, Remainder),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber),
            PBigNumber(Remainder)),
{$ENDIF}
            'BigCardinal.IntDivide');
end;

class operator BigCardinal.Modulus(const A, B: BigCardinal): BigCardinal;
var
  Quotient: IBigNumber;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemNumberU(B.FNumber, Quotient, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbersU(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Quotient),
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.Modulus');
end;

class function BigCardinal.DivRem(const Dividend, Divisor: BigCardinal;
                                  var Remainder: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Dividend.FNumber.DivRemNumberU(Divisor.FNumber,
            Result.FNumber, Remainder.FNumber),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbersU(PBigNumber(Dividend.FNumber),
            PBigNumber(Divisor.FNumber), PBigNumber(Result.FNumber),
            PBigNumber(Remainder.FNumber)),
{$ENDIF}
            'BigCardinal.DivRem');
end;

{$IFDEF LIMB32}
function BigCardinal.CompareTo(const B: Cardinal): Integer;
begin
  Result:= CompareToCard(B);
end;

function BigCardinal.CompareTo(const B: Integer): Integer;
begin
  Result:= CompareToInt(B);
end;

function BigCardinal.CompareToCard(const B: Cardinal): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= FNumber.CompareToLimbU(B);
{$ELSE}
  Result:= TBigNumber.CompareToLimbU(PBigNumber(FNumber), B);
{$ENDIF}
end;

function BigCardinal.CompareToInt(const B: Integer): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= FNumber.CompareToIntLimbU(B);
{$ELSE}
  Result:= TBigNumber.CompareToIntLimbU(PBigNumber(FNumber), B);
{$ENDIF}
end;

class operator BigCardinal.Equal(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) = 0;
end;

class operator BigCardinal.Equal(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) = 0;
end;

class operator BigCardinal.Equal(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) = 0;
end;

class operator BigCardinal.Equal(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) = 0;
end;

class operator BigCardinal.NotEqual(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) <> 0;
end;

class operator BigCardinal.NotEqual(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) <> 0;
end;

class operator BigCardinal.NotEqual(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) <> 0;
end;

class operator BigCardinal.NotEqual(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) <> 0;
end;

class operator BigCardinal.GreaterThan(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) > 0;
end;

class operator BigCardinal.GreaterThan(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) < 0;
end;

class operator BigCardinal.GreaterThan(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) > 0;
end;

class operator BigCardinal.GreaterThan(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) < 0;
end;

class operator BigCardinal.GreaterThanOrEqual(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) >= 0;
end;

class operator BigCardinal.GreaterThanOrEqual(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) <= 0;
end;

class operator BigCardinal.GreaterThanOrEqual(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) >= 0;
end;

class operator BigCardinal.GreaterThanOrEqual(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) <= 0;
end;

class operator BigCardinal.LessThan(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) < 0;
end;

class operator BigCardinal.LessThan(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) > 0;
end;

class operator BigCardinal.LessThan(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) < 0;
end;

class operator BigCardinal.LessThan(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) > 0;
end;

class operator BigCardinal.LessThanOrEqual(const A: BigCardinal; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) <= 0;
end;

class operator BigCardinal.LessThanOrEqual(const A: Cardinal; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToCard(A) >= 0;
end;

class operator BigCardinal.LessThanOrEqual(const A: BigCardinal; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) <= 0;
end;

class operator BigCardinal.LessThanOrEqual(const A: Integer; const B: BigCardinal): Boolean;
begin
  Result:= B.CompareToInt(A) >= 0;
end;

class operator BigCardinal.Add(const A: BigCardinal; const B: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AddLimbU(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddLimbU(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.AddLimbU');
end;

class operator BigCardinal.Add(const A: Cardinal; const B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.AddLimbU(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddLimbU(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.AddLimbU');
end;

class operator BigCardinal.Subtract(const A: BigCardinal; const B: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.SubLimbU(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubLimbU(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.SubLimbU');
end;

class operator BigCardinal.Subtract(const A: Cardinal; const B: BigCardinal): Cardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.SubLimbU2(A, Result),
{$ELSE}
  HResCheck(TBigNumber.SubLimbU2(PBigNumber(B.FNumber), A, Result),
{$ENDIF}
            'BigCardinal.SubLimbU2');
end;

class operator BigCardinal.Multiply(const A: BigCardinal; const B: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.MulLimbU(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.MulLimbU(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.MulLimbU');
end;

class operator BigCardinal.Multiply(const A: Cardinal; const B: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.MulLimbU(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.MulLimbU(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.MulLimbU');
end;

class function BigCardinal.DivRem(const Dividend: BigCardinal;
               Divisor: Cardinal; var Remainder: Cardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Dividend.FNumber.DivRemLimbU(Divisor, Result.FNumber, Remainder),
{$ELSE}
  HResCheck(TBigNumber.DivRemLimbU(PBigNumber(Dividend.FNumber), Divisor,
            PBigNumber(Result.FNumber), Remainder),
{$ENDIF}
            'BigCardinal.DivRemLimbU');
end;

class operator BigCardinal.IntDivide(const A: BigCardinal; const B: Cardinal): BigCardinal;
var
  Remainder: Cardinal;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemLimbU(B, Result.FNumber, Remainder),
{$ELSE}
  HResCheck(TBigNumber.DivRemLimbU(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber), Remainder),
{$ENDIF}
            'BigCardinal.IntDivide');
end;

class operator BigCardinal.IntDivide(const A: Cardinal; const B: BigCardinal): Cardinal;
var
  Remainder: Cardinal;

begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.DivRemLimbU2(A, Result, Remainder),
{$ELSE}
  HResCheck(TBigNumber.DivRemLimbU2(PBigNumber(B.FNumber), A,
                       Result, Remainder),
{$ENDIF}
            'BigCardinal.IntDivide');
end;

class operator BigCardinal.Modulus(const A: BigCardinal; const B: Cardinal): Cardinal;
var
  Quotient: IBigNumber;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemLimbU(B, Quotient, Result),
{$ELSE}
  HResCheck(TBigNumber.DivRemLimbU(PBigNumber(A.FNumber),
            B, PBigNumber(Quotient), Result),
{$ENDIF}
            'BigCardinal.Modulus');
end;

class operator BigCardinal.Modulus(const A: Cardinal; const B: BigCardinal): Cardinal;
var
  Quotient: Cardinal;

begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.DivRemLimbU2(A, Quotient, Result),
{$ELSE}
  HResCheck(TBigNumber.DivRemLimbU2(PBigNumber(B.FNumber), A,
                       Quotient, Result),
{$ENDIF}
            'BigCardinal.Modulus');
end;

{$ENDIF LIMB32}

{ BigInteger }

function BigInteger.ToString: string;
{$IFDEF TFL_DLL}
var
  S: WideString;

begin
  HResCheck(FNumber.ToWideString(S),
    'BigInteger -> string conversion error');
  Result:= S;
{$ELSE}
begin
  HResCheck(TBigNumber.ToString(PBigNumber(FNumber), Result),
    'BigInteger -> string conversion error');
{$ENDIF}
end;

class operator BigInteger.BitwiseAnd(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AndNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AndNumbers(PBigNumber(A.FNumber),
                       PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
                       'BigInteger.And');
end;

class operator BigInteger.BitwiseOr(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.OrNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.OrNumbers(PBigNumber(A.FNumber),
                       PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
                       'BigInteger.Or');
end;

class operator BigInteger.BitwiseXor(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.XorNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.XorNumbers(PBigNumber(A.FNumber),
                       PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
                       'BigInteger.Xor');
end;

class function BigInteger.Compare(const A, B: BigInteger): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= A.FNumber.CompareNumber(B.FNumber);
{$ELSE}
  Result:= TBigNumber.CompareNumbers(PBigNumber(A.FNumber),
                      PBigNumber(B.FNumber));
{$ENDIF}
end;

class function BigInteger.Compare(const A: BigInteger; const B: BigCardinal): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= A.FNumber.CompareNumber(B.FNumber);
{$ELSE}
  Result:= TBigNumber.CompareNumbers(PBigNumber(A.FNumber),
                      PBigNumber(B.FNumber));
{$ENDIF}
end;

class function BigInteger.Compare(const A: BigCardinal; const B: BigInteger): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= A.FNumber.CompareNumber(B.FNumber);
{$ELSE}
  Result:= TBigNumber.CompareNumbers(PBigNumber(A.FNumber),
                      PBigNumber(B.FNumber));
{$ENDIF}
end;

function BigInteger.CompareTo(const B: BigCardinal): Integer;
begin
  Result:= Compare(Self, B);
end;

function BigInteger.CompareTo(const B: BigInteger): Integer;
begin
  Result:= Compare(Self, B);
end;

function BigInteger.GetSign: Integer;
begin
{$IFDEF TFL_DLL}
  Result:= FNumber.GetSign;
{$ELSE}
  Result:= TBigNumber.GetSign(PBigNumber(FNumber));
{$ENDIF}
end;

class operator BigInteger.Explicit(const Value: BigInteger): Cardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Value.FNumber.ToCardinal(Result),
{$ELSE}
  HResCheck(TBigNumber.ToCardinal(PBigNumber(Value.FNumber), Result),
{$ENDIF}
    'BigInteger -> Cardinal conversion error');
end;

class operator BigInteger.Explicit(const Value: BigInteger): Integer;
begin
{$IFDEF TFL_DLL}
  HResCheck(Value.FNumber.ToInteger(Result),
{$ELSE}
  HResCheck(TBigNumber.ToInteger(PBigNumber(Value.FNumber), Result),
{$ENDIF}
    'BigInteger -> Integer conversion error');
end;

class operator BigInteger.Implicit(const Value: BigCardinal): BigInteger;
begin
  Result.FNumber:= Value.FNumber;
end;

class operator BigInteger.Explicit(const Value: BigInteger): BigCardinal;
begin
{$IFDEF TFL_DLL}
  if (Value.FNumber.GetSign < 0) then
{$ELSE}
  if (PBigNumber(Value.FNumber).FSign < 0) then
{$ENDIF}
    BigNumberError(TFL_E_INVALIDARG, 'Negative value');
  Result.FNumber:= Value.FNumber;
end;

class operator BigInteger.Explicit(const Value: string): BigInteger;
{$IFDEF TFL_DLL}
//var
//  WS: WideString;

begin
//  WS:= WideString(S);
//  HResCheck(WideStringToBigNumber(FNumber, WS),
  HResCheck(BigNumberFromPWideChar(Result.FNumber, Pointer(Value),
            Length(Value), True),
{$ELSE}
begin
  HResCheck(TBigNumber.FromString(PBigNumber(Result.FNumber), Value),
{$ENDIF}
    'string -> BigInteger conversion error');
end;

class operator BigInteger.Explicit(const Value: TBytes): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(BigNumberFromPByte(Result.FNumber,
{$ELSE}
  HResCheck(BigNumberFromPByte(PBigNumber(Result.FNumber),
{$ENDIF}
            Pointer(Value), Length(Value), True),
    'TBytes -> BigInteger conversion error');
end;

class function BigInteger.Pow(const Base: BigInteger; Value: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(Base.FNumber.Pow(Value, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.Pow(PBigNumber(Base.FNumber), Value,
                       PBigNumber(Result.FNumber)),
{$ENDIF}
                       'BigInteger.Power');
end;

class operator BigInteger.Equal(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) = 0;
end;

class operator BigInteger.Equal(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) = 0;
end;

class operator BigInteger.Equal(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) = 0;
end;

class operator BigInteger.NotEqual(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) <> 0;
end;

class operator BigInteger.NotEqual(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) <> 0;
end;

class operator BigInteger.NotEqual(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) <> 0;
end;

class operator BigInteger.GreaterThan(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) > 0;
end;

class operator BigInteger.GreaterThan(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) > 0;
end;

class operator BigInteger.GreaterThan(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) > 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) >= 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) >= 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) >= 0;
end;

class operator BigInteger.LessThan(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) < 0;
end;

class operator BigInteger.LessThan(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) < 0;
end;

class operator BigInteger.LessThan(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) < 0;
end;

class operator BigInteger.LessThanOrEqual(const A, B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) <= 0;
end;

class operator BigInteger.LessThanOrEqual(const A: BigInteger; const B: BigCardinal): Boolean;
begin
  Result:= Compare(A, B) <= 0;
end;

class operator BigInteger.LessThanOrEqual(const A: BigCardinal; const B: BigInteger): Boolean;
begin
  Result:= Compare(A, B) <= 0;
end;

class operator BigInteger.LeftShift(const A: BigInteger; Shift: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.ShlNumber(Shift, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.ShlNumber(PBigNumber(A.FNumber), Shift,
                       PBigNumber(Result.FNumber)),
{$ENDIF}
   'BigInteger.Shl');
end;

class operator BigInteger.RightShift(const A: BigInteger; Shift: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.ShrNumber(Shift, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.ShrNumber(PBigNumber(A.FNumber), Shift,
                       PBigNumber(Result.FNumber)),
{$ENDIF}
   'BigInteger.Shr');
end;

procedure BigInteger.Free;
begin
  FNumber:= nil;
end;

function BigInteger.ToBytes: TBytes;
{$IFDEF TFL_DLL}
var
  HR: HResult;
  L: Cardinal;

begin
  L:= 0;
  HR:= FNumber.ToPByte(nil, L);
  if (HR = TFL_E_INVALIDARG) and (L > 0) then begin
    SetLength(Result, L);
    HR:= FNumber.ToPByte(Pointer(Result), L);
  end;
  HResCheck(HR,
{$ELSE}
begin
  HResCheck(TBigNumber.ToBytes(PBigNumber(FNumber), Result),
{$ENDIF}
    'BigInteger -> TBytes conversion error');
end;

function BigInteger.ToHexString(Digits: Cardinal; TwoCompl: Boolean): string;
{$IFDEF TFL_DLL}
var
  S: WideString;

begin
  HResCheck(FNumber.ToWideHexString(S, Digits, TwoCompl),
    'BigInteger -> hex string conversion error');
  Result:= S;
{$ELSE}
begin
  HResCheck(TBigNumber.ToHexString(PBigNumber(FNumber), Result, Digits, TwoCompl),
    'BigInteger -> hex string conversion error');
{$ENDIF}
end;

function BigInteger.TryParse(const S: string): Boolean;
{$IFDEF TFL_DLL}
//var
//  WS: WideString;

begin
//  WS:= WideString(S);
//  Result:= WideStringToBigNumber(FNumber, WS) = TFL_S_OK;
  Result:= BigNumberFromPWideChar(FNumber, Pointer(S), Length(S),
              True) = TFL_S_OK;
{$ELSE}
begin
//  Result:= TBigNumber.FromString(PBigNumber(FNumber), S) = TFL_S_OK;
  Result:= BigNumberFromPWideChar(PBigNumber(FNumber), Pointer(S), Length(S),
              True) = TFL_S_OK;
{$ENDIF}
end;

class operator BigInteger.Implicit(const Value: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(BigNumberFromCardinal(Result.FNumber, Value),
{$ELSE}
  HResCheck(BigNumberFromCardinal(PBigNumber(Result.FNumber), Value),
{$ENDIF}
            'TBigNumber.FromCardinal');
end;

class operator BigInteger.Implicit(const Value: Integer): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(BigNumberFromInteger(Result.FNumber, Value),
{$ELSE}
  HResCheck(BigNumberFromInteger(PBigNumber(Result.FNumber), Value),
{$ENDIF}
            'TBigNumber.FromInteger');
end;

class function BigInteger.Abs(const A: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AbsNumber(Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AbsNumber(PBigNumber(A.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
                'BigInteger.Abs');
end;

class operator BigInteger.Add(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AddNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddNumbers(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Add');
end;

class operator BigInteger.Subtract(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.SubNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubNumbers(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
           'BigInteger.Subtract');
end;

class operator BigInteger.Multiply(const A, B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.MulNumber(B.FNumber, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.MulNumbers(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber)),
{$ENDIF}
           'BigInteger.Multiply');
end;

class operator BigInteger.IntDivide(const A, B: BigInteger): BigInteger;
var
  Remainder: IBigNumber;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemNumber(B.FNumber, Result.FNumber, Remainder),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbers(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Result.FNumber),
            PBigNumber(Remainder)),
{$ENDIF}
            'BigInteger.IntDivide');
end;

class operator BigInteger.Modulus(const A, B: BigInteger): BigInteger;
var
  Quotient: IBigNumber;

begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.DivRemNumber(B.FNumber, Quotient, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbers(PBigNumber(A.FNumber),
            PBigNumber(B.FNumber), PBigNumber(Quotient),
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Modulus');
end;

class function BigInteger.DivRem(const Dividend, Divisor: BigCardinal;
               var Remainder: BigCardinal): BigCardinal;
begin
{$IFDEF TFL_DLL}
  HResCheck(Dividend.FNumber.DivRemNumber(Divisor.FNumber,
            Result.FNumber, Remainder.FNumber),
{$ELSE}
  HResCheck(TBigNumber.DivRemNumbers(PBigNumber(Dividend.FNumber),
            PBigNumber(Divisor.FNumber), PBigNumber(Result.FNumber),
            PBigNumber(Remainder.FNumber)),
{$ENDIF}
            'BigInteger.DivRem');
end;

{$IFDEF LIMB32}

function BigInteger.CompareTo(const B: Cardinal): Integer;
begin
  Result:= CompareToCard(B);
end;

function BigInteger.CompareTo(const B: Integer): Integer;
begin
  Result:= CompareToInt(B);
end;

function BigInteger.CompareToCard(const B: Cardinal): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= FNumber.CompareToLimb(B);
{$ELSE}
  Result:= TBigNumber.CompareToLimb(PBigNumber(FNumber), B);
{$ENDIF}
end;

function BigInteger.CompareToInt(const B: Integer): Integer;
begin
{$IFDEF TFL_DLL}
  Result:= FNumber.CompareToIntLimb(B);
{$ELSE}
  Result:= TBigNumber.CompareToIntLimb(PBigNumber(FNumber), B);
{$ENDIF}
end;

class operator BigInteger.Equal(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) = 0;
end;

class operator BigInteger.Equal(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) = 0;
end;

class operator BigInteger.Equal(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) = 0;
end;

class operator BigInteger.Equal(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) = 0;
end;

class operator BigInteger.NotEqual(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) <> 0;
end;

class operator BigInteger.NotEqual(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) <> 0;
end;

class operator BigInteger.NotEqual(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) <> 0;
end;

class operator BigInteger.NotEqual(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) <> 0;
end;

class operator BigInteger.GreaterThan(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) > 0;
end;

class operator BigInteger.GreaterThan(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) < 0;
end;

class operator BigInteger.GreaterThan(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) > 0;
end;

class operator BigInteger.GreaterThan(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) < 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) >= 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) <= 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) >= 0;
end;

class operator BigInteger.GreaterThanOrEqual(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) <= 0;
end;

class operator BigInteger.LessThan(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) < 0;
end;

class operator BigInteger.LessThan(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) > 0;
end;

class operator BigInteger.LessThan(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) < 0;
end;

class operator BigInteger.LessThan(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) > 0;
end;

class operator BigInteger.LessThanOrEqual(const A: BigInteger; const B: Cardinal): Boolean;
begin
  Result:= A.CompareToCard(B) <= 0;
end;

class operator BigInteger.LessThanOrEqual(const A: Cardinal; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToCard(A) >= 0;
end;

class operator BigInteger.LessThanOrEqual(const A: BigInteger; const B: Integer): Boolean;
begin
  Result:= A.CompareToInt(B) <= 0;
end;

class operator BigInteger.LessThanOrEqual(const A: Integer; const B: BigInteger): Boolean;
begin
  Result:= B.CompareToInt(A) >= 0;
end;


class operator BigInteger.Add(const A: BigInteger; const B: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AddLimb(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddLimb(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigCardinal.AddLimb');
end;

class operator BigInteger.Add(const A: Cardinal; const B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.AddLimb(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddLimb(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.AddLimb');
end;

class operator BigInteger.Add(const A: BigInteger; const B: Integer): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.AddIntLimb(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddIntLimb(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
           'BigInteger.AddIntLimb');
end;

class operator BigInteger.Add(const A: Integer; const B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.AddIntLimb(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.AddIntLimb(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.AddIntLimb');
end;

class operator BigInteger.Subtract(const A: BigInteger; const B: Cardinal): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.SubLimb(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubLimb(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Subtract');
end;

class operator BigInteger.Subtract(const A: Cardinal; const B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.SubLimb2(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubLimb2(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Subtract');
end;

class operator BigInteger.Subtract(const A: BigInteger; const B: Integer): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(A.FNumber.SubIntLimb(B, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubIntLimb(PBigNumber(A.FNumber), B,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Subtract');
end;

class operator BigInteger.Subtract(const A: Integer; const B: BigInteger): BigInteger;
begin
{$IFDEF TFL_DLL}
  HResCheck(B.FNumber.SubIntLimb2(A, Result.FNumber),
{$ELSE}
  HResCheck(TBigNumber.SubIntLimb2(PBigNumber(B.FNumber), A,
            PBigNumber(Result.FNumber)),
{$ENDIF}
            'BigInteger.Subtract');
end;

{$ENDIF}

{$IFDEF TFL_DLL}
initialization
  LoadForge;
{$ENDIF}

end.
