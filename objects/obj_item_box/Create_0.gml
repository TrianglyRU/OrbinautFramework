// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum ITEM_BOX_STATE
{
	IDLE,
	IDLE_LANDED,
	FALLING,
	DESTROYED
}

depth = draw_depth(40);
state = ITEM_BOX_STATE.IDLE;
vel_y = 0;
itembox_type = image_index;
animator.start(spr_item_box, min(itembox_type, 1), 0, 2);