/// @description Insert description here
// You can write your code in this editor
	
	if instance_exists(Orbinaut)
	{
		show_debug_message("Array Size: " + string(array_length(Orbinaut.Obj_ChildrenIDs)));
		show_debug_message("Orbs Exist: " + string(instance_number(OrbinautOrb)));
	}
	else
	{
		show_debug_message("No Orbinaut");
	}