/// @self
/// @description Registers a sprite asset from the room to play its animation in accordance with the game loop.
/// @param {Asset.GMSprite} sprite_id The identifier of the sprite to be registered.
/// @param {Real} duration The duration for which each frame of the animation is displayed, in game steps.
function ani_add_sprite(_spriteid, _duration)
{
	array_push(c_framework.sprite_animator.asset_array, _spriteid, _duration);
}
