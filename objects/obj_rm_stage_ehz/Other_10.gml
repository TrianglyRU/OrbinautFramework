// Use S2 physics (reverts back to default on room end)
global.player_physics = PHYSICS.S2;

setup_stage("EMERALD HILL", 0, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], rm_level_select, GAME_PROGRESS_MAX);
drp_room_icon = "stage_ehz";

sprite_set_animation(spr_asset_ehz_1, 4);
sprite_set_animation(spr_asset_ehz_2, 2);
sprite_set_animation(spr_asset_ehz_3, 4);
sprite_set_animation(spr_asset_ehz_4, 8);
sprite_set_animation(spr_asset_ehz_5, 2);

var _y0 = 16;
var _y1 = sprite_get_height(spr_bg_ehz_5) + _y0;
var _y2 = sprite_get_height(spr_bg_ehz_6) + _y1;
var _y3 = sprite_get_height(spr_bg_ehz_7) + _y2;
var _y4 = sprite_get_height(spr_bg_ehz_8) + _y3;

bg_convert("Clouds", 0.015625, 0, 0, 0, 0);
bg_convert("Ocean", 0.015625, 0, 0, 0, 0);
bg_convert("Hills_1", 0.0625, 0, 0, 0, 0);
bg_convert("Hills_2", 0.09375, 0, 0, 0, 0);
bg_convert_scaled("Field_1", _y0 / 128, 0, 0, 0, (_y1 - 1) / 128, 1, -1, 0);
bg_convert_scaled("Field_2", _y1 / 128, 0, 0, 0, (_y2 - 2) / 128, 2, -1, 0);
bg_convert_scaled("Field_3", _y2 / 128, 0, 0, 0, (_y3 - 3) / 128, 3, -1, 0);
bg_convert_scaled("Field_4", _y3 / 128, 0, 0, 0, (_y4 - 4) / 128, 4, -1, 0);

deform_layers(["Ocean"], 0, 0.125, DEFORM_DATA.EHZ, undefined);

pal_load(PALETTE_MAP_PLAYER, spr_pal_player);
pal_load(PALETTE_MAP_LEVEL, spr_pal_ehz_level);
pal_set_rotation(PALETTE_MAP_LEVEL, [0, 1, 2, 3], 8, 1, 4);

layer_script_begin_draw("Ocean", function()
{
	pal_draw(PALETTE_MAP_LEVEL);
});

layer_script_end_draw("Ocean", function()
{
	pal_draw_previous();
});

layer_script_begin_draw("Chunks_Back", function()
{
	pal_draw(PALETTE_MAP_LEVEL);
});

layer_script_end_draw("Chunks_Back", function()
{
	pal_draw_stop();
});