visible = instance_exists(obj_water) &&  y >= obj_water.y;

if !visible || !instance_is_drawn()
{
	return;
}

switch state
{
	case AIR_BUBBLER_STATE.IDLE:
	
		if --wait_time == 0
		{
			type_array_to_use = irandom_range(0, 3);
			bubbles_to_spawn = irandom_range(1, 6);
			bubble_id_large = irandom_range(0, bubbles_to_spawn - 1);
			bubble_id = 0;
			state = AIR_BUBBLER_STATE.PRODUCE;
			
			// fallthrough to PRODUCE
		}
		else
		{
			break;
		}
		
	case AIR_BUBBLER_STATE.PRODUCE:
		
		if --random_time > 0
		{
			break;
		}
		
		var _bubble_type;
		
		if bubble_id == bubble_id_large && wait_cycle % iv_rate == 0
		{
			_bubble_type = BUBBLE.LARGE;
		}
		else
		{
			_bubble_type = type_array[type_array_to_use][bubble_id];
		}
		
		with instance_create(x + irandom_range(-8, 7), y, obj_bubble, { bubble_type: _bubble_type })
		{
			wobble_direction = choose(-1, 1);
		}
		
		if --bubbles_to_spawn > 0
		{
			bubble_id++;
			random_time = irandom_range(0, 31);
		}
		else
		{
			wait_time = get_random_delay();
			wait_cycle++;
			state = AIR_BUBBLER_STATE.IDLE;
		}
		
	break;
}