// FOR UTF-8; RUN WITH COMMAND asy -tex xelatex

import fontsize;
settings.outformat="png";
defaultpen(fontsize(32 pt));
settings.render = 1;


unitsize(0.0352778cm);

string[] langs= {"no", "eng", "ukr"};
real w = 68;
real h = 68;

for(int i; i<langs.length; ++i){
	draw(scale(w,h)*unitsquare,black+2bp);
	label(langs[i], (w/2, h/2));
	shipout("lang_"+langs[i]+".png");
	erase();
}

