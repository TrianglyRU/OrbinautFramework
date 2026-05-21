if obj_game.fade_state != FADE_STATE.NONE
{
	return;
}

var _input_press = input_check_pressed(0);

if _input_press.action1
{
    audio_sfx_play_ring();
	
	rings_earned += 10;
    global.player_rings = min(global.player_rings + 10, 999);
	
    if !continue_earned && rings_earned >= 50
    {
        continue_earned = true;
        global.continue_count++;
		
        audio_sfx_play(snd_continue);
    }
}
else if _input_press.action2
{
    var _shield = choose(SHIELD.NORMAL, SHIELD.FIRE, SHIELD.BUBBLE, SHIELD.LIGHTNING);
	
    for (var _i = 0; _i < PLAYER_MAX_COUNT; _i++)
    {
        global.player_shields[_i] = _shield;
    }
	
    switch _shield
    {
        case SHIELD.NORMAL:
            audio_sfx_play(snd_shield);
        break;
		
        case SHIELD.FIRE:
            audio_sfx_play(snd_shield_fire);
        break;
		
        case SHIELD.BUBBLE:
            audio_sfx_play(snd_shield_bubble);
        break;
		
        case SHIELD.LIGHTNING:
            audio_sfx_play(snd_shield_lightning);
        break;
    }
}
else if _input_press.start
{
    audio_bgm_stop(1);
	fade_perform_black(FADE_DIRECTION.OUT, 1, on_fade_return_to_stage);
}