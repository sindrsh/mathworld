import "../../../generics/assets/inh.asy" as inh;


filldraw(shift(-2.5, 5)*scale(5,10)*unitsquare, blue);
filldraw(shift(-2.5, -5)*scale(5,10)*unitsquare, blue);
filldraw(scale(10)*unitsquare, blue);
shipout("mult_connection.svg");
exit();
