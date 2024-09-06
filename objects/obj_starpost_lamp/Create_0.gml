#macro LAMP_STATE_IDLE 0
#macro LAMP_STATE_ROTATE 1
#macro LAMP_STATE_ACTIVE 2

// Inherit the parent event
event_inherited();

/// @method m_starpost_lamp_activate
m_starpost_lamp_activate = function()
{
	ani_start(sprite_index, 4);
	state = LAMP_STATE_ACTIVE;
}

state = LAMP_STATE_IDLE;
angle = 0;
radius = sprite_height / 2 + 3;
rot_x = x;
rot_y = y + radius;
	
// Render in front of the Star Post
depth -= 1;