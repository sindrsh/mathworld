unitsize(3/4);
settings.outformat="svg";
defaultpen(5bp);

path p = (0,0)--(0,20);
draw(p);
shipout("tick.svg");

erase();
draw(p, Cyan);
shipout("tick_select.svg");

erase();
draw(p, red);
shipout("tick_wrong.svg");

erase();
draw(p, cmyk(green));
shipout("tick_correct.svg");
exit();
