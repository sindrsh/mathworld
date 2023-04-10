import inh;
defaultpen(fontsize(12pt));

real sc = 2;

label(scale(sc)*Label("$a^2$"));
shipout("a2.svg");
erase();

label(scale(sc)*Label("$b^2$"));
shipout("b2.svg");
erase();

label(scale(sc)*Label("$c^2$"));
shipout("c2.svg");
erase();

label(scale(sc)*Label("$+$"));
shipout("plus.svg");
erase();

exit();
