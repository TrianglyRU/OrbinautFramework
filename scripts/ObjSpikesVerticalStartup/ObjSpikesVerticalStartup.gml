function ObjSpikesVerticalStartup()
{
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypePause);
}