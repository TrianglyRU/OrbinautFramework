/// @description Insert description here
// You can write your code in this editor

	
	FromCapsule = 0;
	vspeed = -4;
	gravity = 0.21875;
	image_speed = 0;
	State = 0;
	Delay = 0;
	
	switch Stage.ZoneID {
		default: sprite_index = choose(spr_pocky, spr_flicky); break;
	}
	
	switch sprite_index {
        case spr_pocky : Xsp = 2; Ysp = -4; break;
        case spr_flicky: Xsp = 3; Ysp = -4; break;
    }