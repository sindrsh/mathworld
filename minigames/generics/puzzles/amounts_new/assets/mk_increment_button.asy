import inh;

unitsize(2);
real a = 4;
real c = 1;
real b = 2.8;
path t = (0,b)--(0,-b)--(b*sqrt(3)/2,0)--cycle;

filldraw(scale(10)*unitcircle, blue);
filldraw(shift(-a-b*sqrt(3)/4,-c/2)*scale(2a,c)*unitsquare, white, white);
filldraw(shift(a-b*sqrt(3)/4,0)*t, white, white);
shipout("increment_button_pressed.svg");
erase();

filldraw(scale(10)*unitcircle, magenta);
filldraw(shift(-a-b*sqrt(3)/4,-c/2)*scale(2a,c)*unitsquare, white, white);
filldraw(shift(a-b*sqrt(3)/4,0)*t, white, white);
shipout("increment_button_normal.svg");
