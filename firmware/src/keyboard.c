#include "keyboard.h"

void kbd_init(void) {
    for (size_t i = 0; i < N_PINS; i++) {
        gpio_init(i);
        gpio_pull_up(i);
        gpio_set_dir(i, GPIO_IN);
    }
}

bool kbd_update(uint8_t *keycodes) {
    for (size_t i = 0; i < 6; i++) {
        keycodes[i] = 0;
    }

    uint8_t index = 0;
    bool changed = false;
    for (size_t i = 0; i < N_PINS; i++) {
        if (gpio_get(i) == 0) {
            keycodes[index] = keys[i];
            changed = true;
            index++;
            if (index >= 6) {
                break;
            }
        }
    }

    return changed;
}
