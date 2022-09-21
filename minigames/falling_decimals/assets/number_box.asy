import inh;

pair A = (30, 35);
pair B = (0,A.y);
pair C = (0,0);
pair D = (20,0);
pair Ep = (A.x, -10);

path p = A--B--C--D--Ep;
draw(scale(1.5)*p);
draw(scale(1.5)*reflect(Ep,A)*p);

