function ObjBreakableWallHandlerSetup()
{
	for (var h = 0; h < Height; h++) 
	{
		for (var w = 0; w < Width; w++)
		{	
			// Create a wall based on width and height variables
			var Piece          = instance_create_depth(x + 8 + 16 * w, y + 8 + 16 * h, Player.DrawOrder + 1, BreakableWall);
			Piece.sprite_index = WallSprite
			
			// Set a sprite for the piece
			if w = 0 
			{
				var frame_to_use = 0;
			} 
			else 
			{
				if w < Width - 1 
				{
					var frame_to_use = random_range(1, Piece.image_number - 2);
				} 
				else 
				{
					var frame_to_use = Piece.image_number - 1;
				}
			}
			Piece.image_index = frame_to_use;		
		}
	}
}