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

void mk_hundred_ones(){
  for(int i; i<10; ++i){
    for(int j; j<10; ++j){
      filldraw(shift(j*s,i*s)*scale(s)*unitsquare, p1);
    }
  }
  shipout("hundred_ones.svg");
  erase();
}

void mk_ones(){
  real dxy = 10;
  for(int i; i<9; ++i){
      filldraw(shift(-(i % 2)*(s+dxy),(i # 2)*(s+dxy))*scale(s)*unitsquare, p1);
      shipout(string(i+1) + "_ones.svg");
  }
  erase();
}

void mk_tens(){
  real dx = 10;
  for(int i; i<9; ++i){
      filldraw(shift(i*(s+dx),0)*scale(s,10*s)*unitsquare, p10);
      shipout(string(i+1) + "_tens.svg");
  }
  erase();
}

mk_tens();
