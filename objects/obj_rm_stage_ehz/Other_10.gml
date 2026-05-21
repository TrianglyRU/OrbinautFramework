// Use S2 physics (reverts back to default on room end)
global.player_physics = PHYSICS.S2;

setup_stage("EMERALD HILL", 0, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], rm_level_select, GAME_PROGRESS_MAX);
drp_room_icon = "stage_ehz";

tile_load_data(spr_collision_s2);

bg_convert("Clouds", 0.015625, 0, 0, 0, 0);
bg_convert("Hills_1", 0.0625, 0, 0, 0, 0);
bg_convert("Hills_2", 0.09375, 0, 0, 0, 0);
bg_convert_scaled("Field_1", 0.09375, 0, 0, 0, 0.3515625, 1, -1, 0);
bg_convert_scaled("Field_2", 0.3515625, 0, 0, 0, 1, 3, -1, 0);
	
sprite_set_animation(spr_asset_ehz_1, 4);
sprite_set_animation(spr_asset_ehz_2, 2);
sprite_set_animation(spr_asset_ehz_3, 4);
sprite_set_animation(spr_asset_ehz_4, 8);
sprite_set_animation(spr_asset_ehz_5, 2);

var _bg_layers =
[
	"Clouds"
];
			
deform_layers(_bg_layers, deform_get_data(DEFORM_DATA.EHZ), undefined, 0, 0.125, 80, 111);

pal_load(spr_palette_ehz, undefined);
pal_set_rotation([29, 30, 31, 32], 8, 1, 4);