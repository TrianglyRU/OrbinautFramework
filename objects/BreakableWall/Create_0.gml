/// @description Insert description here
// You can write your code in this editor
	
	// Create pieces
	for (var i = 0; i < Width; i++)
	{
		for (var j = 0; j < Height; j++)
		{
			Piece[i, j]	= instance_create(x + 16 * i, y + 16 * j, BreakableWallPiece);
		}
	}