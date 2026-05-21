/// @self
/// @description Creates an animator instance for this object.
function event_animator()
{
	new ConstAnimator(id);
}

function ConstAnimator(_inst_id) constructor
{
	if _inst_id.animator != noone
	{
		return;
	}
	
	inst_id = _inst_id;
	inst_id.animator = self;
	
	play_count = 0;
	duration = 0;
	timer = 0;
	loopback = 0;
	
	/// @function start(_sprite_id, _start_frame, _loopback, _frame_duration)
	start = function(_sprite_id, _start_frame, _loopback, _frame_duration)
	{
		if !instance_exists(inst_id)
		{
			return;
		}
		
		inst_id.image_speed = 0;
		inst_id.image_index = _start_frame;
		inst_id.sprite_index = _sprite_id;
		duration = _frame_duration;
		timer = _frame_duration;
		loopback = _loopback;
		play_count = 0;
	}
	
	/// @function restart
	restart = function(_clear_play_count = true)
	{
		if !instance_exists(inst_id)
		{
			return;
		}
		
		inst_id.image_speed = 0;
		inst_id.image_index = 0;
		timer = duration;
		
		if _clear_play_count
		{
			play_count = 0;
		}	
	}
	
	/// @function clear(_image_index)
	clear = function(_image_index)
	{
		if !instance_exists(inst_id)
		{
			return;
		}
		
		inst_id.image_speed = 0;
		inst_id.image_index = _image_index;
		duration = 0;
		timer = 0;
		play_count = 0;
	}
	
	/// @function update()
	update = function()
	{
		if inst_id.image_speed != 0 || duration <= 0 || timer <= 0
		{
			return;
		}
		
		if --timer == 0
		{
			if inst_id.image_index == inst_id.image_number - 1
			{
				play_count++;
			
				if loopback == inst_id.image_index
				{
					timer = -1;
				}
				else
				{
					inst_id.image_index = loopback;
					timer = duration;
				}
			}
			else
			{
				inst_id.image_index++;
				timer = duration;
			}
		}
	}
}