/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(ord("V"))) HP = 0;

	if (StateTimer) StateTimer--;
	switch State
	{
		case 0:
			PosY++;
			if !StateTimer
			{
				State = 1;
				image_index = 0;
			}
			if (StateTimer = 50) OrbossOrb.State = 3;
		break;
		case 1:
			AngleX = (AngleX + 3) mod 360;
			AngleY = (AngleY + 6) mod 360;
			Spin   = (Spin   + 1) mod 360;
			var PPosX = floor(Player.PosX);
			var Dest = PPosX + 32 * (PPosX > BossController.x ? -1 : 1);
			if (Dest > PosX) PosX++;
			else if (Dest < PosX) PosX--;
		break;
		case 2:
			if StateTimer
			{
				if (StateTimer = 45) image_index = 1;
			}
			else
			{
				 State = 3;
				 StateTimer = 300;
			}
		break;
		case 3:
			if StateTimer
			{
				var FireTime = StateTimer mod 200;
				if FireTime >= 150 and !(FireTime mod 10)
				{
					var ID = id;
					var Fire = instance_create_depth(x, y, depth - 1, OrbossFire);
					with Fire
					{
						Parent = ID;
						image_xscale = 0;
						image_yscale = 0;
						Angle = (200 - FireTime) * 2;
						Timer = 60;
					}
					Fire = instance_create_depth(x, y, depth - 1, OrbossFire);
					with Fire
					{
						Parent = ID;
						image_xscale = 0;
						image_yscale = 0;
						Angle = -(200 - FireTime) * 2;
						Timer = 60;
					}
				}
				
				if StateTimer mod 8 == 1
				{	
					instance_create_depth(x + irandom(50) - 25, y + irandom(50) - 25, depth - 1, StateTimer > 50 ? OrbossFire : OrbossSmoke);
				}
				if StateTimer = 50
				{
					OrbossOrb.State = 3;
					Spin   = 0;
					AngleX = 0;
					AngleY = 0;
				}
			}
			else
			{
				image_index = 0;
				State = 1;
			}
		break;
		case 4:
			if StateTimer mod 8 == 1
			{	
				// Spawn explosion and play sound
				instance_create(x + irandom(50) - 25, y + irandom(50) - 25, DustExplosion);
				audio_sfx_play(sfxDestroy, false);
			}
			
			if !StateTimer
			{
				// Tell the controller boss was defeated
				BossController.BossDefeated = true;
				instance_destroy(OrbossOrb);
				instance_destroy();
			}
		break;
	}
	
	if (State) SinMove = (SinMove + 2) mod 360;
	x = floor(PosX);
	y = floor(PosY + dsin(SinMove) * 8);
	
	if (!HP) exit;
	if object_player_overlap(CollisionHitbox)
	{
		// Check if player can destroy Badnik
		if State != 3 and (Player.Jumping or Player.Rolling or Player.SpindashRev >= 0
		or Player.InvincibilityBonus or Player.GlidingState)
		{	
			if State = 1 and !StateTimer
			{
				audio_sfx_play(sfxDestroy, false);
				
				HP--;
				State = 2;
				StateTimer = 90;
				
				OrbossOrb.State = 2;
			
				// Make player bounce if they are airborne
				if !Player.Grounded
				{
					if floor(Player.PosY) < y
					{
						Player.Ysp = -Player.Ysp;
					}
					else
					{
						Player.Ysp -= 1 * sign(Player.Ysp);
					}
				}
			
				if !HP
				{
					State = 4;
					StateTimer = 300;
					image_index = 2;
				}
			}
		}
		else
		{
			object_damage(false, false, false, false);
		}
	}