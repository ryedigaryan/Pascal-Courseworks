Uses GRAPH, CRT;

Var dr, md, kursor, N : integer;
    c    : char;
Const DOWN=#208; UP=#200; LEFT=#203; RIGHT=#205; ESC=#27; NULL=#0; ENTER=#13; SPACE=#32; TRIANG=#16; BACKSPACE=#8;
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
     SetTextStyle(0, 0, 3);
     SetColor(Black);
     OutTextXY(236, 112, 'Problem');
     OutTextXY(260, 172, 'Input');
     OutTextXY(224, 232, 'Solution');
     OutTextXY(272, 292, 'Exit');
End;

Procedure Xndir;
Begin
     SetColor(White); SetTextStyle(1, 0, 2);
     OutTextXY(10, 100, 'HISHOXUTYAN VARJANQ. Cragiry petq e tesatipi ekrani vra');
     OutTextXY(10, 130, 'grafikakan rejimum lusavori N qanakutyuamb patahakan');
     OutTextXY(10, 160, 'keter (shrjanagcer). Dranic heto xaxacoxnery petq e');
     OutTextXY(10, 190, 'hnaravorutyun unenan yuraqanchyur keti koxqin nshel');
     OutTextXY(10, 220, 'ayd keti lusavorman hertakan hamary. Haxtum e ayn');
     OutTextXY(10, 250, 'xaxacoxy, vory myusneri nkatmamb aveli shat keter kgushaki');
     GetKey;
End;

Procedure Mutq;
Begin
     RestoreCrtMode;
     Repeat
           Write('Enter N (Max - ', 32*24, ') : ');
           Readln(N);
     Until N<=32*24;
     Writeln('Input Done! Press any key to continue...'); GetKey;
     SetGraphMode(GetGraphMode);
End;

Procedure Lucum;
Type Kordinat=record
     x, y, Pos : integer;
End;
Type XaxacoxiTvyalner=record
     Anun : string[10];
     Tokos : real;
     end;
Var i, j, minj, Gushakvac, value, YntacikXaxacox, kursor : integer;
    min : longint;
    s : string;
    Finish : boolean;
    Shrjan, Shrjan2 : Array [1..781] of Kordinat;
    Mark : Array [1..32, 1..24] of Boolean;
    CanSort : Array [1..781] of Boolean;
    Xaxacoxner : Array [1..47] of XaxacoxiTvyalner;
  Procedure Ardyunqner(N : integer);
  Var i, j, maxi, x, y, intnum : integer;
      max : real;
      Tiv, realTiv : String[5];
      temp : XaxacoxiTvyalner;
  Begin
       SetFillStyle(1, LightRed);
       Bar(0, 0, GetMaxX, GetMaxY);
       x:=(GetMaxX-150) div 2;
       y:=(GetMaxY-11*(N+1)) div 2;
       SetFillStyle(1, DarkGray);
       Bar(x, y, x+150, y+11*(N+1));
       SetCOlor(Black);
       for i:=0 to N+1 do
           Line(x, y+i*11, x+150, y+i*11);
       Line(x, y, x, y+(N+1)*11);
       Line(x+100, y, x+100, y+(N+1)*11);
       Line(x+150, y, x+150, y+(N+1)*11);
       SetTextStyle(0, 0, 1); SetColor(White);
       OutTextXY(x+35, y+2, 'Name       %');
       SetColor(LightGreen);
       if N>1 then
       Begin
       for i:=1 to N do
       Begin
           max:=Xaxacoxner[i].Tokos; maxi:=i;
           for j:=i+1 to N do
           Begin
                if Xaxacoxner[j].Tokos>max then Begin
                   max:=Xaxacoxner[j].Tokos; maxi:=j; End;
           End;
           temp:=Xaxacoxner[i];
           Xaxacoxner[i]:=Xaxacoxner[maxi];
           Xaxacoxner[maxi]:=temp;
           intnum:=trunc(max);
           Str(intnum, Tiv); SetTextStyle(0, 0, 1);
           OutTextXY(x+5, y+(i)*11+2, Xaxacoxner[i].Anun);
           realTiv:=Tiv+'.';
           intnum:=trunc(max*100);
           intnum:=intnum mod 100;
           str(intnum, Tiv);
           realTiv:=realTiv+Tiv;
           OutTextXY(x+105, y+(i)*11+2, realTiv);
       End;
       End
       else
       With Xaxacoxner[1] do
       Begin
            intnum:=trunc(Tokos);
            Str(intnum, Tiv); SetTextStyle(0, 0, 1);
            OutTextXY(x+5, y+(i-1)*11+2, Anun);
            realTiv:=Tiv+'.';
            intnum:=trunc(Tokos*100);
            intnum:=intnum mod 100;
            str(intnum, Tiv);
            realTiv:=realTiv+Tiv;
            OutTextXY(x+105, y+(i-1)*11+2, realTiv);
       End;
  End;
Begin
     Randomize;
     SetColor(Yellow); SetTextStyle(0, 0, 2);
     OutTextXY(70, 200, 'Press any key to start the game!');
     GetKey; Finish:=false;
     SetFillStyle(1, LightRed);
     Bar(0, 0, GetMaxX, GetMaxY);
     for i:=1 to 32 do
     for j:=1 to 24 do
         Mark[i][j]:=false;
     for i:=1 to N do
     Begin
          Repeat
                Shrjan[i].X:=Random(32)+1;
                Shrjan[i].Y:=Random(24)+1;
          Until Mark[Shrjan[i].X][Shrjan[i].Y]=false;
          Mark[Shrjan[i].X][Shrjan[i].Y]:=true;
          Shrjan[i].Pos:=i;
     End;
     min:=(Shrjan[1].X)*(Shrjan[1].X);min:=min+(Shrjan[1].Y)*(Shrjan[1].Y); minj:=1;
     for i:=1 to N do CanSort[i]:=true;
     for i:=1 to N do
     Begin
          for j:=1 to N do
              if (Shrjan[j].X*Shrjan[j].X+Shrjan[j].Y*Shrjan[j].Y<min) and CanSort[j] then
              Begin
                   minj:=j;
                   min:=Shrjan[j].X*Shrjan[j].X+Shrjan[j].Y*Shrjan[j].Y;
              End;
              CanSort[minj]:=false; min:=640*640+480*480;
              Shrjan2[i]:=Shrjan[minj];
     End;
     YntacikXaxacox:=0;
     While Not Finish do
     Begin
          YntacikXaxacox:=YntacikXaxacox+1;
          for i:=1 to N do CanSort[i]:=true;
          RestoreCrtMode;
          Write('Player_', YntacikXaxacox, ' Name : ');
          Readln(Xaxacoxner[YntacikXaxacox].Anun);
          SetGraphMode(GetGraphMode);
          SetFillStyle(1, LightRed);
          Bar(0, 0, GetMaxX, GetMaxY);
          for i:=1 to N do
          Begin
               SetColor(Black); SetFillStyle(1, White);
               Circle(Shrjan[i].X*20-10, Shrjan[i].Y*20-10, 10);
               FloodFill(Shrjan[i].X*20-10, Shrjan[i].Y*20-10, Black);
               Delay(500);
               SetFillStyle(1, LightRed);
               FloodFill(Shrjan[i].X*20-10, Shrjan[i].Y*20-10, Black);
               Cansort[i]:=true;
          End;
          SetColor(White); SetFillStyle(1, White); Gushakvac:=0; i:=1;
          Circle(Shrjan2[1].X*20-10, Shrjan2[1].Y*20-10, 5);
          FloodFill(Shrjan2[1].X*20-10, Shrjan2[1].Y*20-10, White);
          Repeat
                C:=GetKey;
                if C=ENTER then
                Begin
                     SetFillStyle(1, White);
                     FloodFill(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, Black);

                     s:='';
                     SetTExtStyle(2, 0, 4); SetColor(Black);
                     Repeat
                           C:=GetKey; SetColor(White);
                           OutTExtXY(Shrjan2[i].X*20-10-3*Length(s), Shrjan2[i].Y*20-15, s);
                           SetColor(Black);
                           if (Ord(C)>=48) and (Ord(C)<=57) and (Length(s)<3) then s:=s+C
                           else if C=BACKSPACE then Delete(s, Length(s), 1);
                           OutTExtXY(Shrjan2[i].X*20-10-3*Length(s), Shrjan2[i].Y*20-15, s);
                     Until (C=ENTER) and (s<>'');
                     Cansort[i]:=false;
                     Val(s, value, j);
                     if value=Shrjan2[i].Pos then
                        Gushakvac:=Gushakvac+1
                     else Break;
                     if Gushakvac<>N then
                     Begin
                        Repeat
                                i:=i+1; if i=N+1 then i:=1;
                        Until Cansort[i];
                        SetColor(White); SetFillStyle(1, White);
                        Line(0, 5, 10, 5);
                        Circle(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, 5);
                        FloodFill(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, White);
                     End;
                End
                else
                Begin
                     SetFillStyle(1, LightRed);
                     FloodFill(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, Black);
                     if C=LEFT then
                     Begin
                        Repeat
                              i:=i-1; if i=0 then i:=N;
                        Until Cansort[i];
                     End
                     else if C=RIGHT then
                     Begin
                          Repeat
                                i:=i+1; if i=N+1 then i:=1;
                          Until Cansort[i];
                     End;
                     SetColor(White); SetFillStyle(1, White);
                     Circle(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, 5);
                     FloodFill(Shrjan2[i].X*20-10, Shrjan2[i].Y*20-10, White);
                End;
          Until Gushakvac=N;
          Xaxacoxner[YntacikXaxacox].Tokos:=(Gushakvac/N)*100;
          if Gushakvac=N then
          Begin
               for i:=N+1 to N+2 do Begin{for}
               Repeat
                     Shrjan[i].X:=Random(32)+1;
                     Shrjan[i].Y:=Random(24)+1;
               Until Mark[Shrjan[i].X][Shrjan[i].Y]=false;
               Mark[Shrjan[i].X][Shrjan[i].Y]:=true;
               Shrjan[i].Pos:=i;    End;{for}
               N:=N+2;
               for i:=1 to N do CanSort[i]:=true;
               for i:=1 to N do
               Begin
                   for j:=1 to N do
                   if (Shrjan[j].X*Shrjan[j].X+Shrjan[j].Y*Shrjan[j].Y<min) and CanSort[j] then
                   Begin
                        minj:=j;
                        min:=Shrjan[j].X*Shrjan[j].X+Shrjan[j].Y*Shrjan[j].Y;
                   End;
                   CanSort[minj]:=false; min:=640*640+480*480;
                   Shrjan2[i]:=Shrjan[minj];
               End;
          End;
          SetFillStyle(1, LightRed);
          Bar(0, 0, GetMaxX, GetMaxY);
          SetColor(Black); SetTExtStyle(0, 0, 3);
          OutTextXY(200, 180, 'Next Player');
          OutTextXY(200, 260, '  Finish');
          SetColor(White); kursor:=1;
          OutTextXY(175, 180, TRIANG);
          Repeat
                C:=GetKey;
                if (C=ENTER) and (kursor=2) then Finish:=true
                else if C=DOWN then
                Begin
                     SetColor(LightRed);
                     OutTextXY(175, 180, TRIANG);
                     SetColor(White);
                     OutTextXY(223, 260, TRIANG);
                     kursor:=2;
                End
                else if C=UP then
                Begin
                     kursor:=1;
                     SetColor(LightRed);
                     OutTextXY(223, 260, TRIANG);
                     SetColor(White);
                     OutTextXY(175, 180, TRIANG);
                End
          Until C=ENTER;
     End;
     Ardyunqner(YntacikXaxacox);
     GetKey;
End;

Begin {Main}
      dr:=0;
      InitGraph(dr, md, '');
      SetFillStyle(1, LightRed);
      Bar(0, 0, GetMaxX, GetMaxY);
      Menu;
      SetColor(White); kursor:=1;
      OutTextXY(210, 112, TRIANG);
      Repeat
            C:=GetKey;
            if C=ENTER then
            Begin
                 SetFillStyle(1, LightRed);
                 Bar(0, 0, GetMaxX, GetMaxY);
                 case kursor of
                 1 : Xndir;
                 2 : Mutq;
                 3 : Lucum;
                 End;
                 SetFillStyle(1, LightRed);
                 Bar(0, 0, GetMaxX, GetMaxY);
                 Menu;
                 SetColor(White);
                 OutTextXY((GetMaxX - Length(Mode[kursor])*24) div 2-25, 112+(kursor-1)*60, TRIANG);
            End
            else
            Begin
                 SetColor(LightRed);
                 OutTextXY((GetMaxX - Length(Mode[kursor])*24) div 2-25, 112+(kursor-1)*60, TRIANG);
                 if C=UP then kursor:=kursor-1
                 else if C=DOWN then kursor:=kursor+1;
                 if kursor=0 then kursor:=4
                 else if kursor=5 then kursor:=1;
                 SetColor(White);
                 OutTextXY((GetMaxX - Length(Mode[kursor])*24) div 2-25, 112+(kursor-1)*60, TRIANG);
            End;
      Until (C=ENTER) and (kursor=4);
End.  {Main}