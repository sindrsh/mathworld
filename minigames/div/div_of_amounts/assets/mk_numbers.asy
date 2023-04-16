import "../../../generics/assets/inh.asy" as inh;


real s = 30;
usepackage("icomma");
usepackage("amsmath");
usepackage("amssymb");

filldraw(scale(s)*unitsquare, green+opacity(0.5));
shipout("one.svg");
erase();

for(int i=1; i<11; ++i){
  filldraw(shift(0,i*s)*scale(s)*unitsquare, blue+opacity(0.5));
}
shipout("ten.svg");
exit();
