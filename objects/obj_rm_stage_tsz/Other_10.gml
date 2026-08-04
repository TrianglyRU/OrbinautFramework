setup_stage("TRIAL STADIUM", ACT_SINGLE, snd_bgm_tsz, [spr_animal_cucky, spr_animal_picky], rm_level_select, GAME_PROGRESS_MAX);
drp_room_icon = "stage_tsz";

sprite_set_animation(spr_asset_tsz, 12);

var _fy = 0.056179775;

bg_convert("Discs_1", 0.375, _fy, -0.100, 0, 0);
bg_convert("Discs_2", 0.340, _fy, -0.025, 0, 0);
bg_convert("Generators_Top", 0.300, _fy, 0, 0, 0);
bg_convert("Generators_Bottom", 0.300, _fy, 0, 0, 0);
bg_convert_scaled("Sky", 0.305, _fy, 0, 0, 0.2, 8, -1, 0);
bg_convert("Buildings", 0.225, _fy, 0, 0, 0);
bg_convert("Wall", 0.125, _fy, 0, 0, 0);
bg_convert_scaled("Lights", 0.130, _fy, 0, 0, 0.230, 2, -1, 0);
bg_convert_scaled("Tubes", 0.280, _fy, 0, 0, 0.750, 8, -1, 0);
bg_convert_scaled("Water_Surface", 0.300, _fy, 0, 0, 1.000, 4, obj_water.ystart, 0);

deform_depth("Water_Surface", _fy, -0.25,  undefined, DEFORM_DATA.LZ_BG);
deform_layers(["Sprites_Front", "Tiles_Front", "Sprites_Back", "Tiles_Back", "Tiles_Waterfalls"], 1, -0.5, undefined, DEFORM_DATA.AIZ_FG_WATER);

pal_load(PALETTE_MAP_OBJECT, undefined, spr_pal_tsz_objects_b);
pal_load(PALETTE_MAP_PLAYER, spr_pal_player, spr_pal_player_tsz_b);
pal_load(PALETTE_MAP_LEVEL, spr_pal_tsz_level_a, spr_pal_tsz_level_b);

pal_set_rotation(PALETTE_MAP_LEVEL, [0, 1, 2, 3], 6, 1, 4);
pal_set_rotation(PALETTE_MAP_LEVEL, [4], 8, 1, 6);
pal_set_rotation(PALETTE_MAP_LEVEL, [5], 4, 1, 6);
pal_set_rotation(PALETTE_MAP_LEVEL, [6], 12, 1, 15);

layer_script_begin_draw(layer_get_id("Tubes"), function()
{
	pal_draw(PALETTE_MAP_LEVEL);
});

layer_script_end_draw(layer_get_id("Sprites_Back"), function()
{
	pal_draw(PALETTE_MAP_OBJECT);
});

layer_script_begin_draw(layer_get_id("Tiles_Front"), function()
{
	pal_draw(PALETTE_MAP_LEVEL);
});

layer_script_end_draw(layer_get_id("Sprites_Front"), function()
{
	pal_draw(PALETTE_MAP_OBJECT);
});

// We want GUI to be affected by the underwater palette, so we don't reset the shader by calling pal_draw_stop() here
