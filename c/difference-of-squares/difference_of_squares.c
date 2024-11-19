#include "difference_of_squares.h"

unsigned int sum_of_squares(unsigned int numbers) {
    unsigned int sum = 0;
    
    for (unsigned int i = 1; i <= numbers; i++) {
        unsigned int square = pow(i, 2);
        sum += square;
    }
    return sum;
}

unsigned int square_of_sum(unsigned int numbers) {
    unsigned int sum = 0;
    
    for (unsigned int i = 1; i <= numbers; i++) {
        sum += i;
    }
    return pow(sum, 2);
}

unsigned int difference_of_squares(unsigned int number) {
    return square_of_sum(number) - sum_of_squares(number);
}