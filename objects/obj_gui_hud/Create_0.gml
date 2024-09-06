// Allow only one instance of this object at a time
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}

timer_string = "";
dynamic_frame = 0;
score_offset = 0;
time_offset  = 0;
rings_offset = 0;
lives_offset = 0;
local_timer = 0;
update_timer = true;