void os(){
	char *c=(char*)(0xb8000+1470);			//TO DISPLAY THE LINE IN MIDDLE DEFAULT IS UP-LEFT SCREEN CORNER
	const char *str=" ALOKEDIP CHOUDHURI WELCOME TO YOUR KERNEL WRITTEN IN C\n";
	int i,k;
	char x;
	i=k=0;
	char *d=(char*)(0xb8000);
//------------------------------------------ CLEAR THE SCREEN  ------------------------------------------------
	while(k<80*25*2){
		d[k]=' ';		//REPLACE THE LETTER WITH BLANK TO MAKE IT EMPTY
		d[k+1]=0x00;		//AS EACH CHARECTER IS OF SIZE 16BITS.
		k+=2;
	}	
//--------------------------------------- PRINT THE GREETING MESSEGE TO THE USER  -----------------------------
	while(*str!='\n'){
		x=*str;
		c[i]=x;
		c[i+1]=0x00;
		i+=2;
		str++;
	}
//---------------------------------------------------------------------------------------------------------------
	return;
}

