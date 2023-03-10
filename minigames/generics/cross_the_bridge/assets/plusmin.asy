import inh;

real r = 100;

draw(scale(r)*unitsquare, black+2bp);
label(r/2*(1,1), scale(5)*Label("$+$"));
shipout("plus");

erase();

draw(scale(r)*unitsquare, black+2bp);
label(r/2*(1,1), scale(5)*Label("$-$"));
shipout("min");
exit();
