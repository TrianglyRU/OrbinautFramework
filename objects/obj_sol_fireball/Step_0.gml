// If detached from Sol, run hurt routine
if vel_x != 0
{
	m_sol_fireball_hurt();
}

if flip_timer++ == 8
{
	flip_timer = 0;
	image_xscale = -image_xscale;
}

x += vel_x;