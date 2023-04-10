import inh;

pair A = (0, 0);
pair B = (a, 0);
pair C = (a, b);
real c = sqrt(a^2+b^2);

real dx = 150;
label(scale(10)*Label("$=$"));

path rect1 = scale(a, b)*unitsquare;
path rect2 = scale(b, a)*unitsquare;
path a2 = scale(a)*unitsquare;
path b2 = scale(b)*unitsquare;
path c2 = scale(c)*unitsquare;
path p = A--B--C--cycle;

pair shr = (b+dx, -100);
pair shl = (-b-dx, -100);
filldraw(shift(shr)*p, triangles);
filldraw(shift(shr)*shift(-b, a)*rotate(-90)*p, triangles);
filldraw(shift(shr)*shift(-b+a, a+b)*rotate(-180)*p, triangles);
filldraw(shift(shr)*shift(a, b)*rotate(-270)*p, triangles);
filldraw(shift(shr)*shift(-b, a)*rotate(-asin(a/c)*180/pi)*scale(c)*unitsquare, sq_c);

filldraw(shift(shl)*rect2, rectangles);
filldraw(shift(shl)*shift(-a,a)*rect1, rectangles);
filldraw(shift(shl)*shift(-a,0)*a2, sq_a);
filldraw(shift(shl)*shift(0,a)*b2, sq_b);
