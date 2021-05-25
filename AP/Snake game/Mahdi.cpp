#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <Windows.h>
#include <conio.h>
#include<time.h>


int i, j;

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

void setTextColor(int textColor, int backColor = 0)
{
	HANDLE consoleHandle = GetStdHandle(STD_OUTPUT_HANDLE);
	int colorAttribute = backColor << 4 | textColor;
	SetConsoleTextAttribute(consoleHandle, colorAttribute);
}


class position
{
public:
	int x;
	int y;
};
class display
{
public:

	void show(int a[][80], int score , char name[])
	{
		system("cls");
		printf("player : %s", name);
		cout << "\t" << "score : " << score << endl;
		for (i = 0; i < 20; i++)
		{
			for (j = 0; j < 80; j++)
			{
				if (i == 0 || j == 0 || i == 19 || j == 79)
				{
					setTextColor(0, 10);
					printf(" ");
					setTextColor(10, 0);

				}
				else if (a[i][j] == 2)
				{
					setTextColor(14, 0);
					printf("@");
				}
				else if (a[i][j] == 1)
				{
					setTextColor(0, 7);
					printf(" ");
					setTextColor(7,0);
				}
				else if (a[i][j] == 5)
				{
					setTextColor(14, 0);
					printf("*");
					setTextColor(5, 0);
				}
				else
					printf(" ");
			}
			printf("\n");
		}
	}

};

class snake
{
public:
	snake(char player[])
	{
		score = 0;
		len = 4;
		strcpy(name, player);
		for (i = 0; i < 20; i++)
			for (j = 0; j < 80; j++)
				a[i][j] = 0;

		a[10][25] = 2;
		a[10][26] = 1;
		a[10][27] = 1;
		a[10][28] = 1;
		head.x = 10;
		head.y = 25;
		position[0].x = 10;
		position[0].y = 25;
		position[1].x = 10;
		position[1].y = 26;
		position[2].x = 10;
		position[2].y = 27;
		position[3].x = 10;
		position[3].y = 28;
		set_food();
		display.show(a, score, name);
	}
	~snake()
	{
		system("cls");
		setTextColor(10, 0);
		cout << "\n\n\t\tYOU LOSE\n\t\t YOUR SCORE IS : " << score << "\n\t\tplease any key to continue\t";
		getch();
	}
	bool check(int &fm)
	{
		if (head.x == 0 || head.x == 19 || head.y == 0 || head.y == 79)
			return 0;

		for (i = 1; i < len; i++)
			if (head.x == position[i].x && head.y == position[i].y)
				return 0;
		if (head.x == food.x && head.y == food.y)
		{
			score++;
			len++;
			fm++;
			set_food();
		}

		return 1;
	}

	void go(int x, bool &repeat)
	{
		switch (x)
		{
		case 1:
			a[head.x][head.y] = 1;
			a[--head.x][head.y] = 2;
			break;
		case 2:
			a[head.x][head.y] = 1;
			a[++head.x][head.y] = 2;
			break;
		case 3:
			a[head.x][head.y] = 1;
			a[head.x][++head.y] = 2;
			break;
		case 4:
			a[head.x][head.y] = 1;
			a[head.x][--head.y] = 2;
			break;
		}
		if (fm == 1)
		{
			a[position[0].x][position[0].y] = 1;
			for (i = len; i; i--)
			{
				position[i].x = position[i - 1].x;
				position[i].y = position[i - 1].y;
			}
			fm = 0;
		}
		else
		{
			for (i = 1; i < len - 1; i++)
				a[position[i].x][position[i].y] = 1;

			a[position[i].x][position[i].y] = 0;

			for (i = len - 1; i; i--)
			{
				position[i].x = position[i - 1].x;
				position[i].y = position[i - 1].y;
			}
		}

		position[0].x = head.x;
		position[0].y = head.y;

		if (check(fm) == 0)
			repeat = false;
		display.show(a,score,name);
	}
	
	void set_food()
	{
		food.x = rand() % (18) + 1;
		food.y = rand() % (78) + 1;
		//while (food.x == 0 || food.y == 0 || food.x == 19 || food.y == 79)
		//{
		//	if (food.x == 0 || food.x == 19)
		//		food.x = rand() % (20);
		//	if (food.y == 0 || food.y == 79)
		//		food.y = rand() % (80);
		//}
		while (a[food.x][food.y] != 0)
		{
			food.x = rand() % (18) + 1;
			food.y = rand() % (78) + 1;
		}
			a[food.x][food.y] = 5;
	}

	int score, len, fm = 0;
	int a[20][80];
	position position[50], head,food;
	display display;
	char name[50];
};

void f(int x)
{
	if (x == 0)
	{
		system("cls");
		setTextColor(10, 0);
		cout << "\t=>";
		setTextColor(14, 0);
		cout << " 1.play again\n";
		cout << "\t   2.Exit\n";
	}
	if (x == 1)
	{
		system("cls");
		cout << "\t   1.play again\n";
		setTextColor(10, 0);
		cout << "\t=>";
		setTextColor(14, 0);
		cout << " 2.Exit\n";
	}
}
int main()
{
	srand(time(0));
	char player[50];
	cout << "welcome player \n\nplease enter your name : ";
	gets(player);
	snake *Snake = new snake(player);
	char c;
	int x = 4, mj=50;
	bool repeat = true;
	while (repeat)
	{
		Sleep(mj- (2*(*Snake).score));

		if (kbhit())
		{
			char ch = getch();
			switch (ch){
			case 72:
				if (x != 2)
					x = 1;
				break;
			case 80:
				if (x != 1)
					x = 2;
				break;
			case 77:
				if (x!=4)
					x = 3;
				break;
			case 75:
				if (x != 3)
					x = 4;
				break;
			}
		}
		Snake->go(x,repeat);
	}
	delete Snake;

		int y = 0;
		repeat = true;
		f(y);
		while (repeat)
		{
			if (kbhit())
			{
				char ch = getch();
				if (ch == 72)
				{
					y--;
					f(y % 2);
				}
				else if (ch == 80)
				{
					y++;
					f(y % 2);
				}
				else if (ch == 77)
				{
					if (y % 2)
						repeat = false;
					else
					{
						system("cls");
						cout << "welcome player \n\nplease enter your name : ";
						scanf("%s", player);
						snake *Snake = new snake(player);
						x = 4, mj = 50;
						bool repeet = true;
						while (repeet)
						{
							Sleep(mj - (2 * (*Snake).score));

							if (kbhit())
							{
								char ch = getch();
								switch (ch){
								case 72:
									if (x != 2)
										x = 1;
									break;
								case 80:
									if (x != 1)
										x = 2;
									break;
								case 77:
									if (x != 4)
										x = 3;
									break;
								case 75:
									if (x != 3)
										x = 4;
									break;
								}
							}
							Snake->go(x, repeet);
						}
						delete Snake;
						f(y % 2);
					}
				}
			}
		}

	return 0;
}