function ObjSpikesStartup()
{
    // Set object properties
    object_set_unload(TypePause);
    object_set_depth(Player, 0);
    object_set_solidbox(16, 16, false);
}