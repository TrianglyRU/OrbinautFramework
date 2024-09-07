#region MACRO

#macro ENGINE_CULLING_ADD_WIDTH 320
#macro ENGINE_CULLING_ADD_HEIGHT 288
#macro ENGINE_CULLING_ROUND_VALUE 128
#macro ENGINE_PLAYER_MAX_COUNT 8
#macro ENGINE_ANGLE_MAX_RAW 256
#macro ENGINE_ANGLE_MAX_DEC 360
#macro ENGINE_TILE_SIZE 16
#macro ENGINE_TILE_COUNT 256
#macro ENGINE_AUDIO_STATE_DEFAULT 0
#macro ENGINE_AUDIO_STATE_MUTE 1
#macro ENGINE_AUDIO_STATE_MUTE_BY_JINGLE 2
#macro ENGINE_AUDIO_STATE_STOP 3
#macro ENGINE_AUDIO_BGM_CHANNELS 4
#macro ENGINE_FADE_FLAG_IDLE 0
#macro ENGINE_FADE_FLAG_UPDATE 1
#macro ENGINE_FADE_TIMER_MAX 765
#macro ENGINE_FADE_TIMER_STEP (255 / 7)
#macro ENGINE_PALETTE_MAX_SLOTS 256
#macro ENGINE_COLLISION_TOUCH_NONE 0
#macro ENGINE_COLLISION_TOUCH_TOP 1
#macro ENGINE_COLLISION_TOUCH_BOTTOM 2
#macro ENGINE_COLLISION_TOUCH_LEFT 3
#macro ENGINE_COLLISION_TOUCH_RIGHT 4
#macro ENGINE_RENDERER_HORIZONTAL_BUFFER 8
#macro ENGINE_RENDERER_DRAW_PRIORITY 16000
#macro ENGINE_INPUT_GAMEPAD_DEADZONE 0.15
#macro ENGINE_INPUT_MAX_DEVICE_COUNT 4  // Keyboard and first gamepad slot are treated as one device
#macro ENGINE_TARGET_FPS 60  // This does not define the game speed

#macro STATE_NORMAL 0
#macro STATE_STOP_OBJECTS 1
#macro STATE_PAUSED 2

#macro INPUT_RUMBLE_LIGHT 0.25
#macro INPUT_RUMBLE_MEDIUM 0.5
#macro INPUT_RUMBLE_STRONG 0.75

#macro AUDIO_CHANNEL_JINGLE (ENGINE_AUDIO_BGM_CHANNELS - 1)

#macro ANGLE_INCREMENT (ENGINE_ANGLE_MAX_DEC / ENGINE_ANGLE_MAX_RAW)
#macro ANGLE_EMPTY 1024

#macro CAMERA_COUNT 8

#macro RENDERER_DEPTH_HUD 0
#macro RENDERER_DEPTH_HIGHEST 25

#endregion

#region ENUMS

enum SOLIDCOLLISION
{
    TOP, BOTTOM, LEFT, RIGHT, ANY, PUSH
}

enum SOLIDOBJECT
{
    FULL, TOP, SIDES, ITEMBOX
}

enum SOLIDATTACH
{
    DEFAULT, NONE, RESET_PLAYER
}

enum CULLING
{
    NONE, PAUSEONLY, ACTIVE, REMOVE, DISABLE, ORIGINDISABLE, RESPAWN, ORIGINRESPAWN
}

enum TILELAYER
{
    MAIN, SECONDARY, NONE
}

enum TILEBEHAVIOUR
{
    DEFAULT, ROTATE_90, ROTATE_180, ROTATE_270
}

enum QUADRANT
{
    DOWN = 0, RIGHT = 1, UP = 2, LEFT = 3
}

enum DIRECTION
{
    NEGATIVE = -1, POSITIVE = 1
}

enum FADEROUTINE
{
    IN, OUT, NONE
}

enum FADESTATE
{
    ACTIVE, PLAINCOLOUR, NONE
}

enum FADETYPE
{
    BLACKORDER = 0, BLACKSYNC = 1, DULLORDER = 2, DULLSYNC = 3, WHITEORDER = 4, WHITESYNC = 5, FLASHORDER = 6, FLASHSYNC = 7, NONE = 8
}

enum EFFECTDATA
{
    LZFG, LZBG, AIZFG_WATER, AIZBG_WATER, AIZFG_HEAT, AIZBG_HEAT, LBZ1, LBZ2
}

enum ENEMYTYPE
{
    BADNIK, BOSS
}

#endregion

// COMPONENTS

#region COMMON / FRAMEWORK

/// @method m_local_start
var m_local_start = function()
{
	static _is_initialised = false;
	if _is_initialised 
	{
	    exit;
	}
	
	scr_fw_game_setup();
	game_load_settings();
	random_set_seed(randomise());

	global.sh_fade_active = shader_get_uniform(sh_orbinaut, "u_fade_active");
	global.sh_fade_timer = shader_get_uniform(sh_orbinaut, "u_fade_step");
	global.sh_fade_type = shader_get_uniform(sh_orbinaut, "u_fade_type");
	global.sh_bg_active = shader_get_uniform(sh_orbinaut, "u_bg_active");
	global.sh_bg_pos = shader_get_uniform(sh_orbinaut, "u_bg_pos");
	global.sh_bg_size = shader_get_uniform(sh_orbinaut, "u_bg_size");
	global.sh_bg_scaling = shader_get_uniform(sh_orbinaut, "u_bg_scaling");
	global.sh_bg_offset = shader_get_uniform(sh_orbinaut, "u_bg_offset");
	global.sh_bg_incline_height = shader_get_uniform(sh_orbinaut, "u_bg_incline_height");
	global.sh_bg_incline_step = shader_get_uniform(sh_orbinaut, "u_bg_incline_step");
	global.sh_bg_map_size = shader_get_uniform(sh_orbinaut, "u_bg_map_size");
	global.sh_pal_active = shader_get_uniform(sh_orbinaut, "u_pal_active");
	global.sh_pal_bound = shader_get_uniform(sh_orbinaut, "u_pal_bound");
	global.sh_pal_uv1 = shader_get_uniform(sh_orbinaut, "u_pal_uv1");
	global.sh_pal_texel_size1 = shader_get_uniform(sh_orbinaut, "u_pal_texel_size1");
	global.sh_pal_index1 = shader_get_uniform(sh_orbinaut, "u_pal_index1");
	global.sh_pal_uv2 = shader_get_uniform(sh_orbinaut, "u_pal_uv2");
	global.sh_pal_texel_size2 = shader_get_uniform(sh_orbinaut, "u_pal_texel_size2");
	global.sh_pal_index2 = shader_get_uniform(sh_orbinaut, "u_pal_index2");
	global.sh_pal_tex1 = shader_get_sampler_index(sh_orbinaut, "u_pal_tex1");
	global.sh_pal_tex2 = shader_get_sampler_index(sh_orbinaut, "u_pal_tex2");

	surface_depth_disable(true);
	gpu_set_zwriteenable(false);
	gpu_set_ztestenable(false);
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(0);

	window_set_caption(global.window_name);
	window_set_size(global.init_resolution_w * global.window_scale, global.init_resolution_h * global.window_scale);
	window_center();
	display_reset(0, global.use_vsync);
	
	_is_initialised = true;
}

/// @method m_framework_activate_stopped_objects
m_framework_activate_stopped_objects = function()
{
	var _list_size = ds_list_size(ds_cull_list_pause);
	
	if _list_size != 0
	{
	    for (var i = 0; i < _list_size; i++)
		{
			var _object = ds_cull_list_pause[| i];
			
			instance_activate_object(_object);
			
			if !is_initial_cull
			{
				continue;
			}
			
			with _object
			{
				var _data_culling = data_culling;
				
				if _data_culling.behaviour <= CULLING.ACTIVE || obj_is_visible()
				{
					continue;
				}
				
				if _data_culling.behaviour >= CULLING.RESPAWN
				{
					_data_culling.respawn_flag = true;
				}
				
				// Do not activate back objects outside of the visible camera areas on initial cull
				instance_deactivate_object(id);
			}
		}
		
		ds_list_clear(ds_cull_list_pause);
	}
	
	is_initial_cull = false;
}

// Initialise the framework
m_local_start();

state = STATE_NORMAL; 
allow_pause = false;
frame_counter = 0; 
is_initial_cull = true;
ds_cull_list_pause = ds_list_create();
ring_spill_counter = 0;
layer = layer_create(ENGINE_RENDERER_DRAW_PRIORITY);

#endregion

#region AUDIO

audio =
{
	channel_state: array_create(ENGINE_AUDIO_BGM_CHANNELS, ENGINE_AUDIO_STATE_DEFAULT),
	current_bgm: array_create(ENGINE_AUDIO_BGM_CHANNELS, -1),
	loop_array: [],
	emitter_sfx: audio_emitter_create(),
	bus_sfx: audio_bus_create(),
	emitter_bgm: array_create(ENGINE_AUDIO_BGM_CHANNELS, noone),
	bus_bgm: audio_bus_create()
};

var _audio = audio;
audio_emitter_gain(_audio.emitter_sfx, global.sound_volume);
audio_emitter_bus(_audio.emitter_sfx, _audio.bus_sfx);

for (var i = 0; i < ENGINE_AUDIO_BGM_CHANNELS; i++)
{
	_audio.emitter_bgm[i] = audio_emitter_create();
	audio_emitter_gain(_audio.emitter_bgm[i], global.music_volume);
	audio_emitter_bus(_audio.emitter_bgm[i], _audio.bus_bgm);
}

scr_fw_audio_setup();

#endregion

#region BACKGROUND

background =
{
	back_colour: c_black,
	layer_count: 0,
	scroll_offset: 0,
	min_factor_y: 0,
	parallax_data: [],
	
	// Format: Scale Boundary (Scaling), Scale Boundary (Y-Factor),  Y-Factor Component, Layer Index
	perspective_y_data: [0, 0, 0, undefined]  
};

#endregion

#region CAMERA

var _w = global.init_resolution_w;
var _h = global.init_resolution_h;

// Disable all default cameras
for (var i = 0; i < CAMERA_COUNT; i++)
{
	view_visible[i] = false;
}

// Set the game resolution
surface_resize(application_surface, _w, _h);

// Draw only caemra surfaces
application_surface_draw_enable(false);

camera_data = array_create(CAMERA_COUNT, noone);
view_enabled = true;

// Create a new default camera
camera_new(0, _w, _h, _w, _h);

#endregion

#region COLLISION

/// @method m_local_collision_start
var m_local_collision_start = function()
{
	static _is_initialised = false;
	if _is_initialised
	{
	    exit;
	}

	_is_initialised = true;
	global.generated_tile_width_data = ds_map_create();
	global.generated_tile_height_data = ds_map_create();
	global.generated_tile_angle_data = ds_map_create();

	scr_fw_collision_setup();
}

m_local_collision_start();

collision =
{
	tile_layer: [],
	tile_angle: [],
	tile_width: [],
	tile_height: [],
	ds_sensors: ds_list_create(),
	ds_interact: ds_list_create(),
	ds_solid_size: ds_list_create(),
	ds_solid_side: ds_list_create(),
	ds_solid_push: ds_list_create()
};

#endregion

#region DISTORTION

distortion =
{
	fg_layers: [],
	split_bound: room_height,
	
	// Format: [FG, BG]
	effect: [-1, -1],
	offset_step: [0, 0],
	effect_range: [[-1, -1], [-1, -1]],
	
	// Format: [[FG1, FG2], [BG1, BG2]]
	offset_y: [[0, 0], [0, 0]],
	apply_flag: [[false, false], [false, false]]
}

#endregion

#region FADE

fade =
{
	process_flag: ENGINE_FADE_FLAG_IDLE,
	timer: ENGINE_FADE_TIMER_MAX,
	timer_step: 0,
	frequency_timer: 0,
	frequency_target: 0,
	routine: FADEROUTINE.NONE,
	blend_type: FADETYPE.NONE,
	state: FADESTATE.NONE,
	game_control: false
};

#endregion

#region INPUT

input =
{
	vibration: array_create(ENGINE_INPUT_MAX_DEVICE_COUNT, -1),
	down: ds_list_create(),
	press: ds_list_create(),
	system_device_count: gamepad_get_device_count(),
	pads_array: []
}

var _input = input;

for (var i = 0; i < ENGINE_INPUT_MAX_DEVICE_COUNT; i++)
{
	_input.down[| i] = input_create();
	_input.press[| i] = input_create();
}

for (var i = _input.system_device_count - 1; i >= 0; i--)
{
	gamepad_set_axis_deadzone(i, ENGINE_INPUT_GAMEPAD_DEADZONE);
}

#endregion

#region PALETTE

palette =
{
	split_bound: room_height,
	ds_colours: ds_list_create(),		
	duration: array_create(ENGINE_PALETTE_MAX_SLOTS),
	timer: array_create(ENGINE_PALETTE_MAX_SLOTS),
	end_index: array_create(ENGINE_PALETTE_MAX_SLOTS),
	loop_index: array_create(ENGINE_PALETTE_MAX_SLOTS),
	index: array_create(ENGINE_PALETTE_MAX_SLOTS, 1),
	
	// Format: [Pal1, Pal2]
	colour_data:[[], []]
};

#endregion

#region SPRITE ANIMATOR

sprite_animator =
{
	asset_array: [],
	module_enabled: true
};

#endregion

// OTHER

#region DISCORD RICH PRESENCE

/// @method m_local_discord_start
var m_local_discord_start = function()
{
	static _is_initialised = false;
	if _is_initialised
	{
	    exit;
	}

	global.discord_details = "In-Game";
	global.discord_state = "";
	global.discord_large_image_key = "drp_project_icon";
	global.discord_small_image_key = "";
	global.discord_ready = np_initdiscord(global.discord_app_id, true, 0);
	
	_is_initialised = true;
}

m_local_discord_start();

#endregion