#macro SPECIALSTAGE_STATE_IDLE 0
#macro SPECIALSTAGE_STATE_EMERALD 1
#macro SPECIALSTAGE_STATE_RESULTS 2

state = SPECIALSTAGE_STATE_IDLE;

bg_set_colour(c_white);
bg_add_layer(spr_special_bg_layer0, 0, 240, 0, 0, 0, 0, 0, 0);
bg_add_layer(spr_special_bg_layer1, 0, 62, 113, 0, -0.05, 0, 0, 0);

dist_set_bg(dist_get_data(EFFECTDATA.LBZ1), [], 0.25, 144, 239);
discord_set_data("SPECIAL STAGE", "", "", undefined);

fade_perform_white(FADEROUTINE.IN, 1);
audio_play_bgm(bgm_special);