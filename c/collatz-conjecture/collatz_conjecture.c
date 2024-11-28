#include "collatz_conjecture.h"

int steps(int start) {
    if (start == 1) { return 0; }
    if (start < 1) { return -1; }
    
    return start % 2 == 0 ? steps(start / 2) + 1 : steps((start * 3) + 1) + 1;
}
