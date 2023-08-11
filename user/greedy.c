#include "user.h"

#define WIDTH 20
#define HEIGHT 10

int snakeX[WIDTH * HEIGHT];
int snakeY[WIDTH * HEIGHT];
int snakeLength;
int foodX, foodY;
int directionX, directionY;
int gameover;

void initGame()
{
    snakeLength = 1;
    snakeX[0] = WIDTH / 2;
    snakeY[0] = HEIGHT / 2;
    foodX = 125 % WIDTH;
    foodY = 63 % HEIGHT;
    directionX = 1;
    directionY = 0;
    gameover = 0;
}

void updateGame()
{
    int newSnakeX = snakeX[0] + directionX;
    int newSnakeY = snakeY[0] + directionY;

    if (newSnakeX == foodX && newSnakeY == foodY)
    {
        snakeLength++;
        foodX = 210 % WIDTH;
        foodY = 320 % HEIGHT;
    }

    for (int i = snakeLength - 1; i > 0; i--)
    {
        snakeX[i] = snakeX[i - 1];
        snakeY[i] = snakeY[i - 1];
    }

    snakeX[0] = newSnakeX;
    snakeY[0] = newSnakeY;

    if (snakeX[0] < 0 || snakeX[0] >= WIDTH || snakeY[0] < 0 || snakeY[0] >= HEIGHT)
    {
        gameover = 1;
        return;
    }

    for (int i = 1; i < snakeLength; i++)
    {
        if (snakeX[i] == snakeX[0] && snakeY[i] == snakeY[0])
        {
            gameover = 1;
            return;
        }
    }
    // 延迟一段时间
    sleep(50); // 1 秒的延迟
}

void renderGame()
{
    // system("cls");
    for (int y = 0; y < HEIGHT; y++)
    {
        for (int x = 0; x < WIDTH; x++)
        {
            if (x == snakeX[0] && y == snakeY[0])
            {
                printf("O");
            }
            else if (x == foodX && y == foodY)
            {
                printf("*");
            }
            else
            {
                int isPrinted = 0;
                for (int i = 1; i < snakeLength; i++)
                {
                    if (x == snakeX[i] && y == snakeY[i])
                    {
                        printf("o");
                        isPrinted = 1;
                        break;
                    }
                }
                if (!isPrinted)
                {
                    printf(" ");
                }
            }
        }
        printf("\n");
    }
}

int main()
{
    initGame();

    while (!gameover)
    {
        char ch = read(0, &ch, 1);
        if (ch == 'w' && directionY == 0)
        {
            directionX = 0;
            directionY = -1;
        }
        else if (ch == 's' && directionY == 0)
        {
            directionX = 0;
            directionY = 1;
        }
        else if (ch == 'a' && directionX == 0)
        {
            directionX = -1;
            directionY = 0;
        }
        else if (ch == 'd' && directionX == 0)
        {
            directionX = 1;
            directionY = 0;
        }

        updateGame();
        renderGame();

        // 控制游戏速度
        for (int i = 0; i < 10000000; i++)
            ;
    }

    printf("Game Over!\n");
    return 0;
}
