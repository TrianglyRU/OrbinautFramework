/// @description Insert description here
// You can write your code in this editor
	
	x += Xsp;
	y += Ysp;
	
	if x < Screen.CameraX - 32 or x > Screen.CameraX + Screen.Width  + 32
	or y < Screen.CameraY - 32 or y > Screen.CameraY + Screen.Height + 32
	{
		instance_destroy();
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		object_damage(false, false, false);
	}