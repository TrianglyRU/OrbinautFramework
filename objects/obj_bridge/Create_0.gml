	// Inherit the parent event
event_inherited();
	
log_size = 16;
log_size_half = floor(log_size / 2);
active_log = 0;
max_dip = 0;
angle = 0;
log_amount = floor(sprite_width / log_size);
	
for (var i = 0; i < log_amount; i++) 
{
	log_x[i] = x - log_amount * log_size_half + log_size * i + log_size_half
	log_y[i] = y;
	dip[i] = i < floor(log_amount / 2) ? (i + 1) * 2 : (log_amount - i) * 2;
}
	
// Player should not be able to balance on this object
data_solid.no_balance = true;
	
obj_set_solid(log_amount * log_size_half, log_size_half);
obj_set_priority(4);
obj_set_culling(CULLING.DISABLE);