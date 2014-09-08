{ *********************************************************** }
{ *                     TForge Library                      * }
{ *       Copyright (c) Sergey Kasandrov 1997, 2014         * }
{ *********************************************************** }

unit tfMD5;

{$I TFL.inc}

interface

uses tfTypes;

type
  PMD5Alg = ^TMD5Alg;
  TMD5Alg = record
  private type
    TData = record
      Digest: TMD5Digest;
      Block: array[0..63] of Byte;   // 512-bit message block
      Count: UInt64;                 // number of bytes processed
    end;
  private
    FVTable: Pointer;
    FRefCount: Integer;
    FData: TData;

    procedure Compress;
  public
    class function Release(Inst: PMD5Alg): Integer; stdcall; static;
    class procedure Init(Inst: PMD5Alg);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class procedure Update(Inst: PMD5Alg; Data: PByte; DataSize: LongWord);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class procedure Done(Inst: PMD5Alg; PDigest: PMD5Digest);
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
//    class procedure Purge(Inst: PMD5Alg);  -- redirected to Init
//         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function GetDigestSize(Inst: PMD5Alg): LongInt;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function GetBlockSize(Inst: PMD5Alg): LongInt;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
    class function Duplicate(Inst: PMD5Alg; var DupInst: PMD5Alg): TF_RESULT;
         {$IFDEF TFL_STDCALL}stdcall;{$ENDIF} static;
  end;

function GetMD5Algorithm(var Inst: PMD5Alg): TF_RESULT;

implementation

uses tfRecords;

const
  MD5VTable: array[0..9] of Pointer = (
    @TtfRecord.QueryIntf,
    @TtfRecord.Addref,
    @TMD5Alg.Release,

    @TMD5Alg.Init,
    @TMD5Alg.Update,
    @TMD5Alg.Done,
    @TMD5Alg.Init,
    @TMD5Alg.GetDigestSize,
    @TMD5Alg.GetBlockSize,
    @TMD5Alg.Duplicate
  );

function GetMD5Algorithm(var Inst: PMD5Alg): TF_RESULT;
var
  P: PMD5Alg;

begin
  try
    New(P);
    P^.FVTable:= @MD5VTable;
    P^.FRefCount:= 1;
    TMD5Alg.Init(P);
    if Inst <> nil then TMD5Alg.Release(Inst);
    Inst:= P;
    Result:= TF_S_OK;
  except
    Result:= TF_E_OUTOFMEMORY;
  end;
end;

function Rol32(Value, Shift: LongWord): LongWord; inline;
begin
  Result:= (Value shr (32 - Shift)) or (Value shl Shift);
end;

function FF(A, B, C, D, X, S: LongWord): LongWord; inline;
begin
  Result:= Rol32(A + ((B and C) or (not B and D)) + X, S) + B;
end;

function GG(A, B, C, D, X, S: LongWord): LongWord; inline;
begin
  Result:= Rol32(A + ((B and D) or (C and not D)) + X, S) + B;
end;

function HH(A, B, C, D, X, S: LongWord): LongWord; inline;
begin
  Result:= Rol32(A + (B xor C xor D) + X, S) + B;
end;

function II(A, B, C, D, X, S: LongWord): LongWord; inline;
begin
  Result:= Rol32(A + (C xor (B or not D)) + X, S) + B;
end;

procedure TMD5Alg.Compress;
var
  MD: TMD5Digest;
  Block: array[0..15] of LongWord;

begin
  MD:= FData.Digest;
  Move(FData.Block, Block, SizeOf(Block));
  with MD do begin
                                                       {round 1}
    A:= FF(A, B, C, D, Block[ 0] + $D76AA478,  7);  { 1 }
    D:= FF(D, A, B, C, Block[ 1] + $E8C7B756, 12);  { 2 }
    C:= FF(C, D, A, B, Block[ 2] + $242070DB, 17);  { 3 }
    B:= FF(B, C, D, A, Block[ 3] + $C1BDCEEE, 22);  { 4 }
    A:= FF(A, B, C, D, Block[ 4] + $F57C0FAF,  7);  { 5 }
    D:= FF(D, A, B, C, Block[ 5] + $4787C62A, 12);  { 6 }
    C:= FF(C, D, A, B, Block[ 6] + $A8304613, 17);  { 7 }
    B:= FF(B, C, D, A, Block[ 7] + $FD469501, 22);  { 8 }
    A:= FF(A, B, C, D, Block[ 8] + $698098D8,  7);  { 9 }
    D:= FF(D, A, B, C, Block[ 9] + $8B44F7AF, 12);  { 10 }
    C:= FF(C, D, A, B, Block[10] + $FFFF5BB1, 17);  { 11 }
    B:= FF(B, C, D, A, Block[11] + $895CD7BE, 22);  { 12 }
    A:= FF(A, B, C, D, Block[12] + $6B901122,  7);  { 13 }
    D:= FF(D, A, B, C, Block[13] + $FD987193, 12);  { 14 }
    C:= FF(C, D, A, B, Block[14] + $A679438E, 17);  { 15 }
    B:= FF(B, C, D, A, Block[15] + $49B40821, 22);  { 16 }
                                                       {round 2}
    A:= GG(A, B, C, D, Block[ 1] + $F61E2562,  5);  { 17 }
    D:= GG(D, A, B, C, Block[ 6] + $C040B340,  9);  { 18 }
    C:= GG(C, D, A, B, Block[11] + $265E5A51, 14);  { 19 }
    B:= GG(B, C, D, A, Block[ 0] + $E9B6C7AA, 20);  { 20 }
    A:= GG(A, B, C, D, Block[ 5] + $D62F105D,  5);  { 21 }
    D:= GG(D, A, B, C, Block[10] + $02441453,  9);  { 22 }
    C:= GG(C, D, A, B, Block[15] + $D8A1E681, 14);  { 23 }
    B:= GG(B, C, D, A, Block[ 4] + $E7D3FBC8, 20);  { 24 }
    A:= GG(A, B, C, D, Block[ 9] + $21E1CDE6,  5);  { 25 }
    D:= GG(D, A, B, C, Block[14] + $C33707D6,  9);  { 26 }
    C:= GG(C, D, A, B, Block[ 3] + $F4D50D87, 14);  { 27 }
    B:= GG(B, C, D, A, Block[ 8] + $455A14ED, 20);  { 28 }
    A:= GG(A, B, C, D, Block[13] + $A9E3E905,  5);  { 29 }
    D:= GG(D, A, B, C, Block[ 2] + $FCEFA3F8,  9);  { 30 }
    C:= GG(C, D, A, B, Block[ 7] + $676F02D9, 14);  { 31 }
    B:= GG(B, C, D, A, Block[12] + $8D2A4C8A, 20);  { 32 }
                                                       {round 3}
    A:= HH(A, B, C, D, Block[ 5] + $FFFA3942,  4);  { 33 }
    D:= HH(D, A, B, C, Block[ 8] + $8771F681, 11);  { 34 }
    C:= HH(C, D, A, B, Block[11] + $6D9D6122, 16);  { 35 }
    B:= HH(B, C, D, A, Block[14] + $FDE5380C, 23);  { 36 }
    A:= HH(A, B, C, D, Block[ 1] + $A4BEEA44,  4);  { 37 }
    D:= HH(D, A, B, C, Block[ 4] + $4BDECFA9, 11);  { 38 }
    C:= HH(C, D, A, B, Block[ 7] + $F6BB4B60, 16);  { 39 }
    B:= HH(B, C, D, A, Block[10] + $BEBFBC70, 23);  { 40 }
    A:= HH(A, B, C, D, Block[13] + $289B7EC6,  4);  { 41 }
    D:= HH(D, A, B, C, Block[ 0] + $EAA127FA, 11);  { 42 }
    C:= HH(C, D, A, B, Block[ 3] + $D4EF3085, 16);  { 43 }
    B:= HH(B, C, D, A, Block[ 6] + $04881D05, 23);  { 44 }
    A:= HH(A, B, C, D, Block[ 9] + $D9D4D039,  4);  { 45 }
    D:= HH(D, A, B, C, Block[12] + $E6DB99E5, 11);  { 46 }
    C:= HH(C, D, A, B, Block[15] + $1FA27CF8, 16);  { 47 }
    B:= HH(B, C, D, A, Block[ 2] + $C4AC5665, 23);  { 48 }
                                                       {round 4}
    A:= II(A, B, C, D, Block[ 0] + $F4292244,  6);  { 49 }
    D:= II(D, A, B, C, Block[ 7] + $432AFF97, 10);  { 50 }
    C:= II(C, D, A, B, Block[14] + $AB9423A7, 15);  { 51 }
    B:= II(B, C, D, A, Block[ 5] + $FC93A039, 21);  { 52 }
    A:= II(A, B, C, D, Block[12] + $655B59C3,  6);  { 53 }
    D:= II(D, A, B, C, Block[ 3] + $8F0CCC92, 10);  { 54 }
    C:= II(C, D, A, B, Block[10] + $FFEFF47D, 15);  { 55 }
    B:= II(B, C, D, A, Block[ 1] + $85845DD1, 21);  { 56 }
    A:= II(A, B, C, D, Block[ 8] + $6FA87E4F,  6);  { 57 }
    D:= II(D, A, B, C, Block[15] + $FE2CE6E0, 10);  { 58 }
    C:= II(C, D, A, B, Block[ 6] + $A3014314, 15);  { 59 }
    B:= II(B, C, D, A, Block[13] + $4E0811A1, 21);  { 60 }
    A:= II(A, B, C, D, Block[ 4] + $F7537E82,  6);  { 61 }
    D:= II(D, A, B, C, Block[11] + $BD3AF235, 10);  { 62 }
    C:= II(C, D, A, B, Block[ 2] + $2AD7D2BB, 15);  { 63 }
    B:= II(B, C, D, A, Block[ 9] + $EB86D391, 21);  { 64 }

    Inc(FData.Digest.A, A);
    Inc(FData.Digest.B, B);
    Inc(FData.Digest.C, C);
    Inc(FData.Digest.D, D);
  end;
  FillChar(FData.Block, SizeOf(FData.Block), 0);
  FillChar(Block, SizeOf(Block), 0);
end;

class function TMD5Alg.Release(Inst: PMD5Alg): Integer;
begin
  Init(Inst);
  Result:= TtfRecord.Release(Inst);
end;

class procedure TMD5Alg.Init(Inst: PMD5Alg);
begin
  Inst.FData.Digest.A:= $67452301;   // load magic initialization constants
  Inst.FData.Digest.B:= $EFCDAB89;
  Inst.FData.Digest.C:= $98BADCFE;
  Inst.FData.Digest.D:= $10325476;

  FillChar(Inst.FData.Block, SizeOf(Inst.FData.Block), 0);
  Inst.FData.Count:= 0;
end;

class procedure TMD5Alg.Update(Inst: PMD5Alg; Data: PByte; DataSize: LongWord);
var
  Cnt, Ofs: LongWord;

begin
  while DataSize > 0 do begin
    Ofs:= LongWord(Inst.FData.Count) and $3F;
    Cnt:= $40 - Ofs;
    if Cnt > DataSize then Cnt:= DataSize;
    Move(Data^, PByte(@Inst.FData.Block)[Ofs], Cnt);
    if (Cnt + Ofs = $40) then Inst.Compress;
    Inc(Inst.FData.Count, Cnt);
    Dec(DataSize, Cnt);
    Inc(Data, Cnt);
  end;
end;

class procedure TMD5Alg.Done(Inst: PMD5Alg; PDigest: PMD5Digest);
var
  Ofs: Integer;

begin
  Ofs:= LongWord(Inst.FData.Count) and $3F;
  Inst.FData.Block[Ofs]:= $80;
  if Ofs >= 56 then
    Inst.Compress;

  Inst.FData.Count:= Inst.FData.Count shl 3;
  PLongWord(@Inst.FData.Block[56])^:= LongWord(Inst.FData.Count);
  PLongWord(@Inst.FData.Block[60])^:= LongWord(Inst.FData.Count shr 32);
  Inst.Compress;

  Move(Inst.FData.Digest, PDigest^, SizeOf(TMD5Digest));

  Init(Inst);
end;

class function TMD5Alg.GetDigestSize(Inst: PMD5Alg): LongInt;
begin
  Result:= SizeOf(TMD5Digest);
end;

class function TMD5Alg.GetBlockSize(Inst: PMD5Alg): LongInt;
begin
  Result:= 64;
end;

class function TMD5Alg.Duplicate(Inst: PMD5Alg; var DupInst: PMD5Alg): TF_RESULT;
begin
  Result:= GetMD5Algorithm(DupInst);
  if Result = TF_S_OK then
    DupInst.FData:= Inst.FData;
end;

end.
