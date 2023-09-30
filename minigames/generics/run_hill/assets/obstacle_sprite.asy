unitsize(3/4);
settings.outformat="svg";


filldraw(scale(5, 40)*unitsquare, deepgreen);
shipout("obstacle_sprite_a.svg");
erase();

filldraw(scale(5, 40)*unitsquare, red);
shipout("obstacle_sprite_b.svg");
exit();
