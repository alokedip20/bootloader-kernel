void os(){
	char *c=(char*)(0xb8000+3400);			//TO DISPLAY THE LINE IN MIDDLE DEFAULT IS UP-LEFT SCREEN CORNER
	const char *str=".ALOKEDIP CHOUDHURI WELCOME TO YOUR KERNEL WRITTEN IN C\n";
	int i,j;
	char x;
	i=j=0;
	while(*str!='\n'){
		x=*str;
		c[i]=x;
		c[i+1]=0x00;
		i+=2;
		str++;
	}

	return;
}

