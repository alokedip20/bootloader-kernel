#define MAX_COLS 320
void os(){
	char *video=(char*)(0xA0000);					//STARTING ADDRESS OF VIDEO MEMORY
	unsigned char color=1;
	int height=200;
	int width=320;
	int row,col,offset;
	offset=20;
	int count=0;
	while(count<height-2*offset){
		row=col=offset;
		while(row<height-offset){
			video[MAX_COLS*row+col]=color;			//LEFT SIDE
			row++;
		}
		row=col=offset;
		while(col<width-offset){
			video[MAX_COLS*row+col]=color;			//TOP SIDE
			col++;
		}	
		col=offset;
		row=height-offset;
		while(col<width-offset){
			video[MAX_COLS*row+col]=color;			//BOTTOM SIDE
			col++;
		}
		col=width-offset;
		row=offset;
		while(row<height-offset){
			video[MAX_COLS*row+col]=color;			//RIGHT SIDE
			row++;
		}
		count++;
		offset+=5;
	}
}

