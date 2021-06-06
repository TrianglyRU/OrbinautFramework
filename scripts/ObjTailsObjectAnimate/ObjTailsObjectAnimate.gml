function ObjTailsObjectAnimate()
{
	switch Player.Animation
	{
		case AnimIdle:
		case AnimLookup:
		case AnimCrouch:	
			animation_play(spr_tails_tail_idle, 8, 1);
		break;
		case AnimRoll:
			animation_play(spr_tails_tail_type1, 4, 1);
		break;
		case AnimSpindash:
			animation_play(spr_tails_tail_type2, 4, 1); 
		break;
		case AnimPush:
		case AnimSkid:
			animation_play(spr_tails_tail_type3, 4, 1);
		break;
		case AnimFly:
			animation_play(spr_tails_tail_fly, Player.Ysp ? 2 : 1, 1);		
		break;
		case AnimFlyTired:
			animation_play(spr_tails_tail_fly, 2, 1);
		break;
		default:
			animation_play(spr_tails_tail_hidden, 1, 1);
		break;
	}
}