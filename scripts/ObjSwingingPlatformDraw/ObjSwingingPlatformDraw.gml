function ObjSwingingPlatformDraw()
{
	// Do not draw if unloaded
	if Unload 
	{
		exit;
	}
	
	// Draw top sprite
    draw_sprite(SpriteTop, 0, OriginX, OriginY);
    
	// Draw chain sprites
    var Count = ChainCount + 1;
	
    for (var i = 1; i < Count; i++)
    {
        var X = floor(OriginX + XDist * i);
        var Y = floor(OriginY + YDist * i);
		
        draw_sprite(SpriteChain, 0, X, Y);
    }
    
	// Draw platform sprite
    draw_sprite(SpritePlatform, 0, x, y);
}