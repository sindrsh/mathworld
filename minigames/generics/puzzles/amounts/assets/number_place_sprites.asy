unitsize(3/4);
settings.outformat="svg";
//defaultpen(fontsize(12pt));
defaultpen(1bp);

real h = 500;

filldraw(box((0,0), (100,450)), white);
shipout("tenth_place_texture.svg");
erase();

filldraw(box((0,0), (200,450)), white);
shipout("one_place_texture.svg");
erase();

filldraw(box((0,0), (350,450)), white);
shipout("ten_place_texture.svg");
erase();

filldraw(box((0,0), (450,450)), white);
shipout("hundred_place_texture.svg");

exit();
