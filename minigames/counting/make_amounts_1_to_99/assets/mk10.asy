import tensinh;

for(int i=0; i<10; ++i){
	string number = (string) (i*10);
	drwnum(i);
	if(i == 0){
		number = number + number;
	}
	shipout(number+'a');
	erase();
}
