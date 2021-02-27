function menu_get_character(ID)
{
	switch ID 
	{
		default:		   return "SONIC"	 break;
		case CharTails:	   return "TAILS"	 break;
		case CharKnuckles: return "KNUCKLES" break;
	}
}