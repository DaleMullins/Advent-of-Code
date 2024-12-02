program Advent_of_Code_2024_Day_01;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Classes;

var
  List1: TStringList;
  List2: TStringList;

procedure PopulateLists;
var
  FileInput: TStringList;
  I: Integer;
begin
  FileInput := TStringList.Create;
  FileInput.NameValueSeparator := ' ';

  try
    try
      FileInput.LoadFromFile(ParamStr(1));

      for I := 0 to FileInput.Count - 1 do
      begin
        List1.Append(Trim(FileInput.Names[I]));
        List2.Append(Trim(FileInput.ValueFromIndex[I]))
      end;

      List1.Sort;
      List2.Sort;
    except
      on E: Exception do
        Raise;
    end;
  finally
    FileInput.Free;
  end;
end;

procedure GetDistance;
var
  I: Integer;
  TotalDistance: Integer;
begin
  TotalDistance := 0;
  for I := 0 to List1.Count - 1 do
  begin
    TotalDistance := TotalDistance + Abs(
      StrToInt(List1.Strings[I]) - StrToInt(List2.Strings[I]));
  end;
  WriteLn('Total distance = ' + IntToStr(TotalDistance));
end;

procedure GetSimilarityScore;
var
  I: Integer;
  J: Integer;
  SimilarityScore: Integer;
begin
  SimilarityScore := 0;
  for I := 0 to List1.Count - 1 do
  begin
    for J := 0 to List2.Count - 1 do
    begin
      if List2.Strings[J] = List1.Strings[I] then
        SimilarityScore := SimilarityScore + StrToInt(List2.Strings[J]);
    end;
  end;
  WriteLn('Similarity score = ' + IntToStr(SimilarityScore));
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  List1 := TStringList.Create;
  List2 := TStringList.Create;

  try
    try
      PopulateLists;
      GetDistance;
      GetSimilarityScore;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;
  finally
    List2.Free;
    List1.Free;
  end;
end.
