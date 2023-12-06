import talkortfigs;
real w = 3a+2d; // width

pen p = white;
fill(box((-d,0),(w+d,-d)), p);
fill(box((0,0),(-d,b+d)), p);
fill(box((w,0),(w+d,b+d)), p);
fill(box((-d,b),(w+d, b+d)), p);
fill(shift((a,0))*box((0,0), (d,b)), p);
fill(shift((2a+d,0))*box((0,0), (d,b)), p);
shipout("board");
exit();
