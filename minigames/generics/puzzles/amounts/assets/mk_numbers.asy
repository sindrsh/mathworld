import "../../../assets/inh.asy" as inh;


real s = 30;


filldraw(scale(s)*unitsquare, palegreen);
shipout("one.svg");

erase();
filldraw(scale(s,10*s)*unitsquare, paleblue);
shipout("ten.svg");

erase();
filldraw(scale(10*s)*unitsquare, palecyan);
shipout("hundred.svg");
exit();
