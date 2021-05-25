#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <windows.h>
#include <conio.h>
#include<time.h>

using namespace std;

#define up 72 
#define down 80
#define right 77
#define left 75

char key;
int tail=3;
int score=0;
bool addtail=false;
bool endgame=false;

bool isKeyPressed(){
	if (_kbhit()){
		key = _getch();
		return true;
	}
	return false;
}

void delay(unsigned int mseconds)
{
    clock_t goal = mseconds + clock();
    while (goal > clock());
}

class Display
{	
	protected:
		int board [25][40];//board matris
		
	public:
		Display()
		{
			set_board ();
			feeding ();
		}
		
		void set_board ();//initial setting
		void refresh ();//print the board
		void set_set (int x , int y);
		void unset (int x , int y);
		void feeding ();
};

class Snake : public Display
{
	public:
		int turn;
		int pos_x;
		int pos_y;
		int tail_x [38];
		int tail_y [38];
		
		Snake ()
		{
			
			for (int i=0;i<38;i++)
			{
				tail_x [i]=0;
				tail_y [i]=0;
			}
			
			turn=2;//up=1 , right=2 , down=3 , left=4
			pos_x=13;
			pos_y=20;
			tail_x [0]=13;
			tail_x [1]=13;
			tail_x [2]=13;
			tail_y [0]=19;
			tail_y [1]=18;
			tail_y [2]=17;
			board [tail_x[0]][tail_y[0]]=1;
			board [tail_x[1]][tail_y[1]]=1;
			board [tail_x[2]][tail_y[2]]=1;
			board [pos_x][pos_y]=1;
			refresh ();
		}
		
		void add_tail ();
		void set_tail ();//setting tail
		void move ();//determine the moving 

};

void Display::set_board ()
{
	int i=0 , j=0;
	
	for (i=0;i<25;i++)
	{
		for (j=0;j<40;j++)
		{
			board[i][j]=0;
		}
	}
	
	for (i=0,j=0;j<40;j++)
	{
		board [i][j]=3;
	}
	
	for (i=24,j=0;j<40;j++)
	{
		board [i][j]=3;
	}
	
	for (i=0,j=0;i<25;i++)
	{
		board [i][j]=3;
	}
	
	for (j=39,i=0;i<25;i++)
	{
		board [i][j]=3;
	}
}

void Display::refresh ()
{
	int i=0 , j=0;
	
	for (i=0;i<25;i++)
	{
		for (j=0;j<40;j++)
		{
			if (board [i][j]==0)
			{
				cout<<" ";
			}
			
			else if (board [i][j]==1)
			{
				cout<<"o";
			}
			
			else if (board [i][j]==2)
			{
				cout<<".";
			}
			
			else if (board [i][j]==3)
			{
				cout<<"#";
			}
		}
		
		cout<<endl;
	}
}

void Snake::move ()
{
	if (turn==1)
	{
		if (key==up)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x--;
			set_set(pos_x,pos_y);
			turn=1;
		}
		
		else if (key==right)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y++;
			set_set(pos_x,pos_y);
			turn=2;
		}
		
		else if (key==left)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y--;
			set_set(pos_x,pos_y);
			turn=4;
		}	
	}
	
	else if (turn==2)
	{
		if (key==up)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x--;
			set_set(pos_x,pos_y);
			turn=1;
		}
		
		else if (key==right)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y++;
			set_set(pos_x,pos_y);
			turn=2;
		}
		
		else if (key==down)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x++;
			set_set(pos_x,pos_y);
			turn=3;
		}
	}
	
	else if (turn==3)
	{
		if (key==right)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y++;
			set_set(pos_x,pos_y);
			turn=2;
		}
		
		else if(key==down)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x++;
			set_set(pos_x,pos_y);
			turn=3;
		}
		
		else if (key==left)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y--;
			set_set(pos_x,pos_y);
			turn=4;
		}
	}
	
	else if (turn==4)
	{
		if (key==up)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x--;
			set_set(pos_x,pos_y);
			turn=1;
		}
		
		else if (key==down)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_x++;
			set_set(pos_x,pos_y);
			turn=3;
		}
		
		else if (key==left)
		{
			unset(pos_x,pos_y);
			set_tail ();
			pos_y--;
			set_set(pos_x,pos_y);
			turn=4;
		}
	}
}

void Display::set_set (int x , int y)
{
	if (board [x][y]==0)
	{
		board [x][y]=1;
	}
	
	else if (board [x][y]==1)
	{
		//cout<<"You Lose!!!"<<endl<<"Your score is :"<<score;
		endgame=true;
	}
	
	else if (board [x][y]==2)
	{
		board [x][y]=1;
		score++;
		tail++;
		addtail=true;
		feeding ();
	}
	
	else if (board [x][y]==3)
	{
		//cout<<"You Lose!!!"<<endl<<"Your score is :"<<score;
		endgame=true;
	}
}

void Display::feeding ()
{
	int n=0 , m=0;
	
	srand(time(NULL));
	
	while (1)
	{
		n=rand()%24+1;
		m=rand()%39+1;
		
		if (board [n][m]==0)
		{
			board [n][m]=2;
			break;
		}
	}
}

void Display::unset(int x , int y)
{
	board [x][y]=0;
}

void Snake::set_tail ()
{
	int i=0;
	int a [38];
	int b [38];
	
	if (addtail==true)
	{
		add_tail ();
	}
	
	for (i=0;i<tail-1;i++)
	{
		a[i]=tail_x[i];
		b[i]=tail_y[i];
	}

	tail_x [0]=pos_x;
	tail_y [0]=pos_y;
	
	board [tail_x[tail-1]][tail_y[tail-1]]=0;
	
	for (i=1;i<tail;i++)
	{
		tail_x [i]=a[i-1];
		tail_y [i]=b[i-1];
	}

	for (i=0;i<3;i++)
	{
		board [tail_x[i]][tail_y[i]]=1;
	}
}

void Snake::add_tail ()
{
	if (turn==1)
	{
		if (board [tail_x [tail-2]+1][tail_y [tail-2]]==0)
		{
			tail_x [tail-1]=tail_x [tail-2]+1;
			tail_y [tail-1]=tail_y [tail-2];
		}
			addtail=false;
	}
	
	else if (turn==2)
	{
		if (board [tail_x [tail-2]+1][tail_y [tail-2]]==0)
		{
			tail_x [tail-1]=tail_x [tail-2];
			tail_y [tail-1]=tail_y [tail-2]-1;
		}
			addtail=false;
	}
	
	else if (turn==3)
	{
		if (board [tail_x [tail-2]+1][tail_y [tail-2]]==0)
		{
			tail_x [tail-1]=tail_x [tail-2]-1;
			tail_y [tail-1]-tail_y [tail-2];
		}
		addtail=false;
	}
	
	else 
	{
		if (board [tail_x [tail-2]+1][tail_y [tail-2]]==0)
		{
			tail_x [tail-1]=tail_x [tail-2];
			tail_y [tail-1]=tail_y [tail-2]+1;
		}
		addtail=false;
	}
}
int main ()
{
	Display display;
	Snake snake;
	
	while (1)
	{
		snake.move();
		system("cls");

		if (endgame==true)
			break;
			
		snake.refresh();
		
		if (isKeyPressed())
		{
			if (snake.turn==1 && key==down)
				key=up;
			if (snake.turn==2 && key==left)
				key=right;
			if (snake.turn==3 && key==up)
				key=down;
			if (snake.turn==4 && key==right)
				key=left;
							
			snake.move ();
			system("cls");
			
			if (endgame==true)
				break;
			
			snake.refresh();
		}
		
		delay(500);
	}
	
	cout<<"You Lose!!!"<<endl<<"Your score is :"<<score;

	return 0;
}
