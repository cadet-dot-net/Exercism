/**
 * This stub is provided to make it straightforward to get started.
 */

export function twoFer(name?: string): string {
    if (typeof name == 'undefined') {
        return "One for you, one for me.";
    }
    return "One for "+name+", one for me.";
};