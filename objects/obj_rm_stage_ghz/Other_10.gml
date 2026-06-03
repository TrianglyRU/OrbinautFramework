#macro GAME_PROGRESS_GHZ 200

// Use S1 physics (reverts back to default on room end)
global.player_physics = PHYSICS.S1;

setup_stage("GREEN HILL", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], rm_stage_ehz_1, GAME_PROGRESS_GHZ);
drp_room_icon = "stage_ghz";

bg_convert("Clouds_1", 0.375, -0.03125, -1, 0, 0);
bg_convert("Clouds_2", 0.375, -0.03125, -0.5, 0, 0);
bg_convert("Clouds_3", 0.375, -0.03125, -0.25, 0, 0);
bg_convert("Mountains_1", 0.375, -0.03125, 0, 0, 0);
bg_convert("Mountains_2", 0.5, -0.03125, 0, 0, 0);
bg_convert_scaled("Lake", 0.5, -0.03125, 0, 0, 1, 1, -1, 0);

sprite_set_animation(spr_asset_ghz_1, 16);
sprite_set_animation(spr_asset_ghz_2, 8);

pal_load(spr_palette_ghz, undefined);
pal_set_rotation([29, 30, 31, 32], 6, 1, 4);