#include "darts.h"

int score(coordinate_t dart) {
    float x = dart.x, y = dart.y;
    // pythagoras to find length of distance from origin to dart
    double distance = sqrt((x * x) + (y * y));
    
    if (distance >= 0 && distance <= 1) {
        return 10;
    } else if (distance > 1 && distance <= 5) {
        return 5;
    } else if (distance > 5 && distance <= MAX_POINT) {
        return 1;
    }
    return 0;
}
