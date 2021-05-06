function AIAnimate()
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
		case AnimRoll:
			animation_play(spr_tails_roll, 2, 1);
		break;
		case AnimSpindash:
			animation_play(spr_tails_spindash, 1, 1); 
		break;
		case AnimCrouch:
			animation_play(spr_tails_crouch, 4, 1);
		break;
		case AnimLookup:
			animation_play(spr_tails_lookup, 4, 1);
		break;
		case AnimSkid:
			animation_play(spr_tails_hurt, 1, 1);
		break;
		case AnimFly:
			animation_play(spr_tails_fly, 1, 1);
		break;
		case AnimFlyTired:
			animation_play(spr_tails_fly_tired, 8, 1);
		break;
		case AnimHurt:
			animation_play(spr_tails_hurt, 1, 1);
		break;
		case AnimDeath:
			animation_play(spr_tails_death, 1, 1);
		break;
	}	
	with TailsObject
	{
		switch AI.Animation
		{
			case AnimIdle:
			case AnimLookup:
			case AnimCrouch:	
				animation_play(spr_tails_tail_idle, 8, 1);
			break;
			case AnimRoll:
				animation_play(spr_tails_tail_roll, 4, 1);
			break;
			case AnimSpindash:
			case AnimSkid:
				animation_play(spr_tails_tail_spindash, 4, 1); 
			break;
			case AnimFly:
				animation_play(spr_tails_tail_fly, AI.Ysp ? 2 : 1, 1);		
			break;
			case AnimFlyTired:
				animation_play(spr_tails_tail_fly, 2, 1);
			break;
			default:
				animation_play(spr_tails_tail_hidden, 1, 1);
			break;
		}
	}
}