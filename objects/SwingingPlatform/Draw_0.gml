/// @description Draw
// You can write your code in this editor
    
	// Draw pendulum
    draw_sprite(SpriteData[2], 0, OriginX, OriginY);
    
	// Draw chain
    for (var i = 1; i < ChainCount + 1; i++)
    {
        var X = round(OriginX + DistanceX * i);
        var Y = round(OriginY + DistanceY * i);
		
        draw_sprite(SpriteData[1], 0, X, Y);
    }
    
	// Draw platform
    draw_sprite(SpriteData[0], 0, x, y);