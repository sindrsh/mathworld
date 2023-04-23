import "../../../generics/assets/inh.asy" as inh;


pair B = (20, 5);
real r = 4;

filldraw(shift(r, -B.y/2)*scale(B.x, B.y)*unitsquare, blue);
filldraw(shift(-r-B.x,-B.y/2)*scale(B.x, B.y)*unitsquare, blue);
filldraw(scale(10)*unitcircle, blue);
shipout("mult_connection.svg");
exit();
