/// @function object_perform_tile_collision(xLeft, yLeft, xRight, yRight)
function object_perform_tile_collision(xLeft, yLeft, xRight, yRight)
{
	// Variables list
	var CollisionLayer, NewY1, NewY2;
	
	// Get collision layers
	CollisionLayer = Stage.TileLayer[LayerA] or Stage.TileLayer[LayerB];
	
	// Get coordinates
	NewY1 = yLeft;
	NewY2 = yRight;
	
	// Check if we're colliding with tiles on our left
	if tile_meeting(xLeft, yLeft, CollisionLayer)
	{	
		while tile_meeting(xLeft, yLeft, CollisionLayer)
		{
			NewY1--;
		}
		return yLeft - NewY1;
	}
	
	// Check fif we're colliding with tile on our right
	if tile_meeting(xRight, yRight, CollisionLayer)
	{
		while tile_meeting(xRight, yRight, CollisionLayer)
		{
			NewY2--;
		}
		return yRight - NewY2;
	}			
}