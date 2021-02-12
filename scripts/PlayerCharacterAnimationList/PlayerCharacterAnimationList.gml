function PlayerCharacterAnimationList()
{	
	switch CharacterID
	{	
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
					if abs(Inertia) < 16
					{
						animation_play(spr_sonic_run, round(max(1, 8 - abs(Inertia))), 1);
					}
					else
					{
						animation_play(spr_sonic_peelout, round(max(1, 8 - abs(Inertia))), 1);
					}
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
		case CharTails: 
		break;
	}
}