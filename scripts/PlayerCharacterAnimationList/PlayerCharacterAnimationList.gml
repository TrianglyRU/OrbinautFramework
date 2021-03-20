function PlayerCharacterAnimationList()
{	
	switch CharacterID
	{	
		// Sonic animations
		case CharSonic:
		{
			switch Animation
			{
				case AnimIdle: 
					animation_play(spr_sonic_idle, 4, 1); 
				break;
				case AnimWalk: 
					animation_play(spr_sonic_walk, round(max(1, 8 - abs(Inertia))), 1);
				break;
				case AnimRun: 
					animation_play(spr_sonic_run, round(max(1, 8 - abs(Inertia))), 1);
				break;
				case AnimPeelout: 
					animation_play(spr_sonic_peelout, 1, 1);
				break;
				case AnimRoll:
					animation_play(spr_sonic_roll, round(max(1, 5 - abs(Inertia))), 1);
				break;
				case AnimSpindash:
					animation_play(spr_sonic_spindash, 1, 1); 
				break;
				case AnimCrouch:
					animation_play(spr_sonic_crouch, 4, 2);
				break;
				case AnimLookup:
					animation_play(spr_sonic_lookup, 4, 2);
				break;
			}
		}
		break;
		
		// Tails animations
		case CharTails:
		{
			switch Animation
			{
				case AnimIdle: 
					animation_play(spr_tails_idle, 1, 1); 
				break;
				case AnimWalk: 
					animation_play(spr_tails_walk, round(max(1, 8 - abs(Inertia))), 1);
				break;
				case AnimRun: 
					animation_play(spr_tails_run, round(max(1, 8 - abs(Inertia))), 1);
				break;
				case AnimPeelout: 
					animation_play(spr_tails_run, 1, 1);
				break;
				case AnimRoll:
					animation_play(spr_tails_roll, 2, 1);
				break;
				case AnimSpindash:
					animation_play(spr_tails_roll, 1, 1); 
				break;
				case AnimCrouch:
					animation_play(spr_tails_idle, 1, 1);
				break;
				case AnimLookup:
					animation_play(spr_tails_idle, 1, 1);
				break;
			}			
			with TailsObject
			{
				switch Player.Animation
				{
					case AnimIdle: 
						animation_play(spr_tails_tail_idle, 1, 1); 
					break;
					case AnimWalk: 
					case AnimRun: 
						animation_play(spr_tails_tail_run, 1, 1);
					break;
					case AnimRoll:
					case AnimSpindash:
						animation_play(spr_tails_tail_roll, 1, 1); 
					break;
				}
			}
		}
		break;
	}
}