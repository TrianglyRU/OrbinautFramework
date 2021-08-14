/// @description
// You can write your code in this editor

	// Exit if not from Special Stage
	if !Game.SpecialState or RoomState == 2
	{
		exit;
	}
	
	// Get screen centre
	var CentreX	= Game.ResolutionWidth / 2;
	var CentreY = Game.ResolutionHeight / 2;
	
	var ShiftY = floor(Offset[3]);
	
	if Game.SpecialState == 1
	{
		draw_sprite(tex_chargot,	  Game.Character, CentreX + Offset[0], CentreY - 44 + ShiftY);
		draw_sprite(tex_chaosemerald, 0,			  CentreX + Offset[1], CentreY - 20 + ShiftY);
	}
	else if Game.SpecialState == 2
	{
		draw_sprite(tex_special, 0, CentreX + Offset[0], CentreY - 20 + ShiftY);
		draw_sprite(tex_stage,   0, CentreX + Offset[1], CentreY - 20 + ShiftY);
	}
	
	draw_sprite(spr_results_score,     0, CentreX - 80 + Offset[4], CentreY + 32);
	draw_sprite(spr_results_score,     0, CentreX - 80 + Offset[4], CentreY + 32);
	draw_sprite(spr_results_ringbonus, 0, CentreX - 80 + Offset[5], CentreY + 48);
	
	if RenderFlag
	{
		for (var i = 0; i < Game.Emeralds; i++)
		{
			draw_sprite(tex_emerald_obj, RenderFlag ? i : 7, CentreX - 58 + 20 * i, CentreY);
		}
	}