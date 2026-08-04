#macro GAME_PROGRESS_GHZ 200

// Use S1 physics (reverts back to default on room end)
global.player_physics = PHYSICS.S1;

setup_stage("GREEN HILL", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], rm_stage_ehz_1, GAME_PROGRESS_GHZ);
drp_room_icon = "stage_ghz";

sprite_set_animation(spr_asset_ghz_1, 16);
sprite_set_animation(spr_asset_ghz_2, 8);

bg_convert("Clouds_1", 0.375, -0.03125, -1, 0, 0);
bg_convert("Clouds_2", 0.375, -0.03125, -0.5, 0, 0);
bg_convert("Clouds_3", 0.375, -0.03125, -0.25, 0, 0);
bg_convert("Mountains_1", 0.375, -0.03125, 0, 0, 0);
bg_convert("Mountains_2", 0.5, -0.03125, 0, 0, 0);
bg_convert_scaled("Lake", 0.5, -0.03125, 0, 0, 1, 1, -1, 0);

pal_load(PALETTE_MAP_PLAYER, spr_pal_player);
pal_load(PALETTE_MAP_LEVEL, spr_pal_ghz_level);
pal_set_rotation(PALETTE_MAP_LEVEL, [0, 1, 2, 3], 6, 1, 4);

layer_script_begin_draw("Mountains_2", function()
{
	pal_draw(PALETTE_MAP_LEVEL);
});

layer_script_end_draw("Chunks_Back", function()
{
	pal_draw_stop();
});