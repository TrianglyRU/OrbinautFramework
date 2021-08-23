function ObjBubbleControllerStartup()
{
	// Create variables
	BubbleDelay     = 0;
	CountdownSprite = 0;
	IsCountBubble   = 0;
	DrownBubbles    = 0;
	DrownDelay      = 0;
	
	// Set flags
	DrownDelay      = -1;
	BubbleDelay     = -1;
	CountdownSprite = noone;
}