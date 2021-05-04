/// @description Scripts Event
// You can call your scripts in this editor
	
	if Stage.ActID != 0 and Game.TransitionShiftPlayer[0] != 0
	{
		object_set_depth(Player, false);
		visible = true;
	}
	