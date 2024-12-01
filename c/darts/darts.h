#ifndef DARTS_H
#define DARTS_H

#include <math.h>

#define MAX_POINT 10

typedef struct {
    float x;
    float y;
} coordinate_t;

int score(coordinate_t dart);

#endif
