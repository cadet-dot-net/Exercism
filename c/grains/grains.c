#include "grains.h"
#include <math.h>

uint64_t square(uint8_t index) {
    if (index <= 64) {
        return pow(2, index - 1);
    }
    return 0;
}

uint64_t total(void) {
    int sum = 0;
    
    for (uint8_t i = 0; i < 64; i++) {
        sum += square(i);
    }
    return sum;
}
