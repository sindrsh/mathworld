unitsize(0.025cm);
settings.outformat="svg";
defaultpen(2bp);

real s = 10;
real h = 30;
real w1 = 20;
real w2 = 10;
real w3 = 30;
path p = box((0,0), (s, h));
path b = unitsquare;

filldraw(shift((w1+w2+w3)/2,(s+h)/2)*scale(50)*unitcircle, lightblue);
draw(p);
draw(shift(0,h)*scale(w1,s)*b);
filldraw(shift(w1,h)*scale(w2,s)*b, heavygreen);
draw(shift(w1 + w2, h)*scale(w3,s)*b);
draw(shift(w1 + w2 + w3 - s, 0)*p);
shipout("go_button_a.svg");
erase();

filldraw(shift((w1+w2+w3)/2,(s+h)/2)*scale(50)*unitcircle, lightgrey);
draw(p);
draw(shift(0,h)*scale(w1,s)*b);
filldraw(shift(w1,h)*scale(w2,s)*b, heavygreen);
draw(shift(w1 + w2, h)*scale(w3,s)*b);
draw(shift(w1 + w2 + w3 - s, 0)*p);
shipout("go_button_b.svg");
erase();
exit();
