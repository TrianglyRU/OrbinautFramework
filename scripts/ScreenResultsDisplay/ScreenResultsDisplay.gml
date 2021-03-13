function ScreenResultsDisplay()
{
	if Stage.State = ActStateFinished
	{
		if Stage.StateTimer = 60
		{
			// Погнал писать код результатов давай-давай ура давай ура урааааааа
			
			// как заканчиваем, то выгружаем этап и двигаемся дальше
			{
				Stage.StateTimer = 0;
				Stage.State		 = ActStateUnload;
			}
			
		}
	}
}