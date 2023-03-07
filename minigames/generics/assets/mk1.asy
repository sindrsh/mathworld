import graph;
import inh;

usepackage("icomma");
usepackage("amsmath");
usepackage("amssymb");


real sc = 10;
real y = 7;


void db(int I=1, int J=1, int m=I, int n=J, pair sh=(0,0), pen p=white, pen p1=black, bool l=false, real ls=0.0, real opac=0.1, real y = 0){
	path b = box((0,0),sc*(1,1));
	int cnt = 0;
	for (int i = 1; i <= I; ++i){
		for (int j = 1; j <= J; ++j){
			if (i<=m || j<=n){
			filldraw(shift(sh+(0,0)+(0,y*(j-1))+sc*(i-1,j-1))*b, p+opacity(opac), drawpen=p1);
			++cnt;
			}
			}
		}
		if (l == true){
			string name = "$%d$";
			string lb = format(name, cnt);
		 	label(lb,(I/2+sh.x,-ls+sh.y),S);
		 }
}

pen p1 = blue+opacity(0.1);
pen p10 = green+opacity(0.1);
pen p100 = orange+opacity(0.3);

pen p1fill = white;
pen p10fill = deepgreen;
pen p100fill = orange;

real opac = 1;
real d = 20;
real w = 20;

{
int i = 1;
string number = (string) i;
db(I=1,J=i, sh=w/2-sc/2, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 2;
string number = (string) i;
db(I=1,J=i, sh=w/2-sc/2, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 3;
string number = (string) i;
db(I=1,J=i, sh=w/2-sc/2, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 4;
string number = (string) i;
db(I=1,J=2, sh=w/2-sc-y/2, p=p1fill,opac=opac,y=y);
db(I=1,J=2, sh=w/2-sc-y/2+sc+y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 5;
string number = (string) i;
db(I=1,J=3, sh=w/2-sc-y/2, p=p1fill,opac=opac,y=y);
db(I=1,J=2, sh=w/2-sc-y/2+sc+y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 6;
string number = (string) i;
db(I=1,J=3, sh=w/2-sc-y/2, p=p1fill,opac=opac,y=y);
db(I=1,J=3, sh=w/2-sc-y/2+sc+y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 7;
string number = (string) i;
db(I=1,J=3, sh=w/2-sc-y/2, p=p1fill,opac=opac,y=y);
db(I=1,J=4, sh=w/2-sc-y/2+sc+y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 8;
string number = (string) i;
db(I=1,J=4, sh=w/2-sc-y/2, p=p1fill,opac=opac,y=y);
db(I=1,J=4, sh=w/2-sc-y/2+sc+y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}

{
int i = 9;
string number = (string) i;
db(I=1,J=3, sh=w/2-3sc/2-y, p=p1fill,opac=opac,y=y);
db(I=1,J=3, sh=w/2-3sc/2-y+sc+y, p=p1fill,opac=opac,y=y);
db(I=1,J=3, sh=w/2-3sc/2-y+2sc+2y, p=p1fill,opac=opac,y=y);
shipout(number+'b');
erase();
}
