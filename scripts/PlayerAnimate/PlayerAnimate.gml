function PlayerAnimate()
{	
	// Initialise static variables for certain animations
	static AnimSpringTime  = 48;
	static AnimBreatheTime = 24;
	static AnimKnuxSkid    = 16;
	static AnimKnuxGetUp   = 16;
	
	// Update statics
	if Animation != AnimBreathe
	{
		AnimBreatheTime = 24;
	}
	if Animation != AnimSpring
	{
		AnimSpringTime = 48;
	}
	if Animation != AnimSkid
	{
		AnimKnuxSkid = 16;
	}
	if Animation != AnimDropStand and Animation != AnimGlideStand
	{
		AnimKnuxGetUp = 16;
	}
	
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
						animation_play(spr_sonic_idle, [288, 48, 24, 24], 0, 2);
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
						animation_play(Sprite, round(max(1, 8 - abs(Inertia))), 0, 0);
					}
					break;
					case AnimPeelout:
					{
						if abs(PeeloutRev) < 6
						{
							var Sprite = spr_sonic_walk;
						}
						else if abs(PeeloutRev) < 10
						{
							var Sprite = spr_sonic_run;
						}
						else
						{
							var Sprite = spr_sonic_peelout;
						}	
						animation_play(Sprite, round(max(1, 8 - abs(PeeloutRev))), 0, 0);
					}
					break;
					case AnimSpin:
					{
						if abs(Inertia) < 6
						{
							var Sprite = spr_sonic_spin;
						}
						else
						{
							var Sprite = spr_sonic_spin_fast;
						}
						animation_play(Sprite, round(max(1, 4 - abs(Inertia))), 0, 0);
					}
					break;
					case AnimSpindash:
						animation_play(spr_sonic_spindash, 1, 0, 0);
					break;
					case AnimCrouch:
						animation_play(spr_sonic_crouch, 4, 0, 1);
					break;
					case AnimLookup:
						animation_play(spr_sonic_lookup, 4, 0, 1);
					break;
					case AnimSkid:
						animation_play(spr_sonic_skid, 6, 0, 2);
					break;
					case AnimPush:
						animation_play(spr_sonic_push, round(max(1, 8 - abs(Inertia)) * 4), 0, 0);
					break;
					case AnimHurt:
						animation_set(spr_sonic_hurt, 0);
					break;
					case AnimDeath:
						animation_set(spr_sonic_death, 0);
					break;	
					case AnimDrown:
						animation_set(spr_sonic_drown, 0);
					break;
					case AnimBalance:
						animation_play(spr_sonic_balance, 16, 0, 0);
					break;
					case AnimBalanceFlip:
						animation_play(spr_sonic_balance_flip, 16, 0, 0);
					break;
					case AnimBalancePanic:
						animation_play(spr_sonic_balance_panic, 4, 0, 0);
					break;
					case AnimBalanceTurn:
						animation_set(spr_sonic_balance_turn, 0);
					break;
					case AnimSpring:
					{
						if !(--AnimSpringTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_set(spr_sonic_spring, 0);
						}
					}
					break;
					case AnimActEnd:
						animation_play(spr_sonic_actend, 12, 0, 0);
					break;
					case AnimAirSpin:
						animation_play(spr_sonic_airspin, 3, 0, 0);
					break;
					case AnimBreathe:
					{
						if !(--AnimBreatheTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_set(spr_sonic_breathe, 0);
						}
					}
					break;
					case AnimDropdash:
						animation_play(spr_sonic_dropdash, 1, 0, 0);
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
						animation_play(spr_supersonic_transform, [6, 6, 3, 3, 3], 0, 3);
					break;
					case AnimIdle:
						animation_play(spr_supersonic_idle, 8, 0, 0);
					break;
					case AnimMove:	
					{
						var RunSpeed = IsUnderwater ? 6 : 8;
						if abs(Inertia) < RunSpeed
						{
							var Sprite = spr_supersonic_walk;
						}
						else
						{
							var Sprite = spr_supersonic_fly;
						}
						animation_play(Sprite, round(max(1, 8 - abs(Inertia))), 0, 0);
					}
					break;
					case AnimPeelout: 
					{
						if abs(PeeloutRev) < 6
						{
							var Sprite = spr_supersonic_walk;
						}
						else
						{
							var Sprite = spr_supersonic_fly;
						}
						animation_play(Sprite, round(max(1, 8 - abs(PeeloutRev))), 0, 0);
					}
					break;
					case AnimSpin:
					{
						if abs(Inertia) < 6
						{
							var Sprite = spr_sonic_spin;
						}
						else
						{
							var Sprite = spr_sonic_spin_fast;
						}
						animation_play(Sprite, round(max(1, 4 - abs(Inertia))), 0, 0);
					}
					break;
					case AnimSpindash:
						animation_play(spr_sonic_spindash, 1, 0, 0); 
					break;
					case AnimCrouch:
						animation_play(spr_supersonic_crouch, [4, 8, 8, 8, 8], 0, 1);
					break;
					case AnimLookup:
						animation_play(spr_supersonic_lookup, [4, 8, 8, 8, 8], 0, 1);
					break;
					case AnimSkid:
						animation_play(spr_supersonic_skid, 3, 0, 4);
					break;
					case AnimPush:
						animation_play(spr_supersonic_push, round(max(1, 8 - abs(Inertia)) * 4), 0, 0);
					break;
					case AnimHurt:
						animation_set(spr_supersonic_hurt, 0);
					break;
					case AnimDeath:
						animation_set(spr_supersonic_death, 0);
					break;	
					case AnimDrown:
						animation_set(spr_supersonic_drown, 0);
					break;
					case AnimBalance:
						animation_play(spr_supersonic_balance, 10, 0, 0);
					break;
					case AnimSpring:
					{
						if !(--AnimSpringTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_play(spr_supersonic_spring, 4, 0, 0);
						}
					}
					break;
					case AnimAirSpin:
						animation_play(spr_supersonic_airspin, 3, 0, 0);
					break;
					case AnimBreathe:
					{	
						if !(--AnimBreatheTime)
						{
							Animation = AnimMove;
						}
						else
						{
							animation_set(spr_supersonic_breathe, 0);
						}
					}
					break;
					case AnimDropdash:
						animation_play(spr_sonic_dropdash, 1, 0, 0);
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
					var FrameData = 
					[
						128, 8, 8, 64, 8, 8, 72, 128, 8, 
						8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
					];
					animation_play(spr_tails_idle, FrameData, 0, 7);
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
					animation_play(Sprite, round(max(1, 8 - abs(Inertia))), 0, 0);
				}
				break;
				case AnimSpin:
					animation_play(spr_tails_roll, 2, 0, 0);
				break;
				case AnimSpindash:
					animation_play(spr_tails_spindash, 1, 0, 0); 
				break;
				case AnimCrouch:
					animation_set(spr_tails_crouch, 0);
				break;
				case AnimLookup:
					animation_set(spr_tails_lookup, 0);
				break;
				case AnimSkid:
					animation_play(spr_tails_skid, 8, 0, 0);
				break;
				case AnimFly:
					animation_set(spr_tails_fly, 0);
				break;
				case AnimFlyTired:
					animation_play(spr_tails_fly_tired, 8, 0, 0);
				break;
				case AnimSwim:
					animation_play(spr_tails_swim, Ysp < 0 ? 4 : 8, 0, 0);
				break;
				case AnimSwimTired:
					animation_play(spr_tails_swim_tired, 8, 0, 0)
				break;
				case AnimHurt:
					animation_set(spr_tails_hurt, 0);
				break;
				case AnimDeath:
				case AnimDrown:
					animation_set(spr_tails_death, 0);
				break;
				case AnimSpring:
				{
					if !(--AnimSpringTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_tails_spring, 4, 0, 0);
					}
				}
				break;
				case AnimPush:
					animation_play(spr_tails_push, round(max(1, 8 - abs(Inertia)) * 4), 0, 0);
				break;
				case AnimActEnd:
					animation_play(spr_tails_actend, 16, 0, 1);
				break;
				case AnimBalance:
					animation_play(spr_tails_balance, 20, 0, 0);
				break;
				case AnimTransform:
					animation_play(spr_tails_transform, [6, 3, 3], 0, 1);
				break;
				case AnimAirSpin:
					animation_play(spr_tails_airspin, 3, 0, 0);
				break;
				case AnimBreathe:
				{
					if !(--AnimBreatheTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_set(spr_tails_breathe, 0);
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
					var FrameData = 
					[
						300, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 
						30, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,  6, 6, 6, 6, 6, 
						6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 6, 6
					]
					animation_play(spr_knuckles_idle, FrameData, 0, 0);	
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
					animation_play(Sprite, round(max(1, 8 - abs(Inertia))), 0, 0);
				}
				break;
				case AnimSpin:
					animation_play(spr_knuckles_roll, round(max(1, 4 - abs(Inertia))), 0, 0);
				break;
				case AnimSpindash:
					animation_play(spr_knuckles_spindash, 1, 0, 0); 
				break;
				case AnimCrouch:
					animation_play(spr_knuckles_crouch, 6, 0, 1);
				break;
				case AnimLookup:
					animation_play(spr_knuckles_lookup, 6, 0, 1);
				break;
				case AnimSkid:
				{
					if !Input.Left and !Input.Right and !(--AnimKnuxSkid) or Inertia == 0
					{
						Animation = AnimMove;
					}
					else
					{
						animation_play(spr_knuckles_skid, 4, 0, 3);
					}
				}
				break;
				case AnimHurt:
					animation_set(spr_knuckles_hurt, 0);
				break;
				case AnimDeath:
					animation_set(spr_knuckles_death, 0);
				break;
				case AnimDrown:
					animation_set(spr_knuckles_drown, 0);
				break;
				case AnimGlide:
					animation_set(spr_knuckles_glide, GlideFrame);
				break;
				case AnimGlideFall:
					animation_play(spr_knuckles_drop, 6, 0, 1);
				break;			
				case AnimSlide:
					animation_set(spr_knuckles_glideground, 0);
				break;
				case AnimDropStand:
				{
					if !(--AnimKnuxGetUp)
					{
						Animation = Input.Down ? AnimCrouch : AnimIdle;
					}
					else
					{
						animation_set(spr_knuckles_crouch, 1);
					}
				}
				break;
				case AnimGlideStand:
				{
					if !(--AnimKnuxGetUp)
					{
						Animation = AnimIdle;
					}
					else
					{
						animation_set(spr_knuckles_glidestand, 0);
					}
				}
				break;
				case AnimClimb:
				{
					if Input.Down
					{
						var Speed = -4;
					}
					else if Input.Up
					{
						var Speed = 4;
					}
					else
					{
						var Speed = 0;
					}
					animation_play(spr_knuckles_climb, Speed, 0, 0);
				}
				break;
				case AnimClimbLedge:
					animation_play(spr_knuckles_climbering, 6, 0, 3);
				break;
				case AnimClimbFall:
					animation_set(spr_knuckles_drop, 1);
				break;
				case AnimPush:
					animation_play(spr_knuckles_push, round(max(1, 8 - abs(Inertia))), 0, 0);
				break;
				case AnimSpring:
				{
					if !(--AnimSpringTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_set(spr_knuckles_spring, 0);
					}
				}
				break;
				case AnimBalance:
					animation_play(spr_knuckles_balance, [8, 8, 8, 8, 8, 8, 60, 12, 12, 8, 8, 8], 0, 9);
				break;
				case AnimTransform:
					animation_play(spr_knuckles_transform, [6, 3, 3], 0, 1);
				break;
				case AnimActEnd:
					animation_play(spr_knuckles_actend, [6, 18, 6, 6], 0, 4);
				break;
				case AnimAirSpin:
					animation_play(spr_knuckles_airspin, 3, 0, 0);
				break;
				case AnimBreathe:
				{
					if !(--AnimBreatheTime)
					{
						Animation = AnimMove;
					}
					else
					{
						animation_set(spr_knuckles_breathe, 0);
					}
				}
				break;
				default: break;
			}
		}
		break;
	}
}