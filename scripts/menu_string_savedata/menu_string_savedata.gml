function menu_string_savedata(Slot)
{
	var data = Game.SaveSlot[Slot];
	var str = "SAVE SLOT " + string(Slot + 1) + ": ";
	if Saving and MenuOption - 1 = Slot
	{
		return str + get_char_name(CharID);
	}
	else
	{
		if data = 0 
		{
			return str + "NEW SAVE";
		}
		else
		{
			var stage = get_stage(data[1]);
			return str + get_char_name(data[0]) + " " + stage[0] + " " + string(stage[1]);
		}
	}
}