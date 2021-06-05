/// @function bg_object_parallax(posX, posY, scrlX, scrlY, scrlOfstX, scrlOfstY, top, bottom, [incHeight], [incForce])
function bg_object_parallax(posX, posY, scrlX, scrlY, scrlOfstX, scrlOfstY, top, bottom, incHeight, incForce)
{		
	// Set variables
	var DrawX = Screen.CameraX;
	var DrawY = floor(Screen.CameraY * (1 - scrlY)) + top + posY - Screen.CameraY;

	// Set shader uniforms
	shader_set_uniform_f(Palette.Prlx_XOfst, DrawX * scrlX - scrlOfstX);
	shader_set_uniform_f(Palette.Prlx_Pos, posX, DrawY - scrlOfstY);
	
	// Skip incline parallax if incline height is 0
	if incHeight != 0 
	{
	    shader_set_uniform_f(Palette.Prlx_YStep, (incForce / 10) * incHeight);
		shader_set_uniform_f(Palette.Prlx_YHght, incHeight);
	}
	
	// Render sprite
	draw_sprite_part(sprite_index, image_index, 0, top, sprite_width, bottom - top + 1, posX, DrawY);
	
	// Reset incline height
	if incHeight != 0 
	{
		shader_set_uniform_f(Palette.Prlx_YHght, 0); 
	}
}