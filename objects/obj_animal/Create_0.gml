#macro ANIMAL_STATE_APPEAR 0
#macro ANIMAL_STATE_MOVE 1
#macro ANIMAL_STATE_CAPSULE 2

// Call the inherited event
event_inherited();

state = ReleaseTimer == 0 ? ANIMAL_STATE_APPEAR : ANIMAL_STATE_CAPSULE;
grv = PARAM_GRV_DEFAULT;
vel_x = 0;
vel_y = -4;
vel_x_bounce = 0;
vel_y_bounce = 0;

var _animal_count = array_length(c_stage.animal_set);

if _animal_count > 0
{
    sprite_index = c_stage.animal_set[irandom(_animal_count - 1)];
}

switch sprite_index
{
    case spr_obj_animal_flicky:
	
        vel_x_bounce = 3;
        vel_y_bounce = -4;
		
    break;

    case spr_obj_animal_pocky:
	
        vel_x_bounce = 2;
        vel_y_bounce = -4;
		
    break;

    case spr_obj_animal_cucky:
	
        vel_x_bounce = 2;
        vel_y_bounce = -3;
		
    break;

    case spr_obj_animal_pecky:
	
        vel_x_bounce = 1.5;
        vel_y_bounce = -3;
		
    break;

    case spr_obj_animal_picky:
	
        vel_x_bounce = 1.75;
        vel_y_bounce = -3;
		
    break;

    case spr_obj_animal_ricky:
	
        vel_x_bounce = 2.5;
        vel_y_bounce = -3.5;
		
    break;

    case spr_obj_animal_rocky:
	
        vel_x_bounce = 1.25;
        vel_y_bounce = -1.5;
		
	break;
}

obj_set_priority(7);
obj_set_culling(CULLING.REMOVE);