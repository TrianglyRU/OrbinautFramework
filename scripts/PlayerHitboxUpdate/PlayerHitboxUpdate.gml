function PlayerHitboxUpdate()
{
	// Player's hitbox
	if Animation != AnimCrouch
	{
		HitboxData[0] = [floor(PosX - 8), floor(PosY - RadiusY + 3), floor(PosX + 8), floor(PosY + RadiusY - 3)];
	}
	else if global.Character != CharTails
	{
		HitboxData[0] = [floor(PosX - 8), floor(PosY - 4), floor(PosX + 8), floor(PosY + 16)];
	}
	
	// Double spin attack hitbox
	HitboxData[1] = [floor(PosX - 24), floor(PosY - 24), floor(PosX + 24), floor(PosY + 24)];
}