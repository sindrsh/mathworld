import inh;

path hundredth_box = box((0,0),(tenth, tenth));

for(int i = 0; i < 100; ++i){
    filldraw(shift((i # 10)*tenth, (i % 10)*tenth)*hundredth_box, white);
}
