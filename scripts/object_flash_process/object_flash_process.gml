/// @function object_flash_process(type)
function object_flash_process(type)
{
	variable_create_new("Obj_FlashDuration", 0);
	variable_create_new("Obj_FlashSubTimer", 0);
	variable_create_new("Obj_FlashTimer",    0);
	
	if Obj_FlashTimer mod 2
	{
		shader_set(ShaderFlash);
		shader_set_uniform_i(Shader.FlashType, type);
		draw_self();
		shader_reset();
	}
	else
	{
		draw_self();
	}

	if variable_check(Stage, "DoUpdate") and Obj_FlashTimer and !(--Obj_FlashSubTimer)
	{
		Obj_FlashSubTimer = Obj_FlashDuration;
		Obj_FlashTimer--;
	}	
}