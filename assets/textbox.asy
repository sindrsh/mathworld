// FOR UTF-8; RUN WITH COMMAND asy -tex xelatex

import fontsize;
settings.outformat="png";
defaultpen(fontsize(52 pt));
//defaultpen(Helvetica());
settings.render = 1;
texpreamble("\usepackage{asycolors}");
texpreamble("\usepackage[dvipsnames]{xcolor}");
//texpreamble("\definecolor{selctc}{cmyk}{0, 0.7808, 0.4429, 0.1412}");
//texpreamble("\definecolor{combc}{cmyk}{0, 0.7808, 0.4429, 0.1412}");
//texpreamble("\definecolor{rsltc}{cmyk}{0, 0.7808, 0.4429, 0.1412}");

texpreamble("\usepackage[utf8]{inputenc}");
texpreamble("\usepackage{babel}");


texpreamble("\newcommand{\comb}[1]{\color{deepgreen} #1}");
texpreamble("\newcommand{\selct}[1]{\color{Cyan} #1}");
texpreamble("\newcommand{\rslt}[1]{\color{blue} #1}");


unitsize(0.0352778cm);

//filldraw(shift(0,-400)*scale(200,300)*unitsquare, lightgrey);

real dy = -60;
int line_cnt = 0;

void lb(string text){
	label(shift(0,line_cnt*dy)*Label(text,align=E));
	line_cnt += 1;
}



/*--- TESTING LABELS ---
label("test", p=AvantGarde());
label("test", p=Bookman(), (0,dy));
label("test", p=Courier(), (0,2dy));
label("test", p=Helvetica(), (0,3dy));
label("test", p=NewCenturySchoolBook(), (0,4dy));
label("test", p=Palatino(), (0,5dy));
label("test", p=ZapfChancery(), (0,6dy));
label("test", p=Symbol(), (0,7dy));
label("test", p=ZapfDingbats(), (0,8dy));
*/ 

