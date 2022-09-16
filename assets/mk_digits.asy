import inh;

string[] intlist = {"zero","one", "two", "three", "four", "five", "six","seven", "eight", "nine"};


for(int i=0; i < intlist.length; ++i){

	string s = (string) (i);
	label(s,black);
	shipout(intlist[i]+"_");	
	erase();
	
	label(s,red);
	shipout(intlist[i]+"_r");	
	erase();
	
	label(s,blue);
	shipout(intlist[i]+"_b");	
	erase();
	
	label(s,deepgreen);
	shipout(intlist[i]+"_g");	
	erase();
	
	label(s,Cyan);
	shipout(intlist[i]+"_c");	
	erase();
}


