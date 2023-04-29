unitsize(3/4);
settings.outformat="svg";
defaultpen(1bp);

filldraw(scale(20)*unitcircle, deepgreen);
shipout("circle_x");

erase();
filldraw(scale(15)*unitcircle, cyan);
shipout("circle_neg");

erase();
filldraw(scale(15)*unitcircle, lightblue);
shipout("circle_pos");
exit();
