if state != LAMP_STATE_ROTATE
{
	exit;
}

if angle < 720
{
	angle += 22.5;
	x = obj_oscillate_x(rot_x, angle, radius, 1, 180);
	y = obj_oscillate_y(rot_y, angle, radius, 1, 180);
}
else
{
	m_starpost_lamp_activate();
}