#include<iostream>
#include<time.h>
#include<windows.h>
#include<conio.h>
#include<stdlib.h>

#define length_of_console 80//or 160
#define width_of_console 25//or 50

using namespace std;

void gotoxy(int x, int y)
{
     HANDLE hConsoleOutput;
     COORD dwCursorPosition;
     cout.flush();
     dwCursorPosition.X=x;
     dwCursorPosition.Y=y;
     hConsoleOutput=GetStdHandle(STD_OUTPUT_HANDLE);
     SetConsoleCursorPosition(hConsoleOutput, dwCursorPosition);
}

class Position{
	public:
		int x=0;
		int y=0;
};
class Display{
	public:
		Display(int length, int width){
			
			gotoxy((length_of_console-length)/2, (width_of_console-width)/2);
			for(int i=0; i<length; i++)
				cout<<".";
				
			gotoxy((length_of_console-length)/2, (width_of_console-width)/2+width-1);	
			for(int i=0; i<length; i++)
				cout<<".";
		
			for(int i=1; i<width-1; i++){
				gotoxy((length_of_console-length)/2, (width_of_console-width)/2+i);
				cout<<"."<<endl;
			}
		
			for(int i=1; i<width-1; i++){
				gotoxy((length_of_console-length)/2+length-1, (width_of_console-width)/2+i);
				cout<<"."<<endl;
			}
		}
};

class Snake{
	public:

		Snake(int len, int length, int width){	
			Display game(length, width);
			gotoxy(((length_of_console-length)/2+(length_of_console-length)/2+length-5)/2,((width_of_console-width)/2+(width_of_console-width)/2+width-2)/2);
			system ("color a");
			cout<<"start";
			getch();
			for(int i=0; i<len; i++){
				position[i].x=(length_of_console-length)/2+len-i;
				position[i].y=(width_of_console-width)/2+1;
			}
			srand(time(0));
			set_food(length, width);
		}//constructor
///////////////////////////////////////////////////////////////////////	
		void change_position(Position position[], int len){
		
			for(int i=1; i<len; i++){
				
				temp2.x=position[i].x;
				temp2.y=position[i].y;
				position[i].x=temp.x;
				position[i].y=temp.y;
				temp.x=temp2.x;
				temp.y=temp2.y;
			}	
		}
///////////////////////////////////////////////////////////////////////
		void keep_going(int &len, bool &repeat, int length, int width){

			temp.x=position[0].x;
			temp.y=position[0].y;
			
			if((position[0].x==position[1].x) && position[0].y<position[1].y){
					
				(position[0].y)--;
				change_position(position, len);
			
			}
			else if((position[0].x==position[1].x) && position[0].y>position[1].y){
				
				(position[0].y)++;
				change_position(position, len);
			
			}
			else if((position[0].y==position[1].y) && position[0].x<position[1].x){
				
				(position[0].x)--;
				change_position(position, len);
			
			}
			else if((position[0].y==position[1].y) && position[0].x>position[1].x){
				
				(position[0].x)++;
				change_position(position, len);
			
			}
			gotoxy(food.x, food.y);
				cout<<"*";
			for(int i=0; i<len; i++){
				if(check(position, len, length, width)){
					repeat=false;
				}
			Display game(length, width);	
			gotoxy(position[i].x,position[i].y);
				if(position[i].x==food.x && position[i].y==food.y){
					len++;
					score++;
					set_food(length, width);
				}
				
				cout<<"*";
			}
			Sleep(50);
			system("cls");
		}
////////////////////////////////////////////////////////////////////////////		
		void go_up(int len){
			temp.x=position[0].x;
			temp.y=position[0].y;
			(position[0].y)--;
			change_position(position, len);
		}
		void go_down(int len){
			temp.x=position[0].x;
			temp.y=position[0].y;
			(position[0].y)++;
			change_position(position, len);
		}
		void turn_left(int len){
			temp.x=position[0].x;
			temp.y=position[0].y;
			(position[0].x)--;
			change_position(position, len);
		}
		void turn_right(int len){
			temp.x=position[0].x;
			temp.y=position[0].y;
			(position[0].x)++;
			change_position(position, len);
		}
		void set_food(int length, int width){

			int randx=rand()%(length-2);
			int randy=rand()%(width-2);
			food.x=randx+((length_of_console-length)/2+1);
			food.y=randy+((width_of_console-width)/2+1);
		}
//////////////////////////////////////////////////////////////////////////
		int check(Position position[], int len, int length,int width){
			for(int i=1; i<len; i++){
				if(position[0].x==position[i].x && position[0].y==position[i].y ||
				 position[0].x==(length_of_console-length)/2 || 
				 position[0].x==(length_of_console-length)/2+length-1 ||
				 position[0].y==(width_of_console-width)/2 ||
				 position[0].y==(width_of_console-width)/2+width-1)
					return 1;
			}
			return 0;
		}
/////////////////////////////////////////////////////////////////////////		
		~Snake(){
			system("color c");
			 cout<<"YOUR SCORE IS "<<score<<endl;
		}//destructor
	
	private:
		int score=0;
		Position position[50];
		Position temp,temp2,food;
		
};
//////////////////////////////////////////////////////////////////////////////
int main()
{
	int len_snake,length,width;
	cout<<" Length of Snake:";
	cin>>len_snake;
	cout<<" Length of screen: ";
	cin>>length;
	cout<<" Width of screen: ";
	cin>>width;
	system("cls");

	Snake snake(len_snake, length, width);
	
  	bool repeat = true;
  	while (repeat)
	  {
	    snake.keep_going(len_snake ,repeat,length,width);
	
	    if (kbhit())
	    {
	      	char ch = getch();
	     	switch(ch){
			case 80:
	      		snake.go_down(len_snake);
	      		break;
	      	case 72:
			  	snake.go_up(len_snake);
			  	break;
	      	case 77:
	      		snake.turn_right(len_snake);
	      		break;
	      	case 75:
			  	snake.turn_left(len_snake);
				break;
			}
	    }
	  }

  return 0;
}

