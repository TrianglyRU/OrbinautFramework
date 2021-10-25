/// @function object_flash_process(flashType)
function object_flash_process(flashType)
{
	// Exit if no flash has been triggered
	if !variable_instance_exists(id, "Obj_FlashDuration")
	{
		exit;
	}
	
	// Exit if object is off-screen
	if !object_is_onscreen(id)
	{
		exit;
	}
	
	// Apply flash effect
	if Obj_FlashTimer mod 2
	{
		shader_set(ShaderFlash);
		shader_set_uniform_i(Shader.FlashType, flashType);
		draw_self();
		shader_reset();
	}
	else
	{
		draw_self();
	}

	// Handle flash time
	if variable_check(Stage, "DoUpdate") and Obj_FlashTimer and !(--Obj_FlashSubTimer)
	{
		Obj_FlashSubTimer = Obj_FlashDuration;
		Obj_FlashTimer--;
	}	
}