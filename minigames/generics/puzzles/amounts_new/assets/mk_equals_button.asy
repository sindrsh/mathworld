import talkortfigs;

real s = 50;
filldraw(box((-s,-s), (s,s)), RGB(239, 190, 255));
label(scale(6)*Label("$=$"), (0, -0.3*s));
label(scale(2.5)*Label("?"), (0, 0.5*s));
shipout("equal_sign");
erase();
filldraw(box((-s,-s), (s,s)), RGB(0, 204, 153));
label(scale(6)*Label("$=$"), (0, -0.1*s));
shipout("equal_sign_b");
exit();
