// Inherit the parent event
event_inherited();
	
vel_y = -3;

if ScoreCombo < 4
{
	image_index = ScoreCombo;
}
else
{
	image_index = ScoreCombo < 16 ? 4 : 5;
}

obj_set_priority(1);
obj_set_culling(CULLING.REMOVE);