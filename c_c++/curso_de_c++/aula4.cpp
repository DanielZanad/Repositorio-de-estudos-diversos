// Fazendo o include da biblioteca iostream
#include <iostream>

// Definindo o namespace, indicando a onde estao as bibliotecas que vao ser trabalhadas
using namespace std;

// funcao principal do programa
int main(){
    // Declaracao de uma variavel =>
    // TIPO e NOME;
    // TIPO NOME = VALOR;

    int vidas = 0; // Variavel do tipo inteira recebendo numeros como => 2,25,-1

    char letra = 'B'; // Variavel do tipo caracter recebendo um letra => 'A', 'c', 'b'

    double decimal = 2.50; // Variavel do tipo double que recebe numeros reais => 2.343, 22.2, -23.5

    float decimal2 = 10.2; // Variavel do tipo float que recebe numeros reais, mas a precisao e menor que a do double 

    bool vivo = true; // Variavel do tipo boolean que recebe dois valores => false, true

    string nome = "Walter White"; // Variavel do tipo string que recebe palavras => "Hello", "Ola", "Eminem"

    cout << "Digite o numero de vidas: ";
    cin >> vidas;

    cout << "Digite a letra: ";
    cin >> letra;

    cout << "Dinheiro: ";
    cin >> decimal;

    cout << "Digite seu nome: ";
    cin >> nome;


    cout << "\nVidas: " << vidas << "\nDecimal: " << decimal << "\nLetra: " << letra << "\nVivo: "  << vivo << "\nNome: " << nome << "\n";

    return 0;
}
