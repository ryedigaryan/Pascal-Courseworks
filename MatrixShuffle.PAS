Uses GRAPH, CRT;

Var dr, md, butt, n : integer;
    c : char;
    Exit : boolean;
    Matric : Array [1..50, 1..50] of integer;
Const DOWN=#208; UP=#200; LEFT=#203; RIGHT=#205; ESC=#27; NULL=#0; ENTER=#13; SPACE=#32;
      Mode : Array [1..6] of string[9] = ('Problem', 'Input', 'Solution', 'Exit', 'Random', 'Manual');

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
     SetFillStyle(1, Green);
     Bar(0, 0, GetMaxX, GetMaxY);
     butt:=1;

     SetTextStyle(0, 0, 3);
     SetColor(White);
     SetFillStyle(1, Blue);

     Bar(220, 100, 420, 150);
     OutTextXY(236, 112, 'Problem');

     SetFillStyle(1, LightBlue);
     bar(220, 160, 420, 210);
     outtextxy(260, 172, 'Input');

     bar(220, 220, 420, 270);
     outtextxy(224, 232, 'Solution');

     bar(220, 280, 420, 330);
     outtextxy(272, 292, 'Exit');
End;

Procedure Problem;
Begin
     SetColor(Black); Settextstyle(0, 0, 1);
     outtextxy(50, 130, '   Trvac NxN chapoxakanutyan A qarakusayin matricy naxapes grancel');
     outtextxy(50, 145, 'faylum: Cragri ashxatany anhrajesht e sksel faylic matrici yntercumov');
     outtextxy(50, 160, 'yev zugaherabar patkerelov grafikakan ekrani vra: Pahanjvum e matricy');
     outtextxy(50, 175, 'dzevapoxel hetyevyal skzbunqov. toxer yev syuner texapoxelov matrici');
     outtextxy(50, 190, 'mecaguyn tarry texadrel matrici verin dzax ankyunum` (1,1) vandakum:');
     outtextxy(50, 205, 'Nuyn dzevov petq e varvel ayn yentamatrici nkatmamb, vory stacvum e');
     outtextxy(50, 220, 'naxordic aranc hashvi arnelu arajin toxy yev syuny: Yerkrord');
     outtextxy(50, 235, 'yentamatrici mecaguyn tarry petq e haytnvi (2,2) vandakum: Ajdpes');
     outtextxy(50, 250, 'sharunakelov dzevavorel matrici glxavor ankyunagicy:');
     outtextxy(50, 265, '   Nkaragrvac gorcyntacy patkeravor dardznelu npatakov toxeri yev');
     outtextxy(50, 280, 'syuneri yuraqanchyur texapoxutyan ardyunqum stacvox matricy arandzin');
     outtextxy(50, 295, 'patkerel grafikakan rejimum:');
     GetKey;
End;

Procedure Entering;
Var i, j, x : integer;
    f : file of integer;
Begin
     Restorecrtmode;
     Assign(f, 'input.txt'); Rewrite(f);
     Read(n);
     Write(f, n);
     for i:=1 to n do
     for j:=1 to n do
     Begin
          Read(x);
          Write(f, x);
     End;
     Close(f);
     SetGraphMode(GetGraphMode);
End;

Procedure Solving;
Var is, js, i, j, imax, jmax, BoxLen, Max, dx, dy, delta1, delta2 : integer;
  Procedure Row(i, j, maxJ, y, color : integer);
  Var x : integer;
      s : string;
  Begin
       SetFillStyle(1, color); SetColor(Black); SetTextStyle(0, 0, 1);
       for x:=j to maxJ do
       Begin
            Bar(Delta1+(x-1)*(BoxLen+2), y, Delta1+(x-1)*(BoxLen+2)+BoxLen, y+10);
            str(Matric[i][x], s);
            OutTextXY(Delta1+(x-1)*(BoxLen+2)+2, y+1, s);
       End;
  End;
  Procedure Column(i, j, maxI, x, color : integer);
  Var y : integer;
      s : string;
  Begin
       SetFillStyle(1, color); SetColor(Black); SetTextStyle(0, 0, 1);
       for y:=i to maxI do
       Begin
            Bar(x, Delta2+(y-1)*12, x+BoxLen, Delta2+(y-1)*12+10);
            str(Matric[y][j], s);
            OutTextXY(x+2, Delta2+(y-1)*12+1, s);
       End;
  End;
  Function CountBoxLen : integer;
  Var i, j, max, min, l1, l2 : integer;
      f : file of integer;
  Begin
       Assign(f, 'input.txt'); Reset(f);
       Read(f, n);
       for i:=1 to n do
       for j:=1 to n do
           Read(f, Matric[i][j]);
       Close(f);
       max:=Matric[1][1]; min:=Matric[1][1];
       for i:=1 to n do
       for j:=1 to n do
       Begin
           if Matric[i][j]>max then max:=Matric[i][j];
           if Matric[i][j]<min then min:=Matric[i][j];
       End;
       l1:=0; l2:=0;
       while max>0 do
       Begin
            l1:=l1+1;
            max:=max div 10;
       End;
       while min<0 do
       Begin
            l2:=l2+1;
            min:=min div 10;
       End;
       l2:=l2+1;
       if l1>l2 then CountBoxLen:=l1*8+4
       else CountBoxLen:=l2*8+4;
  End;
  Function FindMax(i, j : integer) : integer;
  Var x, y, max : integer;
  Begin
       max:=Matric[i][j];
       for x:=i to n do
       for y:=j to n do
           if Matric[x][y]>max then max:=Matric[x][y];
       FIndMax:=max;
  End;
  Procedure MoveRow(i1, i2, j2 : integer);
  Var i, j, x : integer;
  Begin
       for j:=j2 to n do
       Begin
            x:=Matric[i1][j];
            for i:=i1 downto i2+1 do
                 Matric[i][j]:=Matric[i-1][j];
            Matric[i2][j]:=x;
       End;
  End;
  Procedure MoveColumn(j1, i2, j2 : integer);
  Var i, j, x : integer;
  Begin
       for i:=i2 to n do
       Begin
            x:=Matric[i][j1];
            for j:=j1 downto j2+1 do
                 Matric[i][j]:=Matric[i][j-1];
            Matric[i][j2]:=x;
       End;
  End;
Begin
     BoxLen:=CountBoxLen;
     Delta1:=(GetMaxX - (BoxLen+1)*N) div 2;
     Delta2:=(GetMaxY - 12*N) div 2;
     for i:=1 to n do
         Row(i, 1, n, Delta2+(i-1)*12, White);
     is:=1; js:=1;
     while (is<>n) or (js<>n) do
     Begin
          Max:=FindMax(is, js);
          for i:=is to n do
          for j:=js to n do
              if Matric[i][j]=Max then
              Begin
                   imax:=i; jmax:=j; i:=n; j:=n;
              End;
          if imax=is then
          Begin
               Row(is, js, n, Delta2+(is-1)*12, lightRed);
               Delay(1000);
               Row(is, js, n, Delta2+(is-1)*12, White);
          End
          else Begin{Start of else}
          dy:=0;
          for i:=n downto is do
          Begin
               while dy<>12 do
               Begin
                    SetFillStyle(1, Green);
                    Bar(Delta1+(js-1)*(BoxLen+2), Delta2+(i-1)*12+dy, Delta1+n*(BoxLen+2), Delta2+(i-1)*12+10+dy);
                    dy:=dy+1; SetFillStyle(1, White);
                    Row(i, js, n, Delta2+(i-1)*12+dy, White);
                    Delay(100);
               End;
               dy:=0;
          End;
          Delay(500);
          Row(imax, js, n, Delta2+imax*12, lightRed);
          Delay(1000);
          for j:=js to n do
          Begin
               Row(imax, js, j, Delta2+(is-1)*12, lightRed);
               Delay(1000);
          End;
          SetFillStyle(1, Green);
          Bar(Delta1+(js-1)*(BoxLen+2), Delta2+imax*12, Delta1+n*(BOxLen+2), Delta2+imax*12+10);
          dy:=0;
          for i:=imax+1 to n do
          Begin
               while dy<>12 do
               Begin
                    SetFillStyle(1, Green);
                    Bar(Delta1+(js-1)*(BoxLen+2), Delta2+i*12-dy, Delta1+n*(BoxLen+2), Delta2+i*12+10-dy);
                    dy:=dy+1; SetFillStyle(1, White);
                    Row(i, js, n, Delta2+i*12-dy, White);
                    Delay(100);
               End;
               dy:=0;
          End;
          MoveRow(imax, is, js);
          Row(is, js, n, Delta2+(is-1)*12, White);
          End; {End of else}

          if jmax=js then
          Begin
               Column(is, js, n, Delta1+(js-1)*(BoxLen+2), lightRed);
               Delay(1000);
               Column(is, js, n, Delta1+(js-1)*(BoxLen+2), White);
          End
          else Begin{Start of else-2}
          dx:=0;
          for j:=n downto js do
          Begin
               while dx<>(BoxLen+2) do
               Begin
                    SetFillStyle(1, Green);
                    Bar(Delta1+(j-1)*(BoxLen+2)+dx, Delta2+(is-1)*12, Delta1+(j-1)*(BoxLen+2)+BOxLen+dx, Delta2+n*12);
                    dx:=dx+1;
                    Column(is, j, n, Delta1+(j-1)*(BoxLen+2)+dx, WHite);
                    Delay(100);
               End;
               dx:=0;
          End;
          Delay(500);
          Column(is, jmax, n, Delta1+jmax*(BoxLen+2), lightRed);
          Delay(1000);
          for i:=is to n do
          Begin
               Column(is, jmax, i, Delta1+(js-1)*(BoxLen+2), lightRed);
               Delay(1000);
          End;
          SetFillStyle(1, Green);
          Bar(Delta1+jmax*(BoxLen+2), Delta2+(is-1)*12, Delta1+jmax*(BoxLen+2)+BoxLen, Delta2+n*12);
          dx:=0;
          for j:=jmax+1 to n do
          Begin
               while dx<>(BoxLen+2) do
               Begin
                    SetFillStyle(1, Green);
                    Bar(Delta1+j*(BoxLen+2)-dx, Delta2+(is-1)*12, Delta1+j*(BoxLen+2)+BoxLen-dx, Delta2+n*12);
                    dx:=dx+1; SetFillStyle(1, White);
                    Column(is, j, n, Delta1+j*(BoxLen+2)-dx, White);
                    Delay(100);
               End;
               dx:=0;
          End;
          MoveColumn(jmax, is, js);
          Column(is, js, n, Delta1+(js-1)*(BoxLen+2), White);
          End; {End of if-2}
          is:=is+1; js:=js+1;
     End;
     GetKey;
End;

Begin {Main}
      dr:=0;
      InitGraph(dr, md, '');
      Menu; Exit:=false;
      Repeat
            c:=GetKey;
            if c=ENTER then
            Begin
               SetFillStyle(1, Green);
               Bar(0, 0, GetMaxX, GetMaxY);
               case butt of
               1 : Problem;
               2 : Entering;
               3 : Solving;
               4 : Exit:=true;
               End;
               Menu;
            End
            else
            Begin
                 SetFillStyle(1, LightBlue);
                 Bar(220, 40+(butt*60) , 420, 90+(butt*60));
                 SetColor(White); SetTextStyle(0, 0, 3);
                 OutTextXY(320-length(Mode[butt])*12, 52+(butt*60), Mode[butt]);

                 if c=UP then
                    butt:=butt-1
                 else if c=DOWN then
                      butt:=butt+1;
                 if butt=0 then butt:=1
                 else if butt=5 then butt:=4;

                 SetFillStyle(1, Blue);
                 Bar(220, 40+(butt*60) , 420, 90+(butt*60));
                 SetColor(White); SetTextStyle(0, 0, 3);
                 OutTExtXY(320-length(Mode[butt])*12, 52+(butt*60), Mode[butt]);
            End;
      Until Exit;
End.  {Main}