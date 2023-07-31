import inh;

defaultpen(10*0.0352778cm);

draw((0,0)--(0,20));
shipout("tick.png");
erase();
draw((0,0)--(0,20), Cyan);
shipout("tick_slct.png");
exit();
