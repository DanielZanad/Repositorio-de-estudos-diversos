#include <iostream>
using namespace std;

int n3, n4; // Variaveis globais

int main(){
    // Operadores matematicos: + - / * % ()


    // Declarando variaveis locais a funcao main()
    int n1, n2;
    int res1, res2;

    n1 = 11;
    n2 = 3;
    n3 = 5;
    n4 = 2;

    res1 = n1 / n2;
    res2 = n1 % n2;

    cout << "Divisao: " << res1;
    cout << "Resto: " << res2;

    return 0;
}