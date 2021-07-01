/// @description Insert description here
// You can write your code in this editor
	if State
	{
	}
	else
	{
		if Input.ABCPress
		{
			State = 1;
			fade_perform(to, white, 1);
		}
		else if Input.StartPress
		{
			State = 2;
			fade_perform(to, white, 1);
		}
	}