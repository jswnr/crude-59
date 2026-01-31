/*
 * Copyright © 2026 Jakub Świniarski
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "layout.h"

static const uint8_t col_to_gpio[N_COLS] = { 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 15, 18 };
static const uint8_t row_to_gpio[N_ROWS] = { 16, 17, 13, 7, 0 };

void kbd_init(void);
bool kbd_update(uint8_t *keycodes);

#endif // KEYBOARD_H
