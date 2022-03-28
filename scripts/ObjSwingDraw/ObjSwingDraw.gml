function ObjSwingDraw()
{
	// Draw pendulum
    draw_sprite(SpriteData[2], 0, OriginX, OriginY);
    
	// Draw chain
    for (var i = 1; i < ChainCount + 1; i++)
    {
        var X = floor(OriginX + DistanceX * i);
        var Y = floor(OriginY + DistanceY * i);
		
        draw_sprite(SpriteData[1], 0, X, Y);
    }
    
	// Draw platform
    draw_sprite(SpriteData[0], 0, x, y);
}