unitsize(3/4);
settings.outformat="svg";
defaultpen(1bp);



real s = 20;
pen p1 = RGB(213, 0, 245);
pen p10 = RGB(179, 47, 68);
pen p100 = RGB(0, 197, 234);

void mk_ones(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(0,i*s)*scale(s)*unitsquare, p1);
    shipout("one"+ string(i+1) + ".svg");
  }
}

void mk_tens(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(i*s,0)*scale(s,10*s)*unitsquare, p10);
    shipout("ten" + string(i+1)+ ".svg");
  }
}

void mk_hundreds(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(i*(25,25))*scale(10*s)*unitsquare, p100);
    shipout("hundred" + string(i+1)+ ".svg");
  }
}

mk_tens();
mk_ones();
mk_hundreds();
exit();
