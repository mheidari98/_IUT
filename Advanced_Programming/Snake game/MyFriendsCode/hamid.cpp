#include<iostream>
#include<windows.h>
#include<conio.h>
#include<queue>
#include<time.h>
using namespace std;
#define up 72 
#define down  80
#define right 77
#define left 75

bool isKeyPressed(int &key){
	if (_kbhit()){
		if (_getch() != 224)
		{
			return false;
		}
		key = _getch();
		return true;
	}
	return false;
}

class Display
{
public:
	Display(int height, int width)
	{
		this->height = height;
		this->width = width;
		screenPixel = new int *[height];
		for (int i = 0; i < height; i++)
			screenPixel[i] = new int[width];
		
		for (int i = 0; i < height; i++)
		for (int j = 0; j < width; j++)
			screenPixel[i][j] = 0;
	}
	void refresh()
	{
		system("cls");
		for (int j = 0; j < height; j++)
		{
			for (int i = 0; i < width; i++)
			{
				if (j == 0 || j == height-1)
					printf("-");
				
				else if (i == 0 || i == width-1)
					printf("|");

				else if (screenPixel[j][i] == 1)	// snake
					printf("*");

				else if (screenPixel[j][i] == 2)	// snakes head
					printf("O");
				else if (screenPixel[j][i] == 3)	// food
					printf("+");

				else
					printf(" ");
			}

			printf("\n");
		}
		//printf("\n%s","Score: ");

	}
	char setChar(int pos_x, int pos_y, char newChar)
	{
		if (newChar == 3)	// if newChar is food
			if (screenPixel[pos_y][pos_x] != 0)		// If position isn't empty
				return 1;

		if (pos_x >= width - 1 || pos_y >= height - 1 || pos_x == 0 || pos_y == 0)
			return 4;	
		int oldChar = screenPixel[pos_y][pos_x];
		screenPixel[pos_y][pos_x] = newChar;
		return oldChar;
	}
	int getWidth()
	{
		return width;
	}
	int getHeight()
	{
		return height;
	}
private:
	int **screenPixel;
	int height, width;
};

class Snake
{
public:
	void tailMovement(int breakPoint_x,int breakPoint_y)
	{
		if (tail_x < breakPoint_x)
			screenptr->setChar(tail_x++, tail_y, 0);
		else if (tail_x > breakPoint_x)
			screenptr->setChar(tail_x--, tail_y, 0);
		else if (tail_y < breakPoint_y)
			screenptr->setChar(tail_x, tail_y++, 0);
		else if (tail_y > breakPoint_y)
			screenptr->setChar(tail_x, tail_y--, 0);
	}

	void tailGrowth(int breakPoint_x, int breakPoint_y)
	{
		if (tail_x < breakPoint_x)
			tail_x--;
		else if (tail_x > breakPoint_x)
			tail_x++;
		else if (tail_y < breakPoint_y)
			tail_y--;
		else if (tail_y > breakPoint_y)
			tail_y++;
	}
	int keepGoing()
	{
		screenptr->setChar(head_x, head_y, 1);

		if (movementDirection == right)
			head_x++;
		if (movementDirection == left)
			head_x--;
		if (movementDirection == up)
			head_y--;
		if (movementDirection == down)
			head_y++;

		int i = screenptr->setChar(head_x, head_y, 2);
		if (i == 3)
		{
			while (screenptr->setChar(rand() % (screenptr->getWidth()-1) + 1, rand() % (screenptr->getHeight()-1) + 1, 3) != 0);
			if (breaks_x.size() == 0)
				tailGrowth(head_x, head_y);
			else
				tailGrowth(breaks_x.front(), breaks_y.front());

		}
		if (i == 1 || i == 4)
			return 0;

		if (breaks_x.size() == 0)
			tailMovement(head_x, head_y);
		else
			tailMovement(breaks_x.front(), breaks_y.front());
		return 1;
	}
	void turned()
	{
		breaks_x.push(head_x);
		breaks_y.push(head_y);
	}
	int head_x, head_y;
	int tail_x, tail_y;
	Display *screenptr;
	queue <int> breaks_x;
	queue <int> breaks_y;
	int movementDirection;
};

int main()
{
	srand(time(0));
	int w = up, s = down, a = left, d = right;
	Snake snake;
	int height = 20, width = 25;
	//cout << "Enter width: ";
	//cin >> width;
	//cout << "Enter height: ";
	//cin >> height;
	Display screen(height, width);
	for (int i = 5; i < 9; i++)
		screen.setChar(i, 6, 1);
	
	snake.head_x = 8;
	snake.head_y = 6;
	snake.tail_x = 5;
	snake.tail_y = 6;
	screen.setChar(2, 2, 3);
	snake.movementDirection = right;

	snake.screenptr = &screen;
	while (1)
	{
		if (snake.breaks_x.size() != 0 && snake.tail_x == snake.breaks_x.front() && snake.tail_y == snake.breaks_y.front())
		{
			snake.breaks_x.pop();
			snake.breaks_y.pop();
		}
		int key;
		if (isKeyPressed(key))
		{
			if ((key == up || key == down) && (snake.movementDirection == left || snake.movementDirection == right))
			{
				snake.turned();
				snake.movementDirection = key;
			}
			if ((key == left || key == right)  && (snake.movementDirection == up || snake.movementDirection == down))
			{
				snake.turned();
				snake.movementDirection = key;
			}
		}
		Sleep(3500/(height+width));
		if (snake.keepGoing() == 0)
			break;
		screen.refresh();
	}
	Sleep(500);
	system("cls");
	cout << "\n\n\n\n\n\t\t\t\tYou Lost!\n\n\n\n";
	return 0;
}