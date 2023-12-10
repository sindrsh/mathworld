import talkortfigs;

real w = 2a+d; // width

void drwnum(int n=1){
	for(int i=0; i<2; ++i){
		transform dx = shift(i*(d+a),0);
		fill(dx*numb, p10);
		if (i==0) {label(scale(labelscale)*Label((string) n,dx*(a/2,b/2),black));}
		else label(scale(labelscale)*Label("0",dx*(a/2,b/2),black));
	}
}
