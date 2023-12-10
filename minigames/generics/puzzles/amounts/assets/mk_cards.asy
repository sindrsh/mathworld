import inh;

real a = 46;
real b = a*((sqrt(5)+1)/2);
path numb = box((0,0),(a,b));
real d = 6;
real labelscale = 2;

void drwnum1(int n=1){
	fill(numb, p1);
	label(scale(labelscale)*Label((string) n,(a/2,b/2),black));
}

void drwnum10(int n=1){
	for(int i=0; i<2; ++i){
		transform dx = shift(i*(d+a),0);
		fill(dx*numb, p10);
		if (i==0) {label(scale(labelscale)*Label((string) n,dx*(a/2,b/2),black));}
		else label(scale(labelscale)*Label("0",dx*(a/2,b/2),black));
	}
}

void drwnum100(int n=1){
	for(int i=0; i<3; ++i){
		transform dx = shift(i*(d+a),0);
		fill(dx*numb, p100);
		if (i==0) {label(scale(labelscale)*Label((string) n,dx*(a/2,b/2),black));}
		else label(scale(labelscale)*Label("0",dx*(a/2,b/2),black));
	}
}

void mk1() {
	for(int i=0; i<10; ++i){
		string number = (string) i;
		drwnum1(i);
		shipout(number+'a');
		erase();
	}
}

void mk10() {
	for(int i=0; i<10; ++i){
		string number = (string) (i*10);
		drwnum10(i);
	  if(i == 0){
	    number = number + number;
	  }
		shipout(number+'a');
		erase();
	}
}

void mk100() {
	for(int i=0; i<10; ++i){
		string number = (string) (i*100);
		drwnum100(i);
	  if(i == 0){
	    number = number + number + number;
	  }
		shipout(number+'a');
		erase();
	}
}

void mk100board() {
	real w = 3a+2d; // width

	pen p = white;
	fill(box((-d,0),(w+d,-d)), p);
	fill(box((0,0),(-d,b+d)), p);
	fill(box((w,0),(w+d,b+d)), p);
	fill(box((-d,b),(w+d, b+d)), p);
	fill(shift((a,0))*box((0,0), (d,b)), p);
	fill(shift((2a+d,0))*box((0,0), (d,b)), p);
	shipout("100board");
	erase();
}

void mk10board() {
	real w = 2a+d; // width

	pen p = white;
	fill(box((-d,0),(w+d,-d)), p);
	fill(box((0,0),(-d,b+d)), p);
	fill(box((w,0),(w+d,b+d)), p);
	fill(box((-d,b),(w+d, b+d)), p);
	fill(shift((a,0))*box((0,0), (d,b)), p);
	shipout("10board");
	erase();
}

void mk1boardwth0() {
	real w = a; // width

	pen p = white;
	fill(box((-d,0),(w+d,-d)), p);
	fill(box((0,0),(-d,b+d)), p);
	fill(box((w,0),(w+d,b+d)), p);
	fill(box((-d,b),(w+d, b+d)), p);

	fill(numb, p0);
	label(scale(labelscale)*Label("0",(a/2,b/2),black));

	shipout("1boardwth0");
}

void mk10boardwth0() {
	real w = 2a+d; // width

	pen p = white;
	fill(box((-d,0),(w+d,-d)), p);
	fill(box((0,0),(-d,b+d)), p);
	fill(box((w,0),(w+d,b+d)), p);
	fill(box((-d,b),(w+d, b+d)), p);
	fill(shift((a,0))*box((0,0), (d,b)), p);

	fill(numb, p0);
	label(scale(labelscale)*Label("0",(a/2,b/2),black));
	fill(shift((a+d,0))*numb, p0);
	label(scale(labelscale)*Label("0",shift((a+d,0))*(a/2,b/2),black));

	shipout("10boardwth0");
}


void mk100boardwth0() {
	real w = 3a+2d; // width

	pen p = white;
	fill(box((-d,0),(w+d,-d)), p);
	fill(box((0,0),(-d,b+d)), p);
	fill(box((w,0),(w+d,b+d)), p);
	fill(box((-d,b),(w+d, b+d)), p);
	fill(shift((a,0))*box((0,0), (d,b)), p);
	fill(shift((2a+d,0))*box((0,0), (d,b)), p);
	fill(numb, p0);
	label(scale(labelscale)*Label("0",(a/2,b/2),black));
	fill(shift((a+d,0))*numb, p0);
	label(scale(labelscale)*Label("0",shift((a+d,0))*(a/2,b/2),black));
	fill(shift((2a+2d,0))*numb, p0);
	label(scale(labelscale)*Label("0",shift((2a+2d,0))*(a/2,b/2),black));

	shipout("100boardwth0");
	erase();
}

/*
mk1();
mk10();
mk100();
mk10board();
mk10boardwth0();
mk1boardwth0();
*/

mk100boardwth0();

exit();
