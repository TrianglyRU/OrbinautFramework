/// @function bg_object_parallax(SpriteID,values)
function bg_object_parallax(SpriteID, Values)
{
	// Get values
	var PosX      = Values[0];
	var PosY      = Values[1];
	var ScrlX	  = Values[2];
	var ScrlY	  = Values[3];
	var ScrlOfstX = Values[4];
	var ScrlOfstY = Values[5];
	var Top       = Values[6];
	var Bottom    = Values[7];
	var IncHeight = Values[8];
	var IncForce  = Values[9];
	var Width	  = Values[10];
	var Texel     = Values[11];
	
	// Set variables
	var DrawX = Screen.CameraX;
	var DrawY = floor(Screen.CameraY * (1 - ScrlY)) + Top + PosY;

	// Set shader uniforms
	shader_set_uniform_f(Parallax.Prlx_Ofst, DrawX * ScrlX - ScrlOfstX);
	shader_set_uniform_f(Parallax.Prlx_Pos,  DrawX + PosX, DrawY - ScrlOfstY);
	
	shader_set_uniform_f(Parallax.Prlx_Scale, Width);
	shader_set_uniform_f(Parallax.Prlx_Texel, Texel);
	
	// Skip incline parallax if incline height is 0
	if IncHeight != 0 
	{
	    shader_set_uniform_f(Parallax.Prlx_Step, (IncForce / 10) * IncHeight);
		shader_set_uniform_f(Parallax.Prlx_Hght, IncHeight);
	}
	
	// Render sprite
	draw_sprite_part(SpriteID, 0, 0, Top, Width, Bottom - Top + 1, DrawX + PosX, DrawY);
	
	// Reset incline height
	if IncHeight != 0 
	{
		shader_set_uniform_f(Parallax.Prlx_Hght, 0); 
	}
}