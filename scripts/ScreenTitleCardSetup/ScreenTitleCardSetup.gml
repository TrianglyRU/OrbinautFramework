function ScreenTitleCardSetup() 
{
	// Disable global input
	Input.IgnoreInput = true;
	
	// Initialize a timer
	CardTimer = 0;
	
	// Set string text
	CardString[0] = Stage.CardName;
	CardString[1] = "ZONE";	
			
	// Set card values
	CardValue[0] = 270;
	CardValue[1] = -230;
	CardValue[2] = 0
	CardValue[3] = 80
	CardValue[4] = 0
	CardValue[5] = 105
	CardValue[6] = 302;
	CardValue[7] = 136;
	CardValue[8] = 0;
}