import inh;


real s = 30;

/*
filldraw(scale(s)*unitsquare, p1);
shipout("one.svg");

erase();
filldraw(scale(s,10*s)*unitsquare, p10);
shipout("ten.svg");

erase();
filldraw(scale(10*s)*unitsquare, p100);
shipout("hundred.svg");
exit();
*/

void mk_ten_ones(){
  for(int i; i<10; ++i){
      filldraw(shift(0,i*s)*scale(s)*unitsquare, p1);
  }
  shipout("ten_ones.svg");
  erase();
}

void mk_ten_tens(){
  for(int i; i<10; ++i){
      filldraw(shift(i*s,0)*scale(s,10*s)*unitsquare, p10);
  }
  shipout("ten_tens.svg");
  erase();
}

mk_ten_tens();
