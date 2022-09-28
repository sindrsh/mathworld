import inh;

defaultpen(5*0.0352778cm);

draw((0,0)--(0,20));
shipout("tick.png");
erase();
draw((0,0)--(0,20), blue);
shipout("tick_slct.png");

erase();
draw((0,0)--(0,20), red);
shipout("tick_red.png");

exit();
