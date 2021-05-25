#include<iostream>
#include<windows.h>
#include<conio.h>
#include<ctime>
#include <vector>
using namespace std;
#define up 72 
#define down  80
#define right 77
#define left 75
#define M 6
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
void gotoxy(int y, int x)
{
	static HANDLE h = NULL;
	if (!h)
		h = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD c = { x, y };
	SetConsoleCursorPosition(h, c);
}
class Game{
public:
	Game(int x, int y, int l) :x(x), y(y)
	{
		for (int i = M - 1; i < x + M - 1; i++)
		{
			for (int j = M - 1; j < y + M - 1; j++)
			{
				if (i == M - 1 || j == M - 1 || j == y + M - 2 || i == x + M - 2)
				{
					gotoxy(i, j);
					cout << '.';
				}

			}
		}
	}
	void food()
	{
		srand(time(NULL));
		x1 = rand() % (x - 2) + 6;
		y1 = rand() % (y - 2) + 6;
		gotoxy(x1, y1);
		cout << '*';
	}
protected:
	int x, y, l, x1, y1;

	//private:


};
class Snake :public Game{
public:
	Snake(int x, int y, int L) :Game(x, y, l){
		l = L;
		sn = new int*[l];
		int j, i;
		for (i = 0, j = 6; j<6 + l && i < l; j++)
		{
			sn[i] = new int[2];
			sn[i][0] = 6;
			sn[i][1] = j;
			i++;
		}
		first[0] = 6;
		first[1] = 6;
		last[0] = 6;
		last[1] = 5 + l;
		for (int k = 6; k < l + 5; k++)
		{
			gotoxy(6, k);
			cout << 'O';
		}
		gotoxy(6, l + 5);
		cout << ':';
	}
	int Check()
	{
		for (int k = 0; k < l - 1; k++)
		{
			if (last[0] == sn[k][0] && last[1] == sn[k][1])
			{				
				return 0;
			}

		}
		if ((last[0] == 5 && jahat == 1) || (last[1] == 5 + y && jahat == 4) || (last[1] == 5 && jahat == 3) || (last[0] == 5 + x && jahat == 2))
		{			
			
			return 0;
		}
	}

	void jelo(){
		first1[0] = first[0];
		first1[1] = first[1];
		if (lengthimp == 0)
		{
			for (int i = 0; i < l - 1; i++)
			{
				if (i == 0)
				{
					gotoxy(sn[i][0], sn[i][1]);
					cout << ' ';
				}
				sn[i][0] = sn[i + 1][0];
				sn[i][1] = sn[i + 1][1];
				gotoxy(sn[i + 1][0], sn[i + 1][1]);
				cout << 'O';
			}
			sn[l - 1][0] = last[0];
			sn[l - 1][1] = last[1];
			gotoxy(last[0], last[1]);
			cout << ':';
			first[0] = sn[0][0];
			first[1] = sn[0][1];
		}
		else{
			lengthimp--;
			switch (jahat)
			{
			case 1:
				sn[l - 1][0] = sn[l - 2][0] - 1;
				sn[l - 1][1] = sn[l - 2][1];
				last[0]=sn[l-1][0];
				gotoxy(sn[l - 2][0], sn[l - 2][1]);
				cout << 'O';
				gotoxy(sn[l - 1][0], sn[l - 1][1]);
				cout << ':';	
				break;
			case 2:
				sn[l - 1][0] = sn[l - 2][0] + 1;
				sn[l - 1][1] = sn[l - 2][1];
				last[0] = sn[l - 1][0];
				gotoxy(sn[l - 2][0], sn[l - 2][1]);
				cout << 'O';
				gotoxy(sn[l - 1][0], sn[l - 1][1]);
				cout << ':';
				break;
			case 3:
				sn[l - 1][0] = sn[l - 2][0] ;
				sn[l - 1][1] = sn[l - 2][1]-1;
				last[1] = sn[l - 1][1];
				gotoxy(sn[l - 2][0], sn[l - 2][1]);
				cout << 'O';
				gotoxy(sn[l - 1][0], sn[l - 1][1]);
				cout << ':';
				break;
			case 4:
				sn[l - 1][0] = sn[l - 2][0];
				sn[l - 1][1] = sn[l - 2][1] + 1;
				last[1] = sn[l - 1][1];
				gotoxy(sn[l - 2][0], sn[l - 2][1]);
				cout << 'O';
				gotoxy(sn[l - 1][0], sn[l - 1][1]);
				cout << ':';
				break;
			}
		}
		
	}
	void FWCkeck(){
		if (last[0] == x1 && last[1] == y1)
		{
			score++;
			system("color A");
			Sleep(100);
			system("color 7");

			int**sn1;
			sn1 = new int*[l];
			for (int i = 0; i < l; i++)
			{			
			sn1[i] = new int[2];
			for (int j = 0; j < 2; j++)
			{

			sn1[i][j] = sn[i][j];
			}			
			}
			sn1[l] = new int[2];
			delete sn;
			l++;
			sn = new int*[l];
			for (int i = 0; i < l; i++)
			{
			sn[i] = new int[2];
			for (int j = 0; j < 2; j++)
			{

			sn[i][j] = sn1[i][j];

			}
			//cout << "hi";
			}
			lengthimp++;
			food();
		}

		Check();
		//if (last[0] == 5 && jahat == 1)
	}
	void update(){

		switch (jahat)
		{
		case 1:
			//system("color 7");
			last[0]--;
			FWCkeck();
			jelo();
			
			break;
		case 2:
			//system("color 6");
			last[0]++;
			FWCkeck();
			jelo();
			
			break;
		case 3:
			//system("color 8");
			last[1]--;
			FWCkeck();
			jelo();
			
			break;
		case 4:
			//system("color 4");
			last[1]++;
			FWCkeck();
			jelo();
			

			break;
		}
	}
	void Up(){
		jahat = 1;
	}
	void Down(){
		jahat = 2;
	}
	void Left()
	{
		jahat = 3;
	}
	void Right()
	{
		jahat = 4;
	}
	int Score(){
		return score;
	}
private:
	int l, score = 0;
	int jahat = 4;
	int**sn;
	int first[2], last[2], first1[2];
	int lengthimp = 0;
};


int main()
{
	int a, b, c;
	cout << "please insert " << "\nlength:";
	cin >> a;
	cout << "\nheight:";
	cin >> b;
	cout << "\nsnakelength:";
	cin >> c;
	system("cls");
	int score1=0;
	Snake s(a, b,c);
	s.food();
	bool repeat = true;
	int time = 500;
	while (repeat)
	{

		if (s.Check()){
			Sleep(time);
			if (kbhit())
			{
				char ch = getch();
				switch (ch)
				{
				case up:
					s.Up();
					break;
				case down:
					s.Down();
					break;
				case left:
					s.Left();
					break;
				case right:
					s.Right();
					break;
				case 32:
					repeat = false;
					break;
				}

			}
			s.update();
			if (time > 100 && score1 != s.Score())
			{
			time -= (s.Score() * 10);
			score1 = s.Score();
			}
				
		}

		else
		{
			repeat = false;
			system("cls");
			gotoxy(10, 20);
			system("color 57");
			cout << "\t\t\tGame Ovre :(( \n\n\t\t\t\tyour score:\t" << s.Score()<<"\t\t\t\n\n";
		}


	}
}
