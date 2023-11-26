import inh;
import graph;

pair f(real x){
  return (cos(x), sin(x));
}

real h = 20;
real r = 10;
path top = scale(r)*graph(f, 0,pi);
path bottom = scale(r)*graph(f, -pi,-0);
top = shift(0,h)*top;
bottom = shift(0,-h)*bottom;
path tick = top--bottom--cycle;
real w = 10;
real l = 1400;
path number_line = shift(0,-w/2)*scale(l,w)*unitsquare;


filldraw(tick);
shipout("tick.png");
erase();
filldraw(tick, Cyan);
shipout("tick_slct.png");
erase();

real segment_length = l/9-5;
path segment= shift(-segment_length/2,-w/2)*scale(segment_length,w)*unitsquare;
filldraw(tick);
filldraw(segment, red);
shipout("tick_segment.png");
erase();

filldraw(number_line);
shipout("number_line.png");
