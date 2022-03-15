/// @description Main
// You can write your code in this editor
	
	if !State
	{
		// Increment state
		State++;
	}
	
	// Start movement on the second frame
	else
	{
		if (++Timer) < 22
		{
			switch SparkleID
			{
				case 0:
				{
					x -= 2;
					y -= 2;
				}
				break;
				case 1:
				{
					x -= 2;
					y += 2;
				}
				break;
				case 2:
				{
					x += 2;
					y -= 2;
				}
				break;
				case 3:
				{
					x += 2;
					y += 2;
				}
				break;
			}
		}
		else
		{
			instance_destroy();
		}
	}