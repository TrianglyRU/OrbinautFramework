function menu_string_savedata(Slot)
{
	var data = Game.SaveSlot[Slot];
	var str = "SAVE SLOT " + string(Slot + 1) + ": ";
	if Saving and MenuOption - 1 = Slot
	{
		return str + menu_get_character(CharID);
	}
	else
	{
		if data = 0 
		{
			return str + "NEW GAME";
		}
		else
		{
			var stage = menu_get_stage(data[1]);
			return str + menu_get_character(data[0]) + " " + stage[0] + " " + string(stage[1]);
		}
	}
}