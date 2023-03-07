import inh;

string[] numbers = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};

for(int i; i< 10; ++i){
  label(scale(5)*Label(string(i)));
  shipout(numbers[i] + ".svg");
  erase();
}
