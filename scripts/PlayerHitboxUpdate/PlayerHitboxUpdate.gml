function PlayerHitboxUpdate()
{
	// Default hitbox data
	if Animation != AnimCrouch
	{
		HitboxData[0] = [floor(PosX - 8), floor(PosY - RadiusY + 3), floor(PosX + 8), floor(PosY + RadiusY - 3)];
	}
	
	// Crouched hitbox data (do not apply for Tails)
	else if Game.Character != CharTails
	{
		HitboxData[0] = [floor(PosX - 8), floor(PosY - 4), floor(PosX + 8), floor(PosY + 16)];
	}
	
	// Double spin attack hitbox data
	HitboxData[1] = [floor(PosX - 24), floor(PosY - 24), floor(PosX + 24), floor(PosY + 24)];
}