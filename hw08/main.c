#include "main.h"

#include <stdio.h>
#include <stdlib.h>
#include "gba.h"
#include "images/beginning.h"
#include "images/rapunzel.h"
#include "images/pan.h"
#include "images/mother.h"
#include "images/scarymen.h"
#include "images/blacksquare.h"
#include "images/flynn.h"
#include "images/handcuffs.h"
#include "images/loser.h"
#include "images/end.h"
#include "images/rapunzel2.h"


enum gba_state {
  START,
  PLAY,
  WIN,
  LOSE,
};

void delay(int n) {
  volatile int x = 0;
  for (int i=0; i<n*8000; i++)
    x++;
}

int main(void) {
  /* TODO: */
    // Manipulate REG_DISPCNT here to set Mode 3. //
  REG_DISPCNT = MODE3 | BG2_ENABLE;

  struct obstacles obstacles[7] = {
    {20, 10, 0, 0, 2},
    {70, 20, 0, 0, 1},
    {100, 190, 0, 0, 3},
    {120, 80, 0, 0, 2},
    {70, 200, 0, 0, 3},
    {120, 150, 0, 0, 1},
    {60, 60, 0, 0, 2},
  };
  int oblen = sizeof(obstacles) / sizeof(obstacles[0]);
  for (int i = 0; i < oblen; i++) {
    if (obstacles[i].type == 1) {
      obstacles[i].height = PAN_HEIGHT;
      obstacles[i].width = PAN_WIDTH;
    } else if (obstacles[i].type == 2) {
      obstacles[i].height = MOTHER_HEIGHT;
      obstacles[i].width = MOTHER_WIDTH;
    } else if (obstacles[i].type == 3) {
      obstacles[i].height = SCARYMEN_HEIGHT;
      obstacles[i].width = SCARYMEN_WIDTH;
    }
  }
  struct rapunzel p = {148, 110, RAPUNZEL_HEIGHT, RAPUNZEL_WIDTH, 2, 2};
  struct flynn goal = {0, 80, FLYNN_WIDTH, FLYNN_HEIGHT};
  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;
  // Load initial application state
  enum gba_state state = START;
  unsigned int count = 0;

  while (1) {
    currentButtons = BUTTONS;
    switch (state) {
      case START:
        p.row = 148;
        p.col = 110;
        p.height = RAPUNZEL_HEIGHT;
        p.width = RAPUNZEL_WIDTH;
        p.uvel = 2;
        p.hvel = 2;

        waitForVBlank();
        if (count == 0) {
          drawFullScreenImageDMA(beginning);
          drawImageDMA(20, 80, RAPUNZEL2_WIDTH, RAPUNZEL2_HEIGHT, rapunzel2);
        }
        drawCenteredString(120, 120, 0, 0, "Help Rapunzel get to Flynn!", 0xFFFF);
        drawCenteredString(140, 120, 0, 0, "(Press START to continue)", 0xFFFF);
        if (KEY_DOWN(BUTTON_START, currentButtons)) {
          state = PLAY;
          vBlankCounter = 0;
          count = 0;
          previousButtons = BUTTONS;
          break;
        }
        previousButtons = BUTTONS;
        count++;
        break;
      case PLAY:
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = START;
          count = 0;
          previousButtons = BUTTONS;
          break;
        }
        int prevrow = p.row;
        int prevcol = p.col;
        if (KEY_DOWN(BUTTON_UP, currentButtons)) {
          p.row -= p.uvel;
          if (p.row < 0) {
            p.row = 0;
          }
        }
        if (KEY_DOWN(BUTTON_DOWN, currentButtons)) {
          p.row += p.uvel;
          if (p.row > HEIGHT - p.height) {
            p.row = HEIGHT - p.height;
          }
        }
        if (KEY_DOWN(BUTTON_LEFT, currentButtons)) {
          p.col -= p.hvel;
          if (p.col < 0) {
            p.col = 0;
          }
        }
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons)) {
          p.col += p.hvel;
          if (p.col > WIDTH - p.width) {
            p.col = WIDTH - p.width;
          }
        }
        if ((SCORE_COL <= p.col + p.width && SCORE_COL + 60 - 1 >= p.col) && (SCORE_ROW <= p.row + p.height && SCORE_ROW + 10 - 1 >= p.row)) {
          p.col = prevcol;
          p.row = prevrow;
        }
        int collided = 0;
        for (int i = 0; i < oblen; i++) {
          if ((obstacles[i].col + 1 <= p.col + p.width && obstacles[i].col + obstacles[i].width - 1 >= p.col)
          && (obstacles[i].row + 1 <= p.row + p.height && obstacles[i].row + obstacles[i].height - 1 >= p.row)) {
            waitForVBlank();
            delay(10);
            state = LOSE;
            count = 0;
            previousButtons = BUTTONS;
            collided = 1;
            break;
          }
        }
        if ((goal.col + 2 <= p.col + p.width && goal.col + goal.width - 2 >= p.col)
          && (goal.row <= p.row + p.height && goal.row + goal.height - 2 >= p.row)) {
            delay(10);
            state = WIN;
            count = 0;
            previousButtons = BUTTONS;
            collided = 1;
            break;
          }
        if (collided) {
          break;
        }
        char buffer[50];
        int time = vBlankCounter / 6;
        sprintf(buffer, "Score: %d", time);
        waitForVBlank();
        if (count == 0) {
          fillScreenDMA(BLACK);
          for (int i = 0; i < oblen; i++) {
            if (obstacles[i].type == 1) {
              drawImageDMA(obstacles[i].row, obstacles[i].col, obstacles[i].width, obstacles[i].height, pan);
            } else if (obstacles[i].type == 2) {
              drawImageDMA(obstacles[i].row, obstacles[i].col, obstacles[i].width, obstacles[i].height, mother);
            } else if (obstacles[i].type == 3) {
              drawImageDMA(obstacles[i].row, obstacles[i].col, obstacles[i].width, obstacles[i].height, scarymen);
            }
          }
          drawImageDMA(goal.row, goal.col, goal.width, goal.height, flynn);
        } else {
          undrawImageDMA(prevrow, prevcol, p.width, p.height, blacksquare);
          drawImageDMA(p.row, p.col, p.width, p.height, rapunzel);
          undrawImageDMA(10, 180, 60, 10, blacksquare);
          drawString(10, 180, buffer, 0xFFFF);
        }
        count++;
        previousButtons = BUTTONS;
        break;
      case WIN:
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = START;
          count = 0;
          previousButtons = BUTTONS;
          break;
        }
        waitForVBlank();
        if (count == 0) {
          drawFullScreenImageDMA(end);
        } else {
          sprintf(buffer, "Final Score: %d", time);
          drawString(30, 20, "Congrats on your happily ever after!", 0xFFFF);
          drawString(50, 130, buffer, 0xFFFF);
        }
        count++;
        break;
      case LOSE:
        if (KEY_DOWN(BUTTON_SELECT, currentButtons)) {
          state = START;
          count = 0;
          previousButtons = BUTTONS;
          break;
        }
        waitForVBlank();
        if (count == 0) {
          drawFullScreenImageDMA(loser);
        } else {
          drawCenteredString(120, 120, 0, 0, "You got caught :(", 0xFFFF);
        }
        count++;
        break;
    }
    previousButtons = currentButtons; // Store the current state of the buttons
  }
  UNUSED(previousButtons);
  return 0;
}
