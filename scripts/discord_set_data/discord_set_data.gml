/// @self
/// @description Sets the data displayed in Discord Rich Presence. Requires a configured Application ID for your game, see `scr_fw_game_setup()` script.
/// @param {String|Undefined} upper_text The main (upper) line of text to display. Pass `undefined` if no changes are required.
/// @param {String|Undefined} lower_text The secondary (lower) line of text to display. Pass `undefined` if no changes are required.
/// @param {String|Undefined} large_image_key The key for the main (large) image. Pass `undefined` if no changes are required.
/// @param {String|Undefined} small_image_key The key for the secondary (small) image. Pass `undefined` if no changes are required.
function discord_set_data(_upper_text, _lower_text, _large_image_key, _small_image_key)
{
	if !global.discord_ready
	{
		exit;
	}
	
	if _upper_text != undefined
	{
		global.discord_details = _upper_text;
	}
	
	if _lower_text != undefined
	{
		global.discord_state = _lower_text;
	}
	
	if _large_image_key != undefined
	{
		global.discord_large_image_key = _large_image_key;
	}
	
	if _small_image_key != undefined
	{
		global.discord_small_image_key = _small_image_key;
	}
	
	np_setpresence(global.discord_state, global.discord_details, global.discord_large_image_key, global.discord_small_image_key);
}
