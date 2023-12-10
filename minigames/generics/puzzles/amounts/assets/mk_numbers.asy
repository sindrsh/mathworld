import inh;


real s = 30;


filldraw(scale(s)*unitsquare, p1);
shipout("one.svg");

erase();
filldraw(scale(s,10*s)*unitsquare, p10);
shipout("ten.svg");

erase();
filldraw(scale(10*s)*unitsquare, p100);
shipout("hundred.svg");
exit();
