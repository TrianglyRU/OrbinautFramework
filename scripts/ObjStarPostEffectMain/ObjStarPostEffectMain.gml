function ObjStarPostEffectMain()
{
	if Timer < 128
	{
		Diameter++;
	}
	else if Timer > 472
	{
	    Diameter--;
	}
	
	switch State
	{
		case 0:
		case 2:
		{
			if (++Timer) == 600
			{
				instance_destroy();
			}
			else if Timer > 60
			{
				if !State and object_check_overlap(Hitbox)
				{
					State++;
					fade_perform(FadeTo, ColourBlack, 1);		
				}
			}
		}
		break;
		case 1:
		{
			if fade_check(FadeMax)
			{
				// TODO: send to bonus stage
				State++;
				fade_perform(FadeFrom, ColourBlack, 1);
			}
		}
		break;
	}
}