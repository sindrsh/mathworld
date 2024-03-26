import inh;
defaultpen(2bp);

real h = 450;

draw(box((0,0), (100, h)), white);
shipout("tenth_place_texture.svg");
erase();

draw(box((0,0), (80, h)), white);
shipout("one_place_texture.svg");
erase();

draw(box((0,0), (400, h)), white);
shipout("ten_place_texture.svg");
erase();

draw(box((0,0), (500, h)), white);
shipout("hundred_place_texture.svg");

exit();
