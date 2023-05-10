unitsize(3/4);
settings.outformat="svg";
defaultpen(1bp);


real a = 100;
real b = 75;

filldraw(scale(a, b)*unitsquare, green+opacity(0.2));
label(scale(2)*Label("$?$"),(a/2, 0.7b));
label(scale(3)*Label("$=$"),(a/2, 0.3b));
