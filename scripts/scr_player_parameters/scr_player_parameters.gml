/// @function scr_player_parameters
function scr_player_parameters()
{
	gml_pragma("forceinline");
	
	if !is_underwater
	{
		if super_timer <= 0
		{
			acc_glide = 0.015625;
			acc_climb = 1;
			acc = 0.046875;
			acc_air = 0.09375;
			dec = 0.5;
			dec_roll = 0.125;
			frc	= 0.046875;
			frc_roll = 0.0234375;
			acc_top = 6;	
			jump_min_vel = -4;
			jump_vel = PlayerType == PLAYER_KNUCKLES ? -6 : -6.5;
		}
		else
		{
			acc_glide = 0.046875;
			acc_climb = 2;
			
			if PlayerType == PLAYER_SONIC
			{
				acc = 0.1875;
				acc_air = 0.375;
				dec = 1;
				dec_roll = 0.125;
				frc = 0.046875;
				frc_roll = 0.09375;
				acc_top = 10;
				jump_min_vel = -4;
				jump_vel = -8;
			}
			else
			{
				acc = 0.09375;
				acc_air = 0.1875;
				dec = 0.75;
				dec_roll = 0.125;
				frc = 0.046875;
				frc_roll = 0.0234375;
				acc_top = 8;
				jump_min_vel = -4;
				jump_vel = PlayerType == PLAYER_KNUCKLES ? -6 : -6.5;
			}
		}
		
		if item_speed_timer > 0
		{
			acc	= 0.09375;
			acc_air = 0.1875;
			frc = 0.09375;
			frc_roll = 0.046875;
			acc_top = 12;
		}
	}
	else
	{
		if super_timer <= 0
		{
			acc_glide = 0.015625;
			acc_climb = 1;
			acc = 0.0234375;
			acc_air = 0.046875;
			dec = 0.25;
			dec_roll = 0.125;
			frc = 0.0234375;
			frc_roll = 0.01171875;
			acc_top = 3;
			jump_min_vel = -2;
			jump_vel = PlayerType == PLAYER_KNUCKLES ? -3 : -3.5;
		}
		else
		{
			acc_glide = 0.046875;
			acc_climb = 2;
			
			if PlayerType == PLAYER_SONIC
			{
			    acc = 0.09375;
			    acc_air = 0.1875;
			    dec = 0.5;
			    dec_roll = 0.125;
			    frc = 0.046875;
			    frc_roll = 0.046875;
			    acc_top = 5;
			    jump_min_vel = -2;
			    jump_vel = -3.5;
			}
			else
			{
			    acc = 0.046875;
			    acc_air = 0.09375;
			    dec = 0.375;
			    dec_roll = 0.125;
			    frc = 0.046875;
			    frc_roll = 0.0234375;
			    acc_top = 4;
			    jump_min_vel = -2;
			    jump_vel = PlayerType == PLAYER_KNUCKLES ? -3 : -3.5;
			}
		}
	}
	
	if global.player_physics < PHYSICS_SK
	{
		if PlayerType == PLAYER_TAILS
		{
			dec_roll = dec / 4;
		}
	}
	else if super_timer > 0
	{
		frc_roll = 0.0234375;
	}
}
