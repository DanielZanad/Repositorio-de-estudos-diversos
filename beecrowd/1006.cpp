#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

int main()
{
    std::cout << std::fixed << std::setprecision(1);

    double a, b, c ,result = 0;
    cin >> a ;
    cin >> b ;
    cin >> c ;

    result = (a * 2  + b * 3 + c * 5) / 10;
    cout << "MEDIA = " << result << "\n";

    return 0;
}