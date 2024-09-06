/// @function scr_player_palette
function scr_player_palette()
{
	gml_pragma("forceinline");

	// Initialise the array for colour indices based on PlayerType
	var _colours = [];
	
	switch PlayerType
	{
	    case PLAYER_SONIC:
	        _colours = [0, 1, 2, 3]; 
	    break;
		
	    case PLAYER_TAILS:
	        _colours = [4, 5, 6];
	    break;
		
	    case PLAYER_KNUCKLES:
	        _colours = [7, 8, 9];
	    break;
		
	    case PLAYER_AMY:
	        _colours = [10, 11, 12];
	    break;
	}
	
	var _colour = pal_get_index(_colours[0]);
	var _colour_last = 0;
	var _colour_loop = 0;
	var _duration = 0;
	
	// Exit if the character is the same one as the lead player
	if player_index > 0 && PlayerType == player_get(0).PlayerType
	{
	    exit;
	}

	// Set Super Form animation parameters
	switch PlayerType
	{
	    case PLAYER_SONIC:
		
	        if _colour < 2
	        {
	            _duration = 19;
	        }
	        else if _colour < 7
	        {
	            _duration = 4;
	        }
	        else
	        {
	            _duration = 8;
	        }
			
	        _colour_last = 16;
	        _colour_loop = 7;
			
	    break;
        
	    case PLAYER_TAILS:
		
	        _duration = _colour < 2 ? 28 : 12;
	        _colour_last = 7;
	        _colour_loop = 2;
			
	    break;
        
	    case PLAYER_KNUCKLES:
		
	        if _colour < 2
	        {
	            _duration = 17;
	        }
	        else if _colour < 3
	        {
	            _duration = 15;
	        }
	        else
	        {
	            _duration = 3;
	        }
			
	        _colour_last = 11;
	        _colour_loop = 3;
			
	    break;
        
	    case PLAYER_AMY:
		
	        _colour_last = 13;
	        _colour_loop = 2;
	        _duration = _colour < 2 ? 25 : (_colour < _colour_last ? 7 : 12);
			
	    break;
	}

	// Set regular animation parameters (overwrites Super Form)
	if super_timer <= 0
	{
	    if _colour > 1
	    {
	        if PlayerType == PLAYER_SONIC
	        {
	            _colour_last = 21;
	            _duration = 4;
	        }
	    }
	    else
	    {
	        _colour_last = 1;
	        _duration = 0;
	    }
		
	    _colour_loop = 1;
	}

	// Run the rotation
	pal_run_rotation(_colours, _colour_loop, _colour_last, _duration);
}