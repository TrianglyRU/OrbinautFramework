/// @description Insert description here
// You can write your code in this editor
	
	draw_sprite(SprTop, 0, OriginX, OriginY);
	
	var Count = ChainCount + 1;
	for (var i = 1; i < Count; i++)
	{
		var X = floor(OriginX + XDist * i);
		var Y = floor(OriginY + YDist * i);
		draw_sprite(SprChain, 0, X, Y);
	}
	
	draw_sprite(SprPlatform, 0, x, y);