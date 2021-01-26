function PlayerCharacterAnimationList()
{	
	switch CharacterID
	{	
		case CharSonic:
		{
			switch Animation
			{
				case AnimIdle: 
					animation_set(spr_sonic_idle, 4, false); 
				break;
				case AnimWalk: 
					animation_set(spr_sonic_walk, round(max(1, 8 - abs(Inertia))), true);
				break;
				case AnimRun: 
					animation_set(spr_sonic_run, round(max(1, 8 - abs(Inertia))), true);
				break;
				case AnimRoll:
					animation_set(spr_sonic_roll, round(max(1, 5 - abs(Inertia))), true);
				break;
				case AnimSpindash:
					animation_set(spr_sonic_spindash, 1, true); 
				break;
				case AnimCrouch:
					animation_set(spr_sonic_crouch, 4, false);
				break;
				case AnimLookup:
					animation_set(spr_sonic_lookup, 4, false);
				break;
			}
		}
		break;
		case CharTails: 
		break;
	}
}