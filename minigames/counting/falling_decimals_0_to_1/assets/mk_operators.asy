import sym_inh;

string[] intlist = {"equals", "plus", "minus", "times", "divided", "dot", "comma"};
string[] oplist = {"$=$", "$+$", "$-$", "$\cdot$", "$:$", "$.$", "$,$"};

for(int i=0; i < intlist.length; ++i){

	string s = oplist[i];

	label(s,black);
	shipout(intlist[i]+"_");
	erase();

	label(s,Cyan);
	shipout(intlist[i]+"_r");
	erase();

	label(s,blue);
	shipout(intlist[i]+"_b");
	erase();

	label(s,deepgreen);
	shipout(intlist[i]+"_g");
	erase();
}
