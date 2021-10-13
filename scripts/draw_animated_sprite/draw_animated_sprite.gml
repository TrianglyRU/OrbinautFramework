function draw_animated_sprite(sprite,speed,x,y)
{
	sprite_set_speed(sprite, 1 / speed, spritespeed_framespergameframe);
	
	draw_sprite(sprite, sprite_index, x, y);
}