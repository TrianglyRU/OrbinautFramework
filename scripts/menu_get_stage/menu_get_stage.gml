function menu_get_stage(RoomID)
{
	switch RoomID
	{
		default:   return ["MBZ", 1] break;
		case MBZ2: return ["MBZ", 2] break;
		case HHZ:  return ["HHZ", 2] break;
	}
}