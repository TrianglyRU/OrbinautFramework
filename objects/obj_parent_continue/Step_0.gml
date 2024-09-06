// Wait for input and start animation if input is detected
if !start_pressed
{
	if !input_get_pressed(0).start
	{
		exit;
	}
	
	audio_play_sfx(sfx_charge);
	ani_start(animation_data[1], 5);
	start_pressed = true;
}

if vel_charge >= vel_charge_target
{
	x += 16;
}

vel_charge += vel_charge_acc;

// Select the sprite and update animation based on velocity
var _sprite = animation_data[2];

if sprite_index == animation_data[1] && !ani_get_frame_change()
{
	exit;
}

if vel_charge >= 7 && array_length(animation_data) > 4
{
	_sprite = animation_data[4];
}
else if vel_charge >= 6
{
	_sprite = animation_data[3];
}

var _duration = floor(max(1, 9 - abs(vel_charge)));

ani_start(_sprite);
ani_update_duration(_duration);