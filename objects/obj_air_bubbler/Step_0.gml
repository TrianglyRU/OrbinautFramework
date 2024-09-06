if !c_stage.water_enabled || y < c_stage.water_level || !obj_is_visible()
{
	exit;
}

switch state
{
	case AIRBUBBLER_STATE_IDLE:
	
		if --wait_time != 0
		{
			break;
		}
		
		type_array_to_use = irandom_range(0, 3);
		bubbles_to_spawn = irandom_range(1, 6);
		bubble_id_large = irandom_range(0, bubbles_to_spawn - 1);
		bubble_id = 0;
		state = AIRBUBBLER_STATE_PRODUCE;
		
		// fallthrough to AIRBUBBLER_STATE_PRODUCE
		
	case AIRBUBBLER_STATE_PRODUCE:
	
		if --random_time > 0
		{
			break;
		}
		
		// Generate a large bubble by default
		var _bubble_type = BUBBLE_TYPE_LARGE;
		
		if bubble_id != bubble_id_large || ((wait_cycle + 1) % (CyclesToSkip + 1)) == 1
		{
			_bubble_type = type_array[type_array_to_use][bubble_id];
		}
		
		var _obj = instance_create(x + irandom_range(-8, 7), y, obj_bubble, 
		{
			BubbleType: _bubble_type,
			WobbleDirection: choose(DIRECTION.NEGATIVE, DIRECTION.POSITIVE)
		});
		
		// For large bubbles, play animation starting from a second frame
		with _obj
		{
			ani_update_frame(_bubble_type == BUBBLE_TYPE_LARGE);
		}
		
		if --bubbles_to_spawn > 0
		{
			bubble_id++;
			random_time = irandom_range(0, 31);
			break;
		}
		
		wait_time = m_air_bubbler_set_delay();
		wait_cycle++;
		state = AIRBUBBLER_STATE_IDLE;

	break;
}