unit AQSM.Utils;

interface

uses
  FMX.Graphics,
  FMX.TextLayout,
  System.Types;

const
  cMaxFontSize = 512;

function FontSizeForBox(Text: string; Font: TFont; Width, Height: Single; MaxFontSize: Single = cMaxFontSize): Integer;
function CalcTextSize(Text: string; Font: TFont; Size: Single = 0): TSizeF;

implementation

uses
  FMX.Types,
  System.Math;

function CalcTextSize(Text: string; Font: TFont; Size: Single = 0): TSizeF;
var
  TextLayout: TTextLayout;
begin
  TextLayout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    TextLayout.BeginUpdate;
    try
      TextLayout.Text := Text;
      TextLayout.MaxSize := TPointF.Create(9999, 9999);
      TextLayout.Font.Assign(Font);
      if not SameValue(0, Size) then
      begin
        TextLayout.Font.Size := Size;
      end;
      TextLayout.WordWrap := False;
      TextLayout.Trimming := TTextTrimming.None;
      TextLayout.HorizontalAlign := TTextAlign.Leading;
      TextLayout.VerticalAlign := TTextAlign.Leading;
    finally
      TextLayout.EndUpdate;
    end;

    Result.Width := TextLayout.Width;
    Result.Height := TextLayout.Height;
  finally
    TextLayout.Free;
  end;
end;

function FontSizeForBox(Text: string; Font: TFont; Width, Height: Single; MaxFontSize: Single = cMaxFontSize): Integer;
var
  Size, Max, Min, MaxIterations: Integer;
  Current: TSizeF;
begin
  Max := Trunc(MaxFontSize);
  Min := 0;

  MaxIterations := 20;
  repeat
    Size := (Max + Min) div 2;

    Current := CalcTextSize(Text, Font, Size);

    if ((Abs(Width - Current.Width) < 1) and (Width >= Current.Width)) and
      ((Abs(Height - Current.Height) < 1) and (Height >= Current.Height)) then
      break
    else if (Width < Current.Width) or (Height < Current.Height) then
      Max := Size
    else
      Min := Size;

    Dec(MaxIterations);
  until MaxIterations = 0;

  Result := Size;
end;

end.
