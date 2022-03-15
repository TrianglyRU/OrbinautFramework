/// @description Main
// You can write your code in this editor
	
	if object_check_touch(ColTrigger)
	{
		if !State
		{
			// Update background based on BGType
			switch BGType
			{
				case "None": break;
			}
			State += 1;
		}
	}
	else if State
	{
		State--;
	}