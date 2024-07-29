unitsize(3/4);
settings.outformat="svg";
defaultpen(1bp);


path b = box((0,0), (100, 50));

path arw = (0,0)--(70,0);

filldraw(b, white);
draw(shift(10, 25)*arw, arrow=EndArrow);
