#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

int main(){
    std::cout << std::fixed << std::setprecision(2);
    int n, h = 0;
    double salary = 0;
    cin >> n;
    cin >> h;
    cin >> salary;
    
    cout << "NUMBER = " << n << "\n";
    cout << "SALARY = U$ " << salary * h << "\n";



}