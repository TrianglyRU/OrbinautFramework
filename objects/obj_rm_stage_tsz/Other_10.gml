setup_stage("TECH STADIUM", ACT_SINGLE, snd_bgm_tsz, [spr_animal_cucky, spr_animal_picky], rm_level_select, GAME_PROGRESS_MAX);
drp_room_icon = "stage_tsz";

tile_load_data(spr_collision_tsz);

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
bg_convert_scaled("Water_Surface", 0.300, _fy, -0.125, 0, 1.000, 2, obj_water.ystart, 0);

sprite_set_animation(spr_asset_tsz, 12);

var _fg_layers =
[
	"Sprites_Front", "Tiles_Front", "Sprites_Back", "Tiles_Back", "Tiles_Waterfalls"
];
var _bg_layer = "Water_Surface";

var _fg_data = deform_get_data(DEFORM_DATA.AIZ_FG_WATER);
var _bg_data = deform_get_data(DEFORM_DATA.LZ_BG);

deform_layers(_fg_layers, undefined, _fg_data, 1, -0.5, 0, room_height);
deform_depth(_bg_layer, undefined, _bg_data, _fy, -0.25, 0, 347);

pal_load(spr_palette_tsz_a, spr_palette_tsz_b);
pal_set_rotation([29, 30, 31, 32], 6, 1, 4);
pal_set_rotation([33], 8, 1, 6);
pal_set_rotation([34], 4, 1, 6);
pal_set_rotation([35], 12, 1, 15);