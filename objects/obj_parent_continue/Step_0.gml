if !start_pressed
{
	if !input_check_pressed(0).start
	{
		return;
	}
	
	start_pressed = true;
	animator.start(animation_data[1], 0, 0, 5);
	
	audio_sfx_play(snd_spin_charge);
}

if vel_charge >= vel_charge_target
{
	x += 16;
}

vel_charge += vel_charge_acc;

if sprite_index == animation_data[1] && !(animator.timer < 0 || image_index > 0)
{
	return;
}

var _sprite = animation_data[2];
var _duration = floor(max(1, 9 - abs(vel_charge)));

if vel_charge >= 7 && array_length(animation_data) > 4
{
	_sprite = animation_data[4];
}
else if vel_charge >= 6
{
	_sprite = animation_data[3];
}

if sprite_index != _sprite
{
	animator.start(_sprite, 0, 0, _duration);
}
else
{
	animator.duration = _duration;
}