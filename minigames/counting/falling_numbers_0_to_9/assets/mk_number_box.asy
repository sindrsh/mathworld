import inh;

pair A = (45, 53);
pair B = (0,A.y);
pair C = (0,0);
pair D = (30,0);
pair Ep = (A.x, -15);
transform r = reflect(Ep,A);

pair F = r*Ep;
pair G = r*D;
pair H = r*C;
pair Ip = r*B;

path p = B--C--D--Ep--F--G--H--Ip--cycle;
draw(p);
shipout("number_box.png");

erase();
filldraw(p, Cyan);
shipout("number_box_slct.png");

erase();
filldraw(p, orange);
shipout("number_box_find.png");

erase();
filldraw(p, red);
shipout("number_box_unequal.png");

erase();
filldraw(p, heavygreen);
shipout("number_box_equal.png");

exit();


