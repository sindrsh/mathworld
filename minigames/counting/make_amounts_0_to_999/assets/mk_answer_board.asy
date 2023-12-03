import talkortfigs;

fill(box((-d,0),(w+d,-d)));
fill(box((0,0),(-d,b+d)));
fill(box((w,0),(w+d,b+d)));
fill(box((-d,b),(w+d, b+d)));
fill(shift((a,0))*box((0,0), (d,b)));
fill(shift((2a+d,0))*box((0,0), (d,b)));
shipout("board");
exit();
