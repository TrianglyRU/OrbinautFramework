function ObjSwingingPlatformDraw()
{
	// Exit if object is unloaded
	if !ProcessObject
	{
		exit;
	}
	
	// Draw origin sprite
    draw_sprite(SpriteTop, 0, OriginX, OriginY);
    
	// Calculate chain position
    for (var i = 1; i < ChainCount + 1; i++)
    {
        var X = floor(OriginX + DistanceX * i);
        var Y = floor(OriginY + DistanceY * i);
		
		// Draw sprite
        draw_sprite(SpriteChain, 0, X, Y);
    }
    
	// Draw platform
    draw_sprite(SpritePlatform, 0, x, y);
}