#include <iostream>

using namespace std;

class Alo{
  int id;
public:
  Alo(int _id){
    id = _id;
    cout << "Construtor de Alo: elemento " << id << "\n";
  }
  ~Alo(){
    cout << "Destrutor de Alo: elemento " << id << "\n";
  }
};

int main(void){
  Alo x(1), y(2), z(3);
}
