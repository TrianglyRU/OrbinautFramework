function MenuLoadGamedata()
{	
	// Load save data	
	for (var i = 0; i < 4; i++)
	{
		Saveslot[i] = gamedata_load(i);
	}
}