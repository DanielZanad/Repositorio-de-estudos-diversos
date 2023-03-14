#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

int main()
{
    std::cout << std::fixed << std::setprecision(5);

    double a, b, result = 0;
    cin >> a ;
    cin >> b ;
    
    result = (a * 3.5  + b * 7.5) / 11;
    cout << "MEDIA = " << result;

    return 0;
}