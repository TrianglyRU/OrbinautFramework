function ObjBackgroundTriggerMain()
{
	if object_check_touch(TypeTrigger)
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
}