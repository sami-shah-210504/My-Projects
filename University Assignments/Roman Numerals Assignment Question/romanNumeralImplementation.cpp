#include <iostream>
#include <cstring>
using namespace std;

class romanNumber {
private:
    int value;
    //Private function, returns the values the Roman numerals represent
    int toInt(char symbol) {
        if (symbol == 'I')  return 1;
        else if (symbol == 'V')  return 5;
        else if (symbol == 'X')  return 10;
        else if (symbol == 'L')  return 50;
        else if (symbol == 'C')  return 100;
        else if (symbol == 'D')  return 500;
        else if (symbol == 'M')  return 1000;
        else return 0;
    }
public:
    //Constructors
    romanNumber(int num) {
        value = num;
    }
    romanNumber(const char* s) {
        int lastVal = 0;
        int total = 0;
        for (int i = 0; i < strlen(s); ++i) {
            int currentVal = toInt(s[i]);
            if (lastVal > 0 && lastVal < currentVal) { //To account for a subtractive pair
                total -= lastVal * 2;
            }
            total += currentVal;
            lastVal = currentVal;
        }
        value = total;
        if (s[0] == '-') //Reassigns value to negative if negative sign is found in the beginning of the string
        {
            value = 0 - value;
        }
    }

    //Functions
    int getValue() const {
        return value;
    }
    char* toString() const {
        char* result;
        int val = value;
        int index = 0;
        if (value < 0) //Resizes resultant string to account for negative sign
        {
            val = -val;
            result = new char[11];
            *(result + index++) = '-';
        }
        else result = new char[10];

        while (val > 0) {
            if (val >= 1000)
            {
                *(result + index++) = 'M';
                val -= 1000;
            }
            else if (val >= 900)
            {
                *(result + index++) = 'C';
                *(result + index++) = 'M';
                val -= 900;
            }
            else if (val >= 500)
            {
                *(result + index++) = 'D';
                val -= 500;
            }
            else if (val >= 400)
            {
                *(result + index++) = 'C';
                *(result + index++) = 'D';
                val -= 400;
            }
            else if (val >= 100)
            {
                *(result + index++) = 'C';
                val -= 100;
            }
            else if (val >= 90)
            {
                *(result + index++) = 'X';
                *(result + index++) = 'C';
                val -= 90;
            }
            else if (val >= 50)
            {
                *(result + index++) = 'L';
                val -= 50;
            }
            else if (val >= 40)
            {
                *(result + index++) = 'X';
                *(result + index++) = 'L';
                val -= 40;
            }
            else if (val >= 10)
            {
                *(result + index++) = 'X';
                val -= 10;
            }
            else if (val >= 9)
            {
                *(result + index++) = 'I';
                *(result + index++) = 'X';
                val -= 9;
            }
            else if (val >= 5)
            {
                *(result + index++) = 'V';
                val -= 5;
            }
            else if (val >= 4)
            {
                *(result + index++) = 'I';
                *(result + index++) = 'V';
                val -= 4;
            }
            else
            {
                *(result + index++) = 'I';
                val -= 1;
            }
        }
        *(result + index) = '\0';
        return result;
    }

    //Operators
    romanNumber operator+(const romanNumber& other) const {
        return romanNumber(value + other.value);
    }
    romanNumber operator-(const romanNumber& other) const {
        return romanNumber(value - other.value);
    }
    romanNumber operator*(const romanNumber& other) const {
        return romanNumber(value * other.value);
    }
    romanNumber operator/(const romanNumber& other) const {
        return romanNumber(value / other.value);
    }
    bool operator==(const romanNumber& other) const {
        return value == other.value;
    }
    bool operator!=(const romanNumber& other) const {
        return value != other.value;
    }
    bool operator<(const romanNumber& other) const {
        return value < other.value;
    }
    bool operator>(const romanNumber& other) const {
        return value > other.value;
    }
    romanNumber& operator++() { //Pre-Increment
        ++value;
        return *this;
    }
    romanNumber operator++(int) { //Post-Increment
        romanNumber temp(*this);
        ++value;
        return temp;
    }
    romanNumber& operator--() { //Pre-Decrement
        --value;
        return *this;
    }
    romanNumber operator--(int) { //Post-Decrement
        romanNumber temp(*this);
        --value;
        return temp;
    }
    friend ostream& operator<<(ostream& out, const romanNumber& romanNum) {
        out << romanNum.toString();
        return out;
    }
};

int main() {
    int n1, n2;
    cout << "Enter two numbers to get their respective Roman values: " << endl;
    cin >> n1 >> n2;

    romanNumber r1(n1);
    romanNumber r2(n2);

    romanNumber sum = r1 + r2;
    romanNumber difference = r1 - r2;
    romanNumber product = r1 * r2;
    romanNumber quotient = r1 / r2;
    cout << n1 << " in Roman: " << r1 << endl;
    cout << n2 << " in Roman: " << r2 << endl << endl;
    cout << "(" << n1 << ") + (" << n2 << ") =  " << n1 + n2 << ", in Roman: " << sum << endl;
    cout << "(" << n1 << ") - (" << n2 << ") = " << n1 - n2 << ", in Roman: " << difference << endl;
    cout << "(" << n1 << ") * (" << n2 << ") = " << n1 * n2 << ", in Roman: " << product << endl;
    cout << "(" << n1 << ") / (" << n2 << ") = " << n1 / n2 << ", in Roman: " << quotient << endl;
