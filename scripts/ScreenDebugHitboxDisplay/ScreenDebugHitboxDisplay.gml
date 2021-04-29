function ScreenDebugHitboxDisplay()
{
	// Exit the code if devmode is disabled
	if (!Game.DevMode) exit;
	
	// Activate hitbox debugging
	if Stage.State != ActStateLoading
	{
		if keyboard_check_pressed(ord("E"))
		{
			DebugHitboxes = !DebugHitboxes;
		}
	}
	
	// Check if general and hitbox debugging is enabled
	if DebugToggle and DebugHitboxes
	{
		// Get player hitbox size
		if Player.Animation == AnimCrouch or Player.Animation == AnimSpindash
		{
			var pTop    = floor(Player.PosY - 4);
			var pLeft   = floor(Player.PosX - 8);
			var pRight  = floor(Player.PosX + 8);
			var pBottom = floor(Player.PosY + 16);	
		}
		else
		{
			var pLeft   = floor(Player.PosX - 8);
			var pRight  = floor(Player.PosX + 8);			     
			var pTop	= floor(Player.PosY - Player.yRadius + 3);
			var pBottom = floor(Player.PosY + Player.yRadius - 3);
		}
		
		// Set draw colour and alpha
		draw_set_alpha(0.5);
		draw_set_colour($ff00ff);
		
		// Draw player hitbox
		draw_rectangle(pLeft, pTop, pRight, pBottom, false);
			
		// Do object debug
		with Objects 
		{
			// Exit the code if object hitbox wasn't initialized
			if (!variable_instance_exists(id, "objXRadiusHit")) exit;
		
			// Draw object hitbox
			draw_rectangle(x - objXRadiusHit, y - objYRadiusHit, x + objXRadiusHit - 1, y + objYRadiusHit - 1, false);		
		}
	}
	
	// Restore draw colour and alpha
	draw_set_alpha(1.0);
	draw_set_colour(c_white);
} 