// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

#macro SWING_CHAIN_SIZE 16

depth = draw_depth(40);
sprite_index = spr_platform_swing_base;
sprite_chain = spr_platform_swing_chain;
sprite_pendulum = spr_platform_swing_bob;
distance = iv_chains * SWING_CHAIN_SIZE - SWING_CHAIN_SIZE * 0.5;
osc_angle = 0;