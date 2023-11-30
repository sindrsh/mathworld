import hundredsinh;
/*
for(int i=1; i<10; ++i){
	string number = (string) (i*100);
	drwnum(i);
	shipout(number+'a');
	erase();
}
*/
draw(box((0,0), (w, b)));
fill(shift((a,0))*box((0,0), (d,b)));
fill(shift((2a,0))*box((0,0), (d,b)));
shipout("board");
