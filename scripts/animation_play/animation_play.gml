/// @function animation_play(objSprite, aniSpeed, doLoopFrom) 
function animation_play(objSprite, aniSpeed, doLoopFrom) 
{	
	// Report script error
	if doLoopFrom < 1 or doLoopFrom > image_number
	{
		show_message("Wrong doLoopFrom attribute set in function animation_play. doLoopFrom should not be lower than 1 or higher than sprite frames number.");
		game_end();
	}
	
	// Force GMS sprite speed to be 0
	image_speed = 0;
	
	// Set anitimer variable
	if !variable_instance_exists(id, "aniTimer")
	{
		variable_instance_set(id, "aniTimer", 0);
	}
	
	// Update sprite
	if sprite_index != objSprite
    {
        sprite_index = objSprite;
        image_index  = 0;
		variable_instance_set(id, "aniTimer", aniSpeed); 
    }
	
	// Hangle subimage change
    else
    {
		var aniTimer = variable_instance_get(id, "aniTimer");
        if  aniTimer > 1
        {
            variable_instance_set(id, "aniTimer", aniTimer - 1);
        }
        else
        {	
			if image_index < image_number - 1
			{
				image_index += 1;
			}
			else
			{
				image_index = doLoopFrom - 1;		
			} 	
			variable_instance_set(id, "aniTimer", aniSpeed);
        }	
    }
}