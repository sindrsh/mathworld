unitsize(3/4);
settings.outformat="svg";
defaultpen(4bp);

real x = 100;
real y = 20;

pair A = (0,0);
pair B = (x,0);
path C = (B.x,y);
path D = (B.x,-y);
draw(C--D);
shipout("tick.svg");
draw(A--B);
