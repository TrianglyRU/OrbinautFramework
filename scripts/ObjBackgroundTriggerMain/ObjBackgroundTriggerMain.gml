function ObjBackgroundTriggerMain()
{
	// Check for overlap
	if object_check_overlap(TypeTrigger)
	{
		if !State
		{
			// Switch to a new background
			if !BGType
			{
				
			}
			
			// Switch to previous background
			else
			{
				
			}
			
			// Update flags
			BGType = !BGType;
			State += 1;
		}
	}
	else if State
	{
		State--;
	}
}