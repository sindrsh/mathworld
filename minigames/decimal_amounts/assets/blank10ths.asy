import inh;

path tenth_box = box((0,0),(tenth, one));

for(int i = 0; i < 10; ++i){
  filldraw(shift(i*tenth, 0)*tenth_box, white);
}
