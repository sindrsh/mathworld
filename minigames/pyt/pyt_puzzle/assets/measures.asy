import inh;
defaultpen(fontsize(24pt));

pair A = (0, 0);
pair B = (a, 0);
pair C = (a, b);
pair D = (0,b);

path rect1 = scale(a, b)*unitsquare;
path p = A--B--C--cycle;

draw(A--B, L="$a$");
draw(B--C, L="$b$");
draw(A--C, L="$c$", align=NW);

filldraw(p, triangles);

mksq2(B, A);

transform sh = shift(-200, 0);

A = sh*A;
B = sh*B;
C = sh*C;
D = sh*D;


draw(A--B, L="$a$");
draw(A--D, L="$b$", align=W);
filldraw(sh*rect1, rectangles);
mksq2(A, D);
mksq2(D, C);
mksq2(C, B);
mksq2(B, A);
