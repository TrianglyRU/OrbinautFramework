/// @function background_set_parallax(posX, posY, scrlX, scrlY, scrlOfstX, scrlOfstY, top, height, [incHeight], [incForce])
function background_set_parallax(posX, posY, scrlX, scrlY, scrlOfstX, scrlOfstY, top, height, incHeight, incForce)
{		
	// Set variables
	var DrawX = Screen.CameraX;
	var DrawY = floor(Screen.CameraY * scrlY) + top + posY;

	// Set shader uniforms
	shader_set_uniform_f(Prlx_XOfst, (DrawX * scrlX) - scrlOfstX);
	shader_set_uniform_f(Prlx_Pos,    DrawX + posX, DrawY - scrlOfstY);
	
	// Skip incline parallax if incline height is 0
	if incHeight != 0 
	{
	    shader_set_uniform_f(Prlx_YStep, (incForce / 10) * incHeight);
		shader_set_uniform_f(Prlx_YHght, incHeight);
	}
	
	// Render sprite
	draw_sprite_part(sprite_index, image_index, 0, top, sprite_width, height, DrawX + posX, DrawY);	
	
	// Reset incline height
	if incHeight != 0 
	{
		shader_set_uniform_f(Prlx_YHght, 0); 
	}
}