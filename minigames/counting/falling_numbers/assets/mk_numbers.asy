unitsize(3/4);
settings.outformat="svg";
defaultpen(1bp);



real s = 20;

void mk_ones(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(0,i*s)*scale(s)*unitsquare, palegreen);
    shipout("one"+ string(i+1) + ".svg");
  }
}

void mk_tens(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(i*s,0)*scale(s,10*s)*unitsquare, paleblue);
    shipout("ten" + string(i+1)+ ".svg");
  }
}

void mk_hundreds(){
  erase();
  for(int i; i<9; ++i){
    filldraw(shift(i*(25,25))*scale(10*s)*unitsquare, palecyan);
    shipout("hundred" + string(i+1)+ ".svg");
  }
}

mk_tens();
mk_ones();
mk_hundreds();
exit();
