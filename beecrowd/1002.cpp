#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

#define n 3.14159
int main()
{
    std::cout << std::fixed << std::setprecision(4);
    double raio = 0.00;

    cin >> raio;
    double area = n * pow(raio, 2);
    cout << "A=" << area;

    return 0;
}