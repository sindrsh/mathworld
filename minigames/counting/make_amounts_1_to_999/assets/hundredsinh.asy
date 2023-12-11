import talkortfigs;


void drwnum(int n=1){
	for(int i=0; i<3; ++i){
		transform dx = shift(i*(d+a),0);
		fill(dx*numb, p100);
		if (i==0) {label(scale(labelscale)*Label((string) n,dx*(a/2,b/2),black));}
		else label(scale(labelscale)*Label("0",dx*(a/2,b/2),black));
	}
	//draw(box((0,0),(w,b)));
}
