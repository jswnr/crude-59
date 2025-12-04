#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "hardware/gpio.h"
#include "class/hid/hid.h"

#define N_PINS 5
static const uint8_t keys[N_PINS] = {
    HID_KEY_L,
    HID_KEY_S,
    HID_KEY_SHIFT_LEFT,
    HID_KEY_CAPS_LOCK,
    HID_KEY_ENTER
};

void kbd_init(void);
bool kbd_update(uint8_t *keycodes);

#endif // KEYBOARD_H
