unit WORK_5_v22;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, jpeg, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Label2: TLabel;
    StringGrid2: TStringGrid;
    Label3: TLabel;
    Memo1: TMemo;
    Edit1: TEdit;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type massive = array[1..10] of real;
var
  Form1: TForm1;
  y: massive;
  i, k, c: integer;
  R, p, m: real;
  l: massive;
  f: textfile;

const x: massive = (-0.24, 5.7, -7.1, 2.9, 1, 0.15, -2.23, 9.3, 10, -0.2);

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 AssignFile(f, './resultat.pas');
 Rewrite(f);
 write(f, 'Source array:');
 for i:=1 to 10 do write(f, x[i]:5:2, ' ');
 StringGrid1.Cells[0, 0]:='X';
 StringGrid1.Cells[1, 0]:='Y';
 c:=1;
 for i:=1 to 10 do
 begin
 StringGrid1.Cells[0, c]:=FormatFloat('0.00', x[i]);
 StringGrid2.Cells[0, c]:=FormatFloat('0.00', x[i]);
 c:=c+1;
 end;
 p:=1;
 for i:=1 to 10 do  
    if x[i]<0 then p:=p*x[i];
 R:=SimpleRoundTo(p, -2);
 writeln(f);
 writeln(f, 'p =',R:6:3);
 writeln(f, 'Selection condition: X[i]<', R:6:3);
 Edit1.Text:=FloatToStr(R);
 k:=0;
 for i:=1 to 10 do
    if x[i]<R then
    begin
      k:=k+1;
      y[k]:=x[i];
    end;

 //write file:
 writeln(f, 'Target array Y:');
 if k=0 then writeln(f, 'No values were found. Array Y is not formed') else
 c:=1;
 for i:=1 to k do
 begin
 writeln(f, y[i]:5:2);
 c:=c+1;
 end;

 if k=0 then Memo1.Text:='No values were found. Array Y is not formed' else
 c:=1;
 for i:=1 to k do
 begin
 StringGrid1.Cells[1, c]:=FormatFloat('0.00', y[i]);
 c:=c+1;
 end;

 //bouble sort:
 StringGrid2.Cells[0, 0]:='X';
 StringGrid2.Cells[1, 0]:='SORT(X)';
 for i:= 1 to 10 do l[i]:=x[i];
 k:=0;
 i:=0;
 m:=0;
 for i:=1 to length(l)-1 do
    for k:=1 to length(l)-i do
      begin
      if l[k]>l[k+1] then
      begin
      m:=l[k];
      l[k]:=l[k+1];
      l[k+1]:=m;
      end;
      end;
 c:=1;
 for i:=1 to 10 do
    begin
    StringGrid2.Cells[1, c]:=FormatFloat('0.00', l[i]);
    c:=c+1;
    end;

 //write file:
 write(f, 'Sorted array: ');
 for i:=1 to 10 do
    begin
    write(f, l[i]:5:2, ' ');
    end;
 closefile(f);
end;



procedure TForm1.BitBtn3Click(Sender: TObject);
begin
close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var q, z, n, p, n1, p1: integer;

begin
  n := StringGrid1.RowCount;
  p := StringGrid1.ColCount;
  for q:=1 to n-1 do
  for z:=0 to p-1 do
  begin
  StringGrid1.Cells[z, q]:='';
  StringGrid2.Cells[z, q]:='';
  end;

  Memo1.Text:='';
  Edit1.Text:='';
end;
end.
