import inh;

filldraw(scale(a, b)*unitsquare, rectangles);
shipout("ab_rect");

erase();
filldraw(scale(b, a)*unitsquare, rectangles);
shipout("ab_rect2");

erase();
filldraw(scale(a)*unitsquare, sq_a);
shipout("a_sq");

erase();
filldraw(scale(b)*unitsquare, sq_b);
shipout("b_sq");
