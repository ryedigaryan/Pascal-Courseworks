Uses GRAPH, CRT;

Type Cucak = record
     Anun : string[18];
     Azganun : string[19];
     GrqiAnun : Array [1..100] of string[19];
     GrqiHexinak : Array [1..100] of string[19];
     Qanak : integer;
End;

Var dr, md, But, MaxN : integer;
    elq   : boolean;
    c    : char;
    Bajanord : Cucak;
Const DOWN=#208; UP=#200; LEFT=#203; RIGHT=#205; ESC=#27; NULL=#0; ENTER=#13; SPACE=#32; BackSpace=#8;
      Mode : Array [1..4] of string[9] = ('Problem', 'Input', 'Solution', 'Exit');
      CucakLength=18+19+20*19+20*19+2;

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
     SetFillStyle(1, LightBlue); SetColor(White); SetTextStyle(0, 0, 3);
     Bar(0, 0, GetMaxX, GetMaxY);

     OutTextXY(236, 112, Mode[1]);
     OutTextXY(260, 172, Mode[2]);
     OutTextXY(224, 232, Mode[3]);
     OutTextXY(272, 292, Mode[4]);

     SetColor(Blue); SetLineStyle(0, 0, 3);
     Line(224, 140, 416, 140);
     But:=1;
End;

Procedure Problem;
Begin
     SetFillStyle(1, DarkGray);
     Bar(0, 0, GetMaxX, GetMaxY);
     SetTextStyle(1, 0, 2); SetColor(LightGray);
     OutTextXY(15, 80+10, 'Stexcel teqstayin fayl, vortex hajordabar petq e grancel');
     OutTextXY(15, 80+40, 'bajanordneri azganuny, anuny yev bajanordagrvac grqeri');
     OutTextXY(15, 80+70, 'vernagrery hexinaknerov.');
     OutTextXY(15, 80+100, 'Cragrum petq e naxatesel mijocner, voronq kapahoven');
     OutTextXY(15, 80+130, 'fayli lracman hnaravorutyunnery` voch miayn nor');
     OutTextXY(15, 80+160, 'bajanordneri yev nranc bajanordagrman cankov, ayl');
     OutTextXY(15, 80+190, 'nayev naxkinum grancvac cankeri lracumov.');
     OutTextXY(15, 80+220, 'Arandzin rejimov naxatesel fayli parunakutyan');
     OutTextXY(15, 80+250, 'artapatkerumy axyusaki tesqov grafikakan ekrani vra.');
     GetKey;
End;

Procedure InDat;
Var i, n, j : integer;
    f : file of Cucak;
    Bajanord : Cucak;
Begin
     RestoreCrtMode;
     Assign(f, 'input.txt'); Rewrite(f);
     Write('Mutqagreq skzbnakan bajanordneri qanaky : ');
     Readln(n); MaxN:=n;
     Writeln('Mutqagreq ', n, ' bajanordi tvyalner.');
     Writeln;
     for i:=1 to n do
     With Bajanord do
     Begin
          Writeln('-----', i, '-----');
          Write('Bajanordi Anun : ');Readln(Anun);
          Write('Bajanordi Azganun : ');Readln(Azganun);
          Repeat
                Write('Grqeri qanak : '); Readln(Qanak);
          Until Qanak<100;
          for j:=1 to Qanak do
          Begin
               Write('Girq_', j, ' Anun : ');Readln(GrqiAnun[j]);
               Write('Girq_', j, ' Hexinak : ');Readln(GrqiHexinak[j]);
          End;
          Write(f, Bajanord);
     End;
     Close(f);
     Writeln;
     Writeln('Mutqagrumn avartvac e sexmeq kamayakan stexn durs galu hamar.');
     GetKey;
     SetGraphMode(GetGraphMode);
End;

Procedure Solution;
Var f : file of Cucak;
    ej, min, i, Button : integer;
   Procedure DrawLine(y : integer);
   Begin {DrawLine}
        SetFillStyle(1, White);
        Bar(1, y, 25, y+10);
        Bar(27, y, 171, y+10);
        Bar(173, y, 327, y+10);
        Bar(329, y, 483, y+10);
        Bar(485, y, 638, y+10);
   End;  {DrawLine}
   Procedure FillLine(y, i : integer; Baj : Cucak);
   Var s : string;
   Begin {FillLine}
        SetTextStyle(0, 0, 1); SetColor(Black);
        str(i, s); SetColor(Red);
        OutTextXY(1+(25-Length(s)*8)div 2, y+2, s);
        SetColor(Black);
        With Baj do
        Begin
             OutTextXY(29, y+2, Anun);
             OutTextXY(175, y+2, Azganun);
             OutTextXY(331, y+2, GrqiAnun[1]);
             OutTextXY(487, y+2, GrqiHexinak[1]);
        End;
   End;  {FillLine}
   Procedure GnalEj(x : integer);
   Var i, j, min : integer;
       f : file of Cucak;
   Begin {GnalEj}
         Assign(f, 'input.txt'); Reset(f);
         if (x>0) and (x<=((MaxN-1) div 37)+1) then
         Begin
              SetFillStyle(1, LightBlue);
              Bar(0, 36, GetMaxX, GetMaxY);
              ej:=x;
              if ej*37<MaxN then min:=ej*37 else min:=MaxN;
              seek(f, (ej-1)*37);
              for i:=(ej-1)*37+1 to min do
              Begin
                   if eof(f) then
                   With Bajanord do
                   Begin
                        Anun:=''; Azganun:=''; Qanak:=0;
                        for j:=1 to 100 do
                        Begin
                             GrqiAnun[j]:='';
                             GrqiHexinak[j]:='';
                        End;
                   End
                   else Read(f, Bajanord);
                   DrawLine(24+(i-(ej-1)*37)*12);
                   FillLine(24+(i-(ej-1)*37)*12, i, Bajanord);
              End;
         End;
         Close(f);
   End;  {GnalEj}
   Procedure Nayel;
   Var i, Button, y, min, GrqEj, j : integer;
       s : string[5];
       f : file of Cucak;
       NorEj : boolean;
   Begin {Nayel}
         if MaxN>0 then Begin
         Assign(f, 'input.txt'); Reset(f);
         i:=(ej-1)*37+1;
         Repeat
             SetFillStyle(1, LightGray); SetColor(Red); str(i, s); SetTextStyle(0, 0, 1);
             Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
             OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             C:=GetKey; if ej*37<MaxN then min:=ej*37 else min:=MaxN;
             if (C=DOWN) and (i<min) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i+1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if (C=UP) and (i>(ej-1)*37+1) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i-1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if C=ENTER then
             Begin
                  SetFillStyle(1, LightBlue);
                  Bar(0, 36, GetMaxX, GetMaxY);
                  DrawLine(36); seek(f, i-1); Read(f, Bajanord);
                  FillLine(36, i, Bajanord);
                  if Bajanord.Qanak<=37 then min:=Bajanord.Qanak else min:=37;
                  for j:=2 to min do
                  Begin
                       Bar(329, 24+j*12, 483, 24+j*12+10);
                       Bar(485, 24+j*12, 638, 24+j*12+10);
                       OutTextXY(331, 24+j*12+2, Bajanord.GrqiAnun[j]);
                       OutTextXY(487, 24+j*12+2, Bajanord.GrqiHexinak[j]);
                  End;

                  SetColor(Brown); SetLineStyle(0, 0, 1);
                  Rectangle(240+(-1)*30, 1, 260+(-1)*30, 21);
                  SetColor(Yellow);
                  Rectangle(240+3*30, 1, 260+3*30, 21);
                  Button:=1; GrqEj:=1;
                  Repeat
                  C:=GetKey;
                  if (C=RIGHT) and (Button=1) then
                  Begin
                       SetColor(Brown); SetLineStyle(0, 0, 1);
                       Rectangle(240+3*30, 1, 260+3*30, 21);
                       Button:=2;
                       SetColor(Yellow);
                       Rectangle(240+4*30, 1, 260+4*30, 21);
                  End
                  else if (C=LEFT) and (Button=2) then
                  Begin
                       SetColor(Brown); SetLineStyle(0, 0, 1);
                       Rectangle(240+4*30, 1, 260+4*30, 21);
                       Button:=1;
                       SetColor(Yellow);
                       Rectangle(240+3*30, 1, 260+3*30, 21);
                  End
                  else if C=ENTER then
                  Begin
                       NorEj:=False;
                       if (Button=1) and (GrqEj>1) then
                       Begin GrqEj:=GrqEj-1; NorEj:=True; End
                       else if (Button=2) and (GrqEj<(Bajanord.Qanak-1) div 37 + 1) then
                       Begin GrqEj:=GrqEj+1; NorEj:=True; End;
                       if NorEj then
                       Begin
                       SetFillStyle(1, LightBlue);
                       Bar(329, 36, GetMaxX, GetMaxY);
                       j:=(GrqEj-1)*37+1;
                       SetFillStyle(1, White); SetColor(Black);
                       if Bajanord.Qanak<GrqEj*37 then min:=Bajanord.Qanak else min:=GrqEj*37;
                       for j:=(GrqEj-1)*37+1 to min do
                       Begin
                            Bar(329, 24+(j-(GrqEj-1)*37)*12, 483, 24+(j-(GrqEj-1)*37)*12+10);
                            Bar(485, 24+(j-(GrqEj-1)*37)*12, 638, 24+(j-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(j-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[j]);
                            OutTextXY(487, 24+(j-(GrqEj-1)*37)*12+2, Bajanord.GrqiHexinak[j]);
                       End;
                       End;
                  End;
                  Until C=ESC; C:=NULL;
                  GnalEj(ej);
                  SetColor(Brown);
                  Rectangle(240+(Button+2)*30, 1, 260+(Button+2)*30, 21);
                  SetColor(Yellow);
                  Rectangle(240+(-1)*30, 1, 260+(-1)*30, 21);
             End;
         Until C=ESC; C:=NULL;
         SetFillStyle(1, White); str(i, s); SetColor(Red);
         Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
         OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
         Close(f);
         End; {End of 'if MaxN>0'}
   End;  {Nayel}
   Procedure Popoxel;
   Var i, Button, y, min, GrqEj, j, GirqI : integer;
       s : string[20];
       f, g : file of Cucak;
       Baj : Cucak;
       NorEj, Poxvec : boolean;
   Begin {Popoxel}
         if MaxN>0 then Begin
         Assign(f, 'input.txt'); Reset(f);
         Assign(g, 'temp.txt');
         i:=(ej-1)*37+1;
         Repeat
             SetFillStyle(1, LightGray); SetColor(Red); str(i, s); SetTextStyle(0, 0, 1);
             Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
             OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             C:=GetKey; if ej*37<MaxN then min:=ej*37 else min:=MaxN;
             if (C=DOWN) and (i<min) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i+1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if (C=UP) and (i>(ej-1)*37+1) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i-1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if C=ENTER then
             Begin
                  SetFillStyle(1, LightBlue);
                  Bar(0, 36, GetMaxX, GetMaxY);
                  DrawLine(36); seek(f, i-1); Read(f, Bajanord);
                  SetFillStyle(1, LightGray);
                  Bar(329, 36, 483, 36+10);
                  FillLine(36, i, Bajanord);
                  SetFillStyle(1, White); SetCOlor(Black);
                  if Bajanord.Qanak<=37 then min:=Bajanord.Qanak else min:=37;
                  for j:=1 to min do
                  Begin
                       Bar(329, 24+j*12, 483, 24+j*12+10);
                       Bar(485, 24+j*12, 638, 24+j*12+10);
                       OutTextXY(331, 24+j*12+2, Bajanord.GrqiAnun[j]);
                       OutTextXY(487, 24+j*12+2, Bajanord.GrqiHexinak[j]);
                  End;

                  {}
                  Poxvec:=false;
                  SetFillStyle(1, LightGray); SetColor(Black); s:=Bajanord.Anun;
                  Bar(27, 36, 171, 36+10);
                  OutTextXY(29, 38, s);

                  SetColor(Black);
                  Repeat
                        C:=GetKey;
                        if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                        Begin
                             s:=s+C;
                             OutTextXY(29, 38, s);
                        End
                        else if (C=BackSpace) and (s<>'') then
                        Begin
                             SetColor(LightGray);
                             OutTextXY(29, 38, s);
                             SetColor(Black);
                             Delete(s, Length(s), 1);
                             OutTextXY(29, 38, s);
                        End;
                  Until (C=ENTER) and (s<>'');
                  SetFillStyle(1, White); SetColor(Black);
                  Bar(27, 36, 171, 36+10);
                  OutTextXY(29, 38, s);
                  if Bajanord.Anun<>s then Poxvec:=true;
                  Bajanord.Anun:=s;

                  SetFillStyle(1, LightGray);
                  Bar(173, 36, 327, 36+10);
                  s:=Bajanord.Azganun;
                  OutTextXY(175, 38, s);
                  Repeat
                     C:=GetKey;
                     if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                     Begin
                          s:=s+C;
                          OutTextXY(175, 38, s);
                     End
                     else if (C=BackSpace) and (s<>'') then
                     Begin
                          SetColor(LightGray);
                          OutTextXY(175, 38, s);
                          SetColor(Black);
                          Delete(s, Length(s), 1);
                          OutTextXY(175, 38, s);
                     End;
                  Until (C=ENTER) and (s<>'');
                  SetFillStyle(1, White); SetColor(Black);
                  Bar(173, 36, 327, 36+10);
                  OutTextXY(175, 38, s);
                  if Bajanord.Azganun<>s then Poxvec:=true;
                  Bajanord.Azganun:=s;
                  {}
                  if Poxvec then
                  Begin
                       Reset(f); Rewrite(g);
                       j:=0;
                       while Not Eof(f) do
                       Begin
                            j:=j+1;
                            Read(f, Baj);
                            if i<>j then
                               Write(g, Baj)
                            else
                               Write(g, Bajanord);
                       End;
                       Close(f); Close(g);
                       Reset(g); Rewrite(f);
                       while Not Eof(g) do
                       Begin
                            Read(g, Baj);
                            Write(f, Baj);
                       End;
                       Close(f); Close(g); Reset(f);
                  End;

                  SetFillStyle(1, LightGray);
                  Bar(329, 36, 483, 36+10);
                  FillLine(36, i, Bajanord);
                  SetFillStyle(1, White); SetColor(Black);

                  Button:=1; GrqEj:=1; GirqI:=1;
                  Repeat
                  C:=GetKey;
                  if (C=RIGHT) and (Button<5) then
                  Begin
                       SetColor(Brown); SetLineStyle(0, 0, 1);
                       Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                       Button:=Button+1;
                       SetColor(Yellow);
                       Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                  End
                  else if (C=LEFT) and (Button>1) then
                  Begin
                       SetColor(Brown); SetLineStyle(0, 0, 1);
                       Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                       Button:=Button-1;
                       SetColor(Yellow);
                       Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                  End
                  else if (C=DOWN) and (GirqI<min) then
                  Begin
                       SetFillStyle(1, White); SetColor(Black);
                       Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                       GirqI:=GirqI+1;
                       SetFillStyle(1, LightGray);
                       Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                  End
                  else if (C=UP) and (GirqI>(GrqEj-1)*37+1) then
                  Begin
                       SetFillStyle(1, White); SetColor(Black);
                       Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                       GirqI:=GirqI-1;
                       SetFillStyle(1, LightGray);
                       Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                  End
                  else if C=ENTER then
                  Begin
                       NorEj:=False;
                       if (Button=4) and (GrqEj>1) then
                       Begin GrqEj:=GrqEj-1; NorEj:=True; End
                       else if (Button=5) and (GrqEj<(Bajanord.Qanak-1) div 37 + 1) then
                       Begin GrqEj:=GrqEj+1; NorEj:=True; End
                       else if (Button=3) and (Bajanord.Qanak<100) then
                       Begin GrqEj:=(Bajanord.Qanak-1) div 37 + 1; NorEj:=True; End;
                       if NorEj then
                       Begin
                       GirqI:=(GrqEj-1)*37+1;
                       SetFillStyle(1, LightBlue);
                       Bar(329, 36, GetMaxX, GetMaxY);
                       SetFillStyle(1, White); SetColor(Black);
                       if Bajanord.Qanak<GrqEj*37 then min:=Bajanord.Qanak else min:=GrqEj*37;
                          for j:=(GrqEj-1)*37+1 to min do
                          Begin
                            Bar(329, 24+(j-(GrqEj-1)*37)*12, 483, 24+(j-(GrqEj-1)*37)*12+10);
                            Bar(485, 24+(j-(GrqEj-1)*37)*12, 638, 24+(j-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(j-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[j]);
                            OutTextXY(487, 24+(j-(GrqEj-1)*37)*12+2, Bajanord.GrqiHexinak[j]);
                          End;
                       SetFillStyle(1, LightGray); SetColor(Black);
                       Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                       End
                       else if Button=1 then
                       Begin
                            SetFillStyle(1, LightGray); SetColor(Black); s:=Bajanord.GrqiAnun[GirqI];
                            Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, s);

                            SetColor(Black);
                            Repeat
                                  C:=GetKey;
                                  if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                                  Begin
                                       s:=s+C;
                                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                  End
                                  else if (C=BackSpace) and (s<>'') then
                                  Begin
                                       SetColor(LightGray);
                                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                       SetColor(Black);
                                       Delete(s, Length(s), 1);
                                       OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                  End;
                            Until (C=ENTER) and (s<>'');
                            SetFillStyle(1, White); SetColor(Black);
                            Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                            Bajanord.GrqiAnun[GirqI]:=s;

                            SetFillStyle(1, LightGray);
                            Bar(485, 24+(GirqI-(GrqEj-1)*37)*12, 638, 24+(GirqI-(GrqEj-1)*37)*12+10);
                            s:=Bajanord.GrqiHexinak[GirqI];
                            OutTextXY(487, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                            Repeat
                                  C:=GetKey;
                                  if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                                  Begin
                                       s:=s+C;
                                       OutTextXY(487, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                  End
                                  else if (C=BackSpace) and (s<>'') then
                                  Begin
                                       SetColor(LightGray);
                                       OutTextXY(487, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                       SetColor(Black);
                                       Delete(s, Length(s), 1);
                                       OutTextXY(487, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                                  End;
                            Until (C=ENTER) and (s<>'');
                            SetFillStyle(1, White); SetColor(Black);
                            Bar(485, 24+(GirqI-(GrqEj-1)*37)*12, 638, 24+(GirqI-(GrqEj-1)*37)*12+10);
                            OutTextXY(487, 24+(GirqI-(GrqEj-1)*37)*12+2, s);
                            Bajanord.GrqiHexinak[GirqI]:=s; s:='';
                       End
                       else if Button=2 then
                       Begin
                            if Bajanord.Qanak>1 then
                            With Bajanord do
                            Begin
                             for j:=GirqI to Bajanord.Qanak-1 do
                             Begin
                                  GrqiAnun[j]:=GrqiAnun[j+1];
                                  GrqiHexinak[j]:=GrqiHexinak[j+1];
                             End;
                             SetFillStyle(1, LightBlue);
                             Bar(329, 24+min*12, 483, 24+min*12+10);
                             Bar(485, 24+min*12, 638, 24+min*12+10);
                             SetFillStyle(1, White);
                             Qanak:=Qanak-1;
                             if GirqI<>Qanak+1 then
                             Begin
                               SetColor(Black);
                               if GrqEj*37<Qanak then min:=GrqEj*37 else min:=Qanak;
                               for j:=GirqI to min do
                               Begin
                                Bar(329, 24+j*12, 483, 24+j*12+10);
                                Bar(485, 24+j*12, 638, 24+j*12+10);
                                OutTextXY(331, 24+j*12+2, GrqiAnun[j]);
                                OutTextXY(487, 24+j*12+2, GrqiHexinak[j]);
                               End;
                             End
                             else GirqI:=GirqI-1;
                             if Qanak<GrqEj*37 then min:=Qanak else min:=GrqEj;
                             SetFillStyle(1, LightGray); SetColor(Black);
                             Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                             OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                            End;
                       End;
                       if (Button=3) and (Bajanord.Qanak<100) then
                       Begin
                            Bajanord.Qanak:=Bajanord.Qanak+1;
                            if Bajanord.Qanak>GrqEj*37 then
                            Begin
                                 GrqEj:=GrqEj+1;
                                 SetFillStyle(1, LightBlue);
                                 Bar(329, 36, GetMaxX, GetMaxY);
                            End;
                            SetFillStyle(1, White); SetColor(Black);
                            Bar(329, 24+(GirqI-(GrqEj-1)*37)*12, 483, 24+(GirqI-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(GirqI-(GrqEj-1)*37)*12+2, Bajanord.GrqiAnun[GirqI]);
                            SetFillStyle(1, LightGray);
                            Bar(329, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12, 483, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+10);
                            SetColor(Black); s:='';
                            Repeat
                                  C:=GetKey;
                                  if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                                  Begin
                                       s:=s+C;
                                       OutTextXY(331, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                  End
                                  else if (C=BackSpace) and (s<>'') then
                                  Begin
                                       SetColor(LightGray);
                                       OutTextXY(331, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                       SetColor(Black);
                                       Delete(s, Length(s), 1);
                                       OutTextXY(331, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                  End;
                            Until (C=ENTER) and (s<>'');
                            SetFillStyle(1, White); SetColor(Black);
                            Bar(329, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12, 483, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+10);
                            OutTextXY(331, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                            Bajanord.GrqiAnun[Bajanord.Qanak]:=s; s:='';

                            SetFillStyle(1, LightGray);
                            Bar(485, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12, 638, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+10);
                            Repeat
                                  C:=GetKey;
                                  if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                                  Begin
                                       s:=s+C;
                                       OutTextXY(487, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                  End
                                  else if (C=BackSpace) and (s<>'') then
                                  Begin
                                       SetColor(LightGray);
                                       OutTextXY(487, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                       SetColor(Black);
                                       Delete(s, Length(s), 1);
                                       OutTextXY(487, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                                  End;
                            Until (C=ENTER) and (s<>'');  C:=NULL;
                            SetFillStyle(1, White); SetColor(Black);
                            Bar(485, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12, 638, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+10);
                            OutTextXY(487, 24+(Bajanord.Qanak-(GrqEj-1)*37)*12+2, s);
                            Bajanord.GrqiHexinak[Bajanord.Qanak]:=s; s:='';
                            SetFillStyle(1, LightGray);
                            Bar(329, 24+GirqI*12, 483, 24+GirqI*12+10);
                            OutTextXY(331, 24+GirqI*12+2, Bajanord.GrqiAnun[GirqI]);
                       End;
                       Reset(f); Rewrite(g);
                       j:=0;
                       while Not Eof(f) do
                       Begin
                            j:=j+1;
                            Read(f, Baj);
                            if i<>j then
                               Write(g, Baj)
                            else
                               Write(g, Bajanord);
                       End;
                       Close(f); Close(g);
                       Reset(g); Rewrite(f);
                       while Not Eof(g) do
                       Begin
                            Read(g, Baj);
                            Write(f, Baj);
                       End;
                       Close(f); Close(g); Reset(f);
                       if GrqEj*37<Bajanord.Qanak then min:=GrqEj else min:=Bajanord.Qanak;
                  End;
                  Until C=ESC; C:=NULL;
                  GnalEj(ej);
                  SetColor(Brown);
                  Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                  SetColor(Yellow);
                  Rectangle(240, 1, 260, 21);
             End;
         Until C=ESC; C:=NULL;
         SetFillStyle(1, White); str(i, s); SetColor(Red);
         Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
         OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
         Close(f);
         End; {End of 'if MaxN>0'}
   End;  {Popoxel}
   Procedure Hanel;
   Var i, j, min : integer;
       s : string[5];
       f, g : file of Cucak;
   Begin {Hanel}
         if MaxN>0 then Begin
         Assign(f, 'input.txt');
         Assign(g, 'temp.txt');
         i:=(ej-1)*37+1;
         Repeat
             SetFillStyle(1, LightGray); SetColor(Red); str(i, s); SetTextStyle(0, 0, 1);
             Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
             OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             C:=GetKey; if ej*37<MaxN then min:=ej*37 else min:=MaxN;
             if (C=DOWN) and (i<min) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i+1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if (C=UP) and (i>(ej-1)*37+1) then
             Begin
                  SetFillStyle(1, White); str(i, s); SetColor(Red);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
                  i:=i-1;
                  SetFillStyle(1, LightGray);
                  Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
                  str(i, s);
                  OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
             End
             else if C=ENTER then
             Begin
                  Reset(f); Rewrite(g);
                  j:=0;
                  while Not Eof(f) do
                  Begin
                       j:=j+1;
                       Read(f, Bajanord);
                       if i<>j then
                          Write(g, Bajanord);
                  End;
                  Close(f); Close(g);
                  Reset(g); Rewrite(f);
                  while Not Eof(g) do
                  Begin
                       Read(g, Bajanord);
                       Write(f, Bajanord);
                  End;
                  Close(f); Close(g);
                  MaxN:=MaxN-1;
                  SetFIllStyle(1, LightBlue);
                  Bar(0, (i-(ej-1)*37)*12+24, GetMaxX, GetMaxY);
                  if ej*37<MaxN then min:=ej*37 else min:=MaxN;
                  Reset(f); seek(f, i-1);
                  for j:=i to min do
                  Begin
                       Read(f, Bajanord);
                       DrawLine((j-(ej-1)*37)*12+24);
                       FillLine((j-(ej-1)*37)*12+24, j, Bajanord);
                  End;
                  if i=MaxN+1 then i:=i-1;
                  if i<(ej-1)*37+1 then GnalEj(ej-1);
             End;
       Until (C=ESC) or (MaxN=0); C:=SPACE;
       if i>0 then
       Begin
            SetFillStyle(1, White); str(i, s); SetColor(Red);
            Bar(1, 24+(i-(ej-1)*37)*12, 25, 24+(i-(ej-1)*37)*12+10);
            OutTextXY(1+(25-Length(s)*8)div 2, 24+(i-(ej-1)*37)*12+2, s);
       End;
       End; {End of 'if MaxN>0'}
   End;  {Hanel}
   Procedure Avelacnel;
   Var y, avelEjer : integer;
       s   : string[20];
       f, g : file of Cucak;
       Baj, Empty : Cucak;
   Begin {Avelacnel}
         Bajanord:=Empty;
         MaxN:=MaxN+1;
         GnalEj((MaxN-1) div 37 + 1);
         y:=MaxN;
         DrawLine(24+(y-(ej-1)*37)*12);
         SetColor(Red); SetTextStyle(0, 0, 1);
         str(MaxN, s);
         OutTextXY(1+(25-Length(s)*8)div 2, (24+(y-(ej-1)*37)*12)+2, s);
         SetFillStyle(1, LightGray);
         Bar(27, (24+(y-(ej-1)*37)*12), 171, (24+(y-(ej-1)*37)*12)+10);
         SetColor(Black); s:='';
         Repeat
               C:=GetKey;
               if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
               Begin
                  s:=s+C;
                  OutTextXY(29, 24+(y-(ej-1)*37)*12+2, s);
               End
               else if (C=BackSpace) and (s<>'') then
               Begin
                  SetColor(LightGray);
                  OutTextXY(29, 24+(y-(ej-1)*37)*12+2, s);
                  SetColor(Black);
                  Delete(s, Length(s), 1);
                  OutTextXY(29, 24+(y-(ej-1)*37)*12+2, s);
               End;
         Until (C=ENTER) and (s<>'');
         SetFillStyle(1, White);
         Bar(27, (24+(y-(ej-1)*37)*12), 171, (24+(y-(ej-1)*37)*12)+10);
         OutTextXY(29, 24+(y-(ej-1)*37)*12+2, s);
         Bajanord.Anun:=s;

         SetFIllStyle(1, LightGray);
         Bar(173, 24+(y-(ej-1)*37)*12, 327, 24+(y-(ej-1)*37)*12+10);
         s:='';
         Repeat
             C:=GetKey;
             if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
             Begin
                  s:=s+C;
                  OutTextXY(175, 24+(y-(ej-1)*37)*12+2, s);
             End
             else if C=BackSpace then
             Begin
                  SetColor(LightGray);
                  OutTextXY(175, 24+(y-(ej-1)*37)*12+2, s);
                  SetColor(Black);
                  Delete(s, Length(s), 1);
                  OutTextXY(175, 24+(y-(ej-1)*37)*12+2, s);
             End;
         Until (C=ENTER) and (s<>'');
         SetFillStyle(1, White);
         Bar(173, 24+(y-(ej-1)*37)*12, 327, 24+(y-(ej-1)*37)*12+10);
         OutTextXY(175, 24+(y-(ej-1)*37)*12+2, s);
         Bajanord.Azganun:=s;
         i:=0; y:=y-1; avelEjer:=0;
         Repeat
               i:=i+1; y:=y+1;
               SetFillStyle(1, LightBlue);
               if y>ej*37 then
               Begin
                    ej:=ej+1; Bar(0, 36, GetMaxX, GetMaxY); AvelEjer:=AvelEjer+1;
                    DrawLine(36); SetColor(Red);
                    str(MaxN, s);
                    OutTextXY(1+(25-Length(s)*8)div 2, 38, s);
                    SetColor(Black);
                    OutTextXY(29, 38, Bajanord.Anun);
                    OutTextXY(175, 38, Bajanord.Azganun);
               End;
               SetFillStyle(1, LightGray);
               Bar(329, 24+(y-(ej-1)*37)*12, 483, 24+(y-(ej-1)*37)*12+10);
               s:='';
               Repeat
                   C:=GetKey;
                   if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                   Begin
                        s:=s+C;
                        OutTextXY(331, 24+(y-(ej-1)*37)*12+2, s);
                    End
                   else if C=BackSpace then
                   Begin
                        SetColor(LightGray);
                        OutTextXY(331, 24+(y-(ej-1)*37)*12+2, s);
                        SetColor(Black);
                        Delete(s, Length(s), 1);
                        OutTextXY(331, 24+(y-(ej-1)*37)*12+2, s);
                   End;
               Until (C=ENTER) and ((i>1) or (s<>''));
               if s='' then Break;
               SetFillStyle(1, White);
               Bar(329, 24+(y-(ej-1)*37)*12, 483, 24+(y-(ej-1)*37)*12+10);
               OutTextXY(331, 24+(y-(ej-1)*37)*12+2, s);
               Bajanord.GrqiAnun[i]:=s;

               SetFillStyle(1, LightGray);
               Bar(485, 24+(y-(ej-1)*37)*12, 638, 24+(y-(ej-1)*37)*12+10);
               s:='';
               Repeat
                   C:=GetKey;

                   if (ord(C)>=65) and (ord(C)<=122) and (Length(s)<18) then
                   Begin
                        s:=s+C;
                        OutTextXY(487, 24+(y-(ej-1)*37)*12+2, s);
                   End
                   else if C=BackSpace then
                   Begin
                        SetColor(LightGray);
                        OutTextXY(487, 24+(y-(ej-1)*37)*12+2, s);
                        SetColor(Black);
                        Delete(s, Length(s), 1);
                        OutTextXY(487, 24+(y-(ej-1)*37)*12+2, s);
                   End;
             Until (C=ENTER) and ((i>1) or (s<>''));
             SetFillStyle(1, White);
             Bar(485, 24+(y-(ej-1)*37)*12, 638, 24+(y-(ej-1)*37)*12+10);
             OutTextXY(487, 24+(y-(ej-1)*37)*12+2, s);
             if s='' then Bajanord.GrqiAnun[i]:=''
             else Bajanord.GrqiHexinak[i]:=s;
         Until (s='') and (i>1);
         Bajanord.Qanak:=i-1;
         Baj:=Bajanord;
         GnalEj(ej-AvelEjer);
         Bajanord:=Baj;
         Assign(f, 'input.txt'); Reset(f);
         Assign(g, 'temp.txt'); Rewrite(g);
         while Not Eof(f) do
         Begin
              Read(f, Baj);
              Write(g, Baj);
         End;
         Write(g, Bajanord);
         Close(f); Close(g);
         Rewrite(f); Reset(g);
         while Not Eof(g) do
         Begin
              Read(g, Baj);
              Write(f, Baj);
         End;
         Close(f); Close(g);
         SetFillStyle(1, LightBlue);
         Bar(0, 24+((MaxN-(ej-1)*37))*12, GetMaxX, GetMaxY);
         DrawLine(24+((MaxN-(ej-1)*37))*12);
         FillLine(24+((MaxN-(ej-1)*37))*12, MaxN, Bajanord);
   End;  {Avelacnel}
Begin
     SetFillStyle(1, LightBlue);
     Bar(0, 0, GetMaxX, GetMaxY);
     Assign(f, 'input.txt'); Reset(f);
     DrawLine(24);
     SetTextStyle(0, 0, 1); SetColor(Black);
     SetColor(LightRed);
     OutTextXY(80, 26, 'Name');
     OutTextXY(225, 26, 'Surname');
     OutTextXY(390, 26, 'Book');
     OutTextXY(540, 26, 'Author');
     MaxN:=0; ej:=1;
     while Not Eof(f) do
     Begin
          MaxN:=MaxN+1;
          Read(f, Bajanord);
          if MaxN<=37 then
          Begin
               DrawLine(24+MaxN*12);
               FillLine(24+MaxN*12, MaxN, Bajanord);
          End;
     End;
     SetFillStyle(1, Brown);
     Bar(210, 1, 230, 21);
     Bar(240, 1, 260, 21);
     Bar(270, 1, 290, 21);
     Bar(300, 1, 320, 21);
     Bar(330, 1, 350, 21);
     Bar(360, 1, 380, 21);
     SetColor(Yellow); SetTextStyle(0, 0, 2);
     OutTextXY(214 , 5, '?');
     OutTextXY(244 , 1, '-');
     OutTextXY(244 , 5, '-');
     OutTextXY(244 , 9, '-');
     OutTextXY(274 , 5, '-');
     OutTextXY(304 , 5, '+');
     OutTextXY(334 , 5, '< >');
     SetLineStyle(0, 0, 1);
     Rectangle(240, 1, 260, 21);
     Button:=1;
     Repeat
           C:=GetKey;
           if C=RIGHT then
           Begin
                SetColor(Brown); SetLineStyle(0, 0, 1);
                Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                Button:=Button+1;
                if Button=6 then Button:=0;
                SetColor(Yellow);
                Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
           End
           else if C=LEFT then
           Begin
                SetColor(Brown); SetLineStyle(0, 0, 1);
                Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
                Button:=Button-1;
                if Button<0 then Button:=5;
                SetColor(Yellow);
                Rectangle(240+(Button-1)*30, 1, 260+(Button-1)*30, 21);
           End
           else if C=ENTER then
                case Button of
                0 : Nayel;
                1 : Popoxel;
                2 : Hanel;
                3 : Avelacnel;
                4 : GnalEj(ej-1);
                5 : GnalEj(ej+1);
                End;
     Until C=ESC;
     Close(f);
End;

Begin {Main}
      dr:=0;
      InitGraph(dr, md, '');
      Menu; elq:=false;
      Repeat
            C:=GetKey;
            if C=UP then
            Begin
                 SetColor(LightBlue); SetLineStyle(0, 0, 3);
                 Line(224, 80+But*60, 416, 80+But*60);
                 But:=But-1;
                 if But=0 then But:=4;
                 SetColor(Blue);
                 Line(224, 80+But*60, 416, 80+But*60);
            End
            else if C=DOWN then
            Begin
                 SetColor(LightBlue); SetLineStyle(0, 0, 3);
                 Line(224, 80+But*60, 416, 80+But*60);
                 But:=But+1;
                 if But=5 then But:=1;
                 SetColor(Blue);
                 Line(224, 80+But*60, 416, 80+But*60);
            End
            else if C=ENTER then
            Begin
                 case But of
                 1 : Problem;
                 2 : InDat;
                 3 : Solution;
                 4 : elq:=true;
                 End;
                 Menu;
            End;
      Until elq;
End.  {Main}