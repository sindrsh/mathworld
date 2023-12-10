import talkortfigs;

real opac = 1;
real w = a; // width

void drwnum(int n=1){
	fill(numb, p1);
	label(scale(labelscale)*Label((string) n,(a/2,b/2),black));
}
