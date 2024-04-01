import inh;


real dy = 10;
real r = 15;
real w = 40;
real h = 4*dy+6r;

path c = scale(r)*unitcircle;
path b = shift(-w/2, -r-dy+h)*scale(w,h)*unitsquare;

/*
filldraw(b, heavygrey);
for(int i=0; i<3; ++i){
  filldraw(shift(0,h+(dy+2r)*i)*c, white);
}
shipout("status-0.svg");
for(int i=0; i<3; ++i){
  filldraw(shift(0,h+(dy+2r)*i)*c, green);
  shipout("status-"+ string(i+1) +".svg");
}
*/
filldraw(b, grey);
for(int i=0; i<3; ++i){
  filldraw(shift(0,h+(dy+2r)*i)*c, mediumgrey);
}
shipout("status-idle.svg");
exit();
