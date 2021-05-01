/// @description Insert description here
// You can write your code in this editor
	
	Spin += Player.Facing * 4;
	var Ang = 45 * Number - Spin;
	var Delay = Number mod 3 * 5;
	x = Player.PlayerPositionX[| Delay] + dsin(Ang) * 16;
	y = Player.PlayerPositionY[| Delay] + dcos(Ang) * 16;
	if ( image_speed and  image_index = 7)
	or (!image_speed and !image_index) image_speed *= -1;