/// @function
function MenuMainList()
{
	// Option list
	//MainList[0] = menu_add_list("STAGE SELECT", 1);
	
	
	MainList[0] = ["STAGE SELECT", ActiveMenu[1], 0];
	MainList[1] = ["NEW GAME",     ActiveMenu[2], 0];
	MainList[2] = ["LOAD GAME",    ActiveMenu[3], 0];
	MainList[3] = ["SETTINGS",	   ActiveMenu[4], 0];
	MainList[4] = ["EXIT",		   0,		      0];
	
	MainList[5] = 0;
}