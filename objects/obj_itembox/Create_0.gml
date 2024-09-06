#macro ITEMBOX_STATE_IDLE 0
#macro ITEMBOX_STATE_FALL 1
#macro ITEMBOX_STATE_DESTROYED 2

// Inherit the parent event
event_inherited();

state = ITEMBOX_STATE_IDLE;
vel_y = 0;
draw_card = false;

switch Type
{
    case "Eggman Mark":          card_index = 1; break;
    case "Super Ring":           card_index = 2; break;
    case "Power Sneakers":       card_index = 3; break;
    case "Shield":               card_index = 4; break;
    case "Bubble Shield":        card_index = 5; break;
    case "Fire Shield":          card_index = 6; break;
    case "Lightning Shield":     card_index = 7; break;
    case "Invincible":           card_index = 8; break;
    case "1UP":                  card_index = 9; break;
 
    default:
        card_index = 0;
}

obj_set_hitbox(16, 16);
obj_set_solid(15, 15);
obj_set_priority(4);
obj_set_culling(CULLING.RESPAWN);
ani_start(sprite_index, card_index > 0 ? 3 : 1, 0, 0, [0, 1]);