Uses GRAPH, CRT;

Var dr, md, yntrvac, n, m : integer;
    elq   : boolean;
    c    : char;
    Matric : Array [1..50, 1..50] of integer;
Const DOWN=#208; UP=#200; LEFT=#203; RIGHT=#205; ESC=#27; NULL=#0; ENTER=#13; SPACE=#32;
      Mode : Array [1..4] of string[9] = ('Problem', 'Input', 'Solution', 'Exit');

Function GetKey : Char;
Var c : char;
Begin {GetKey}
     c:=ReadKey;
     Repeat
           if c=NULL then
           Begin c:=ReadKey;
                 if Ord(c)>127 then c:=NULL
                 else GetKey:=Chr(Ord(C)+128);
           End
           else GetKey:=c;
     Until c<>NULL;
End;  {GetKey}

Procedure Menu;
Begin
     yntrvac:=1;
     SetTextStyle(0, 0, 3);
     SetColor(White);
     SetFillStyle(1, Red);

     Bar(220, 100, 420, 150);
     OutTextXY(236, 112, 'Problem');

     SetFillStyle(1, LightRed);
     bar(220, 160, 420, 210);
     outtextxy(260, 172, 'Input');

     bar(220, 220, 420, 270);
     outtextxy(224, 232, 'Solution');

     bar(220, 280, 420, 330);
     outtextxy(272, 292, 'Exit');
End;

Procedure problem;
Begin
     SetColor(White); Settextstyle(0, 0, 1);
     outtextxy(65, 170, ' Trvac NxM chapoxakanutyamb uxxankyun matricy, vori tarrery');
     outtextxy(65, 185, 'amboxj tver en, grancel faylum yev artacel tesatipi ekrani');
     outtextxy(65, 200, 'vra grafikakan rejimum.');
     outtextxy(65, 215, ' Kazmel cragir, vory nuyn patkeri vra kcucadri matrici syuneri');
     outtextxy(65, 230, 'texasharjy depi aj ciklik exanakov. Ptuyt@ dadarecnel kamayakan');
     outtextxy(65, 245, 'stexn sexmeluc heto.');
     GetKey;
End;

procedure inputdata;
var i, x : integer;
    f : file of integer;
begin
     Restorecrtmode;
     Assign(f, 'input.txt'); Rewrite(f);
     Readln(n, m);
     write(f, n, m);
     for i:=1 to n*m do
     begin
          read(x);
          write(f, x);
     end;
     close(f);
     setgraphmode(getgraphmode);
end;

procedure solution;
var i, j, yerkarutyun, pos, xx, yy : integer;
    f : file of integer;
 procedure syun(j, iMax, x, y : integer);
 var i : integer;
     s : string;
 begin
      SetFillStyle(1, White);  settextstyle(0, 0, 1); setcolor(black);
      if iMax<>n then
      begin
           bar(xx+x, yy+y+(iMax-1)*11, xx+x+yerkarutyun-1, yy+y+iMax*11-2);
           str(matric[iMax][j], s);
           outtextxy(xx+x+1, yy+y+(iMax-1)*11+1, s);
      end
      else
      for i:=1 to iMax do
      begin
           bar(xx+x, yy+y+(i-1)*11, xx+x+yerkarutyun-1, yy+y+i*11-2);
           str(matric[i][j], s);
           outtextxy(xx+x+1, yy+y+(i-1)*11+1, s);
      end;
 end;

 function  amenayerkar : integer;
 var i, j, max, min, y1, y2 : integer;
 begin
      max:=matric[1][1]; min:=matric[1][1];
      for i:=1 to n do
      for j:=1 to m do
      begin
           if matric[i][j]>max then max:=matric[i][j];
           if matric[i][j]<min then min:=matric[i][j];
      end;
      y1:=0; y2:=0;
      while max>0 do
      begin
           y1:=y1+1;
           max:=max div 10;
      end;
      while min<0 do
      begin
           y2:=y2+1;
           min:=min div 10;
      end;
      if y1>y2+1 then amenayerkar:=y1
      else amenayerkar:=y2+1;
 end;
 procedure ptuyt;
 var i, j, k : integer;
 begin
      for i:=1 to n do
      begin
           k:=matric[i][m];
           for j:=m downto 2 do
               matric[i][j]:=matric[i][j-1];
           matric[i][1]:=k;
      end;
 end;
begin
     assign(f, 'input.txt'); reset(f);
     read(f, n, m);
     for i:=1 to n do
     for j:=1 to m do
         read(f, matric[i][j]);
     close(f);
     yerkarutyun:=amenayerkar*8+2;
     xx:=(GetMaxX - (yerkarutyun+1)*M) div 2;
     yy:=(GetMaxY - 11*n) div 2;
     for j:=1 to m do
          syun(j, N, (j-1)*(yerkarutyun+1), 0);
     c:=#0;
     while not keypressed do
     begin
          for j:=m downto 1 do
          begin
               pos:=(j-1)*(yerkarutyun+1);
               while pos<j*(yerkarutyun+1) do
               begin
                    SetFillStyle(1, Green);
                    bar(xx+pos, yy, xx+pos+yerkarutyun, yy+n*11);
                    pos:=pos+1;
                    syun(j, N, pos, 0);
                    delay(50);
                    if keypressed then begin c:=getkey; break; end;
               end;
               if c<>#0 then break;
          end;
          if c<>#0 then break;
          for i:=1 to N do
          Begin
              if KeyPressed then Begin C:=GetKey; Break; End;
              syun(m, i, 0, 0);
              Delay(1000);
          End;
          if c<>#0 then break;
          delay(500);
          SetFillStyle(1, Green);
          bar(xx+m*(yerkarutyun+1), yy, xx+(m+1)*(yerkarutyun+1), yy+11*n);
          ptuyt;
          delay(500);
     end;
     GetKey;
end;

Begin {Main}
      dr:=0;
      InitGraph(dr, md, '');
      SetFillStyle(1, Green);
      Bar(0, 0, GetMaxX, GetMaxY);
      Menu; elq:=false;
      Repeat
            c:=GetKey;
            if (c=DOWN) and (yntrvac<4) then
            Begin
                 SetFillStyle(1, LightRed);
                 Bar(220, 40+(yntrvac*60) , 420, 90+(yntrvac*60));
                 SetColor(White); SetTextStyle(0, 0, 3);
                 OutTExtXY(320-length(Mode[yntrvac])*12, 52+(yntrvac*60), Mode[yntrvac]);
                 yntrvac:=yntrvac+1;
                 SetFillStyle(1, Red);
                 Bar(220, 40+(yntrvac*60) , 420, 90+(yntrvac*60));
                 OutTExtXY(320-length(Mode[yntrvac])*12, 52+(yntrvac*60), Mode[yntrvac]);
            End
            else if (c=UP) and (yntrvac>1) then
            Begin
                 SetFillStyle(1, LightRed);
                 Bar(220, 40+(yntrvac*60) , 420, 90+(yntrvac*60));
                 SetColor(White); SetTextStyle(0, 0, 3);
                 OutTExtXY(320-length(Mode[yntrvac])*12, 52+(yntrvac*60), Mode[yntrvac]);
                 yntrvac:=yntrvac-1;
                 SetFillStyle(1, Red);
                 Bar(220, 40+(yntrvac*60) , 420, 90+(yntrvac*60));
                 OutTExtXY(320-length(Mode[yntrvac])*12, 52+(yntrvac*60), Mode[yntrvac]);
            End
            else if c=ENTER then
            Begin
                 SetFillStyle(1, Green);
                 Bar(0, 0, GetMaxX, GetMaxY);
                 case yntrvac of
                 1 : problem;
                 2 : inputdata;
                 3 : solution;
                 4 : elq:=true;
                 end;
                 SetFillStyle(1, Green);
                 Bar(0, 0, GetMaxX, GetMaxY);
                 Menu;
            End;
      Until elq;
End.  {Main}