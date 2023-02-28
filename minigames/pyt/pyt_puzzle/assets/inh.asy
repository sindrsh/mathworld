unitsize(3/4);
settings.outformat="svg";
//defaultpen(fontsize(12pt));
defaultpen(1bp);

real s = 10;
real a = s*8;
real b = s*15;

pen sq_a = red;
pen sq_b = Cyan;
pen rectangles = orange;
pen triangles = lightblue;
pen sq_c = lightgreen;

void mksq2(pair A=(0,0), pair B=(1,0), real sc=1, real u=sc, pen p=black, real rot=0, bool h=true){
	real k = 0.3cm;
	pair nx = k*(B-A)/abs(B-A);
	pair ny = (nx.y, -nx.x);
	path sq;
    if (h){sq=sc*nx--sc*nx+u*ny--u*ny;}
    else sq=(0,0)--sc*nx--sc*nx+u*ny--u*ny--cycle;
    draw(A,rotate(rot)*sq, p);
}
