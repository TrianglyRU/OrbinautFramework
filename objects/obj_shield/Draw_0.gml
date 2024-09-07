// Override draw
var _player = TargetPlayer;

if _player.super_timer <= 0 && _player.item_inv_timer == 0 && _player.visible && _player.state != PLAYER_STATE_DEATH
{
	draw_sprite_ext
	(
		sprite_index, image_index, floor(_player.x), floor(_player.y), _player.facing, image_yscale, image_angle, c_white, image_alpha
	);
}