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
	CardValue[0] = 270;		// Ribbon X
	CardValue[1] = -230;	// Ribbon Y
	CardValue[2] = 0		// Zonename X
	CardValue[3] = 80		// Zonename Y
	CardValue[4] = 0		// Zone X
	CardValue[5] = 105		// Zone Y
	CardValue[6] = 302;		// Act X
	CardValue[7] = 136;		// Act Y
	CardValue[8] = 0;		// Act XSize
}