function PlayerAnimate()
{	
	// Blink sprite
	if InvincibilityFrames
	{
		if !(InvincibilityFrames mod 4)
		{
			image_alpha = !image_alpha;
		}
	}
	else
	{
		image_alpha = 1;
	}
	
	// Initialise static variables for certain animations
	static SpeedFactor     = 0;
	static AnimSpringTime  = 48;
	static AnimBreatheTime = 24;
	
	// Update statics
	if Animation != AnimBreathe
	{
		AnimBreatheTime = 24;
	}
	if Animation != AnimSpring
	{
		AnimSpringTime = 48;
	}
	SpeedFactor = PeeloutRev == -1 ? abs(Inertia) : PeeloutRev div 3;
	
	// Animate character
	switch Game.Character
	{	
		// Sonic animations
		case CharSonic:
		{
			// Regular form
			if !SuperState
			{
				switch Animation
				{
					case AnimIdle:
					{
						var Frame = sprite_index == spr_sonic_idle ? image_index : 0;
						if  Frame == 0
						{
							var Duration = 288;
						}
						else
						{
							var Duration = 24;
						}
						animation_play(spr_sonic_idle, Duration, 3);
					}
					break;
					case AnimMove:	
					{
						if abs(Inertia) < 6
						{
							var Sprite = spr_sonic_walk;
						}
						else
						{
							if Game.PeeloutEnabled
							{
								 if abs(Inertia) < 10
								 {
									 var Sprite = spr_sonic_run;
								 }
								 else
								 {
									 var Sprite = spr_sonic_peelout;
								 }
							}
							else
							{
								var Sprite = spr_sonic_run;
							}	
						}
						animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
					}
					break;
					case AnimPeelout:
					{
						switch PeeloutRev div 15
						{
							case 0:
								var Sprite = spr_sonic_walk;
							break;
							case 1:
								var Sprite = spr_sonic_run;
							break;
							case 2:
								var Sprite = spr_sonic_peelout;
							break;
						}
						animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
					}
					break;
					case AnimSpin:
						animation_play(spr_sonic_roll, round(max(1, 4 - SpeedFactor)), 0);
					break;
					case AnimSpindash:
						animation_play(spr_sonic_spindash, 1, 0); 
					break;
					case AnimCrouch:
						animation_play(spr_sonic_crouch, 4, 1);
					break;
					case AnimLookup:
						animation_play(spr_sonic_lookup, 4, 1);
					break;
					case AnimSkid:
						animation_play(spr_sonic_skid, 6, 2);
					break;
					case AnimPush:
						animation_play(spr_sonic_push, round(max(1, 8 - SpeedFactor) * 4), 0);
					break;
					case AnimHurt:
						animation_play(spr_sonic_hurt, 1, 0);
					break;
					case AnimDeath:
						animation_play(spr_sonic_death, 1, 0);
					break;	
					case AnimDrown:
						animation_play(spr_sonic_drown, 1, 0);
					break;
					case AnimBalance:
						animation_play(spr_sonic_balance, 16, 0);
					break;
					case AnimBalanceFlip:
						animation_play(spr_sonic_balance_flip, 16, 0);
					break;
					case AnimSpring:
					{
						if !(--AnimSpringTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_play(spr_sonic_spring, 1, 0);
						}
					}
					break;
					case AnimActEnd:
						animation_play(spr_sonic_actend, 12, 0);
					break;
					case AnimAirSpin:
						animation_play(spr_sonic_airspin, 3, 0);
					break;
					case AnimBreathe:
					{
						if !(--AnimBreatheTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_play(spr_sonic_breathe, 1, 0);
						}
					}
					break;
					case AnimDropdash:
						animation_play(spr_sonic_dropdash, 1, 0);
					break;
					default: break;
				}
			}
			
			// Super state
			else
			{
				switch Animation
				{
					case AnimTransform:
						animation_play(spr_supersonic_transform, 3, 5);
					break;
					case AnimIdle:
						animation_play(spr_supersonic_idle, 8, 0);
					break;
					case AnimMove:	
					{
						if abs(Inertia) < 8
						{
							var Sprite = spr_supersonic_walk;
						}
						else
						{
							var Sprite = spr_supersonic_fly;
						}
						animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
					}
					break;
					case AnimPeelout: 
					{
						switch PeeloutRev div 15
						{
							case 0:
								var Sprite = spr_supersonic_walk;
							break;
							case 1:
							case 2:
								var Sprite = spr_supersonic_fly;
							break;
						}
						animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
					}
					break;
					case AnimSpin:
						animation_play(spr_sonic_roll, round(max(1, 4 - SpeedFactor)), 0);
					break;
					case AnimSpindash:
						animation_play(spr_sonic_spindash, 1, 0); 
					break;
					case AnimCrouch:
						animation_play(spr_supersonic_crouch, 4, 1);
					break;
					case AnimLookup:
						animation_play(spr_supersonic_lookup, 4, 1);
					break;
					case AnimSkid:
						animation_play(spr_supersonic_skid, 3, 4);
					break;
					case AnimPush:
						animation_play(spr_supersonic_push, round(max(1, 8 - SpeedFactor) * 4), 0);
					break;
					case AnimHurt:
						animation_play(spr_supersonic_hurt, 1, 0);
					break;
					case AnimDeath:
						animation_play(spr_supersonic_death, 1, 0);
					break;	
					case AnimDrown:
						animation_play(spr_supersonic_drown, 1, 0);
					break;
					case AnimBalance:
						animation_play(spr_supersonic_balance, 10, 0);
					break;
					case AnimSpring:
					{
						if !(--AnimSpringTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_play(spr_supersonic_spring, 4, 0);
						}
					}
					break;
					case AnimAirSpin:
						animation_play(spr_supersonic_airspin, 3, 0);
					break;
					case AnimBreathe:
					{	
						if !(--AnimBreatheTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_play(spr_supersonic_breathe, 1, 0);
						}
					}
					break;
					case AnimDropdash:
						animation_play(spr_sonic_dropdash, 1, 0);
					break;
					default: break;
				}
			}
		}
		break;
		
		// Tails animations
		case CharTails:
		{
			switch Animation
			{
				case AnimIdle: 
				{
					var Frame = sprite_index == spr_tails_idle ? image_index : 0;
					if  Frame == 0
					{
						var Duration = 128;
					}
					else if Frame < 3
					{
						var Duration = 8;
					}
					else if Frame == 3
					{
						var Duration = 64;
					}
					else if Frame < 6
					{
						var Duration = 8;
					}
					else if Frame == 6
					{
						var Duration = 72;
					}
					else if Frame == 7
					{
						var Duration = 128;
					}
					else
					{
						var Duration = 8;
					}
					animation_play(spr_tails_idle, Duration, 7);
				} 
				break;
				case AnimMove:	
				{
					if abs(Inertia) < 6
					{
						var Sprite = spr_tails_walk;
					}
					else if abs(Inertia) < 10
					{
						var Sprite = spr_tails_run;
					}
					else
					{
						var Sprite = spr_tails_dash;
					}
					animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
				}
				break;
				case AnimSpin:
					animation_play(spr_tails_roll, 2, 0);
				break;
				case AnimSpindash:
					animation_play(spr_tails_spindash, 1, 0); 
				break;
				case AnimCrouch:
					animation_play(spr_tails_crouch, 4, 0);
				break;
				case AnimLookup:
					animation_play(spr_tails_lookup, 4, 0);
				break;
				case AnimSkid:
					animation_play(spr_tails_skid, 8, 0);
				break;
				case AnimFly:
					animation_play(spr_tails_fly, 1, 0);
				break;
				case AnimFlyTired:
					animation_play(spr_tails_fly_tired, 8, 0);
				break;
				case AnimSwim:
					animation_play(spr_tails_swim, Ysp < 0 ? 4 : 8, 0);
				break;
				case AnimSwimTired:
					animation_play(spr_tails_swim_tired, 8, 0)
				break;
				case AnimHurt:
					animation_play(spr_tails_hurt, 1, 0);
				break;
				case AnimDeath:
				case AnimDrown:
					animation_play(spr_tails_death, 1, 0);
				break;
				case AnimSpring:
				{
					if !(--AnimSpringTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_tails_spring, 4, 0);
					}
				}
				break;
				case AnimPush:
					animation_play(spr_tails_push, round(max(1, 8 - SpeedFactor) * 4), 0);
				break;
				case AnimActEnd:
					animation_play(spr_tails_actend, 16, 1);
				break;
				case AnimBalance:
					animation_play(spr_tails_balance, 20, 0);
				break;
				case AnimTransform:
					animation_play(spr_tails_transform, 3, 2);
				break;
				case AnimAirSpin:
					animation_play(spr_tails_airspin, 3, 0);
				break;
				case AnimBreathe:
				{
					if !(--AnimBreatheTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_tails_breathe, 1, 0);
					}
				}
				break;
				default: break;
			}	
		}
		break;

		// Knuckles animations
		case CharKnuckles:
		{
			switch Animation
			{
				case AnimIdle:
				{
					var Frame = sprite_index == spr_knuckles_idle ? image_index : 0;
					if  Frame == 0
					{
						var Duration = 300;
					}
					else if Frame < 17
					{
						var Duration = 18;
					}
					else if Frame == 17
					{
						var Duration = 30;
					}
					else
					{
						var Duration = 6;
					}
					animation_play(spr_knuckles_idle, Duration, 0);	
				}
				break;
				case AnimMove:	
				{
					if abs(Inertia) < 6
					{
						var Sprite = spr_knuckles_walk;
					}
					else
					{
						var Sprite = spr_knuckles_run;
					}
					animation_play(Sprite, round(max(1, 8 - SpeedFactor)), 0);
				}
				break;
				case AnimSpin:
					animation_play(spr_knuckles_roll, round(max(1, 4 - SpeedFactor)), 0);
				break;
				case AnimSpindash:
					animation_play(spr_knuckles_spindash, 1, 0); 
				break;
				case AnimCrouch:
					animation_play(spr_knuckles_crouch, 6, 1);
				break;
				case AnimLookup:
					animation_play(spr_knuckles_lookup, 6, 1);
				break;
				case AnimSkid:
					animation_play(spr_knuckles_skid, 4, 1);
				break;
				case AnimHurt:
					animation_play(spr_knuckles_hurt, 1, 0);
				break;
				case AnimDeath:
					animation_play(spr_knuckles_death, 1, 0);
				break;
				case AnimGlide:
				{
					sprite_index = spr_knuckles_glide;
					image_index  = GlideFrame;
				}
				break;
				case AnimGlideDrop:
					animation_play(spr_knuckles_drop, 6, 1);
				break;
				case AnimClimbDrop:
				{
					sprite_index = spr_knuckles_drop;
					image_index  = 1;
				}
				break;
				case AnimDropStand:
					animation_play(spr_knuckles_dropstand, 1, 0);
				break;
				case AnimGlideGrounded:
					animation_play(spr_knuckles_glideground, 1, 0);
				break;
				case AnimGlideStand:
					animation_play(spr_knuckles_glidestand, 1, 0);
				break;
				case AnimClimb:
					animation_play(spr_knuckles_climb, -sign(Ysp) * 4, 0);
				break;
				case AnimClimbering:
					animation_play(spr_knuckles_climbering, 6, 3);
				break;
				case AnimPush:
					animation_play(spr_knuckles_push, round(max(1, 8 - SpeedFactor)), 0);
				break;
				case AnimSpring:
				{
					if !(--AnimSpringTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_knuckles_spring, 1, 0);
					}
				}
				break;
				case AnimBalance:
				{
					var Frame = sprite_index == spr_knuckles_balance ? image_index : 0;
					if  Frame < 6 or Frame >= 9
					{
						var Duration = 8;
					}
					else if Frame == 6
					{
						var Duration = 60;
					}
					else if Frame < 9
					{
						var Duration = 12;
					}
					animation_play(spr_knuckles_balance, Duration, 9);
				}
				break;
				case AnimTransform:
					animation_play(spr_knuckles_transform, 3, 2);
				break;
				case AnimActEnd:
					animation_play(spr_knuckles_actend, 6, 5);
				break;
				case AnimAirSpin:
					animation_play(spr_knuckles_airspin, 3, 0);
				break;
				case AnimBreathe:
				{
					if !(--AnimBreatheTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_knuckles_breathe, 1, 0);
					}
				}
				break;
				default: break;
			}
		}
		break;
	}
}