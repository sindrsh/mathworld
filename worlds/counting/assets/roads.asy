unitsize(0.1cm);
settings.outformat="svg";
defaultpen(2bp);

real v = 34;
pair A = (0, 0);
pair B = rotate(v)*(50, 0);
pair C = rotate(v)*(50, 10);
pair D = rotate(v)*(0, 10);

path road = A--B--C--D--cycle;
filldraw(road, blue);
shipout("straight_road0.svg");

erase();
filldraw(rotate(90)*road, blue);
shipout("straight_road90.svg");

exit();
