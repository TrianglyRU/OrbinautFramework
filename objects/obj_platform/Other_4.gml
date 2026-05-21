// Find objects to sync
collision_rectangle_list(bbox_left, bbox_top - SYNC_SEARCH_TOLERANCE, bbox_right - 1, bbox_bottom - 1, obj_gameobject, false, true, synced_objects, false);

// Update position on load
event_perform(ev_step, ev_step_normal);