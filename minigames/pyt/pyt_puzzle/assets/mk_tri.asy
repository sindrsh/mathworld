import inh;

pair A = (0, 0);
pair B = (a, 0);
pair C = (a, b);

path p = A--B--C--cycle;

filldraw(p, triangles);
shipout("rght_btm_tri");

erase();
filldraw(rotate(-90)*p, triangles);
shipout("lft_btm_tri");

erase();
filldraw(rotate(-180)*p, triangles);
shipout("lft_tp_tri");

erase();
filldraw(rotate(-270)*p, triangles);
shipout("rght_tp_tri");

erase();
real c = sqrt(a^2+b^2);
filldraw(rotate(-asin(a/c)*180/pi)*scale(c)*unitsquare, sq_c);
shipout("tri_sqr");

exit();
