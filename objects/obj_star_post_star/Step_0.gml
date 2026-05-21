if timer >= 512
{
	instance_destroy();
	return;
}

if timer >= 384
{
	radius -= 0.25;
}
else if timer < 128
{
	radius += 0.25;
}

if timer >= 128 && !transition_flag && collision_player(player_get(0))
{
	transition_flag = true;
	
	audio_bgm_stop(1);
	fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_load_bonus_stage);
}

timer++;

var _radius = floor(radius);
var _angle = 90 * star_index + timer * 12.65625;
var _x = dsin(_angle) * 512;
var _y = ((dcos(_angle) * 512) << 10) + _x * dsin(timer * 2.8125) * 1536;
var _dist_x = (_x << 12) * _radius;
var _dist_y = _y * _radius;

x = round(xstart + (_dist_x >> 21));
y = round(ystart + (_dist_y >> 21));