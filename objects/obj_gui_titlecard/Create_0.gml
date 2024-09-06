// Allow only one instance of this object at a time
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

timer = 0;
offset_zone = 288;
offset_zonename = 256;
offset_act = 320;
offset_banner = -224;
speed_x = 16;
speed_y = 16;
fade_perform_black(FADEROUTINE.OUT, 0);