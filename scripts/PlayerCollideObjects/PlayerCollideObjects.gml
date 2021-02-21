function PlayerCollideObjects()
{
	// Define player hitbox size
	var x1 = floor(PosX - 8);
	var x2 = floor(PosX + 8);			     
	var y1 = floor(PosY - yRadius + 3);
	var y2 = floor(PosY + yRadius - 3);
	
	// Check for collision with an object
	GotObject = collision_rectangle(x1, y1, x2, y2, Objects, false, true);
}