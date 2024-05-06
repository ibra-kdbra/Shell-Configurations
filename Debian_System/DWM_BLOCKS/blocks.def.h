//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    //{"  ", "audio",                          1,      0},

    {" ", "volume",                           1,     10},
	
	/*{"  ", "cat /sys/class/power_supply/BAT0/capacity",						5,		0},*/

    {" ", "battery",                          10,      0},

    {"  ", "pacupdate",					            3600,		9},
    
    {" ", "web",                             30,      0},

    {"  ", "clock",                          30,      0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim = '|';
