unitsize(3/4);
settings.outformat="svg";
defaultpen(2bp);

real x = 40;
real y = 10;

pair A = (0,0);
pair B = (x,0);
path C = (B.x,y);
path D = (B.x,-y);

draw(A--B^^C--D);
