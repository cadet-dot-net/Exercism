#include "queen_attack.h"

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
    bool is_same_pos = queen_1.column == queen_2.column && queen_1.row == queen_2.row;
    
    if (is_same_pos || !queen_on_board(queen_1) || !queen_on_board(queen_2)) {
        return INVALID_POSITION;
    }
    
    // difference in q1.col and q2.col should be equal to
    // difference in q1.row and q2.row, if they're on a diagonal
    bool is_on_dia = abs(queen_1.column - queen_2.column) == abs(queen_1.row - queen_2.row);
    bool is_on_col = queen_1.column == queen_2.column;
    bool is_on_row = queen_1.row == queen_2.row;
    
    return is_on_dia || is_on_col || is_on_row ? CAN_ATTACK : CAN_NOT_ATTACK;
}

bool queen_on_board(position_t queen) {
    return queen.row < 8 && queen.column < 8;
}
