rings_saved = global.player_rings;
continue_earned = false;

fade_perform_black(FADEROUTINE.IN, 1);
audio_play_bgm(bgm_bonus);
bg_add_layer(spr_bonus_bg_layer0, 0, 512, 0, 0, 0.25, 0.25, 0, 0);
discord_set_data("BONUS STAGE", "", "", undefined);