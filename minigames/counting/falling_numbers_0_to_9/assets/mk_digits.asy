import sym_inh;

string[] intlist = {"zero","one", "two", "three", "four", "five", "six","seven", "eight", "nine"};


for(int i=0; i < intlist.length; ++i){

	string s = (string) (i);

	label(scale(3)*Label(s),black);
	shipout(intlist[i]+"_black");
	erase();

/*
	label(scale(3)*Label(s),white);
	shipout(intlist[i]+"_white");
	erase();


	label(s,red);
	shipout(intlist[i]+"_red");
	erase();

	label(s,blue);
	shipout(intlist[i]+"_blue");
	erase();

	label(s,deepgreen);
	shipout(intlist[i]+"_green");
	erase();

	label(s,Cyan);
	shipout(intlist[i]+"_cyan");
	erase();
	*/
}
