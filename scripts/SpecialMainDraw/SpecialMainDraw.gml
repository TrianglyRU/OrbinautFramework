function SpecialMainDraw()
{
	// Exit if not coming from a Special Stage, or fading out
	if !Game.SpecialState or RoomState == 3
	{
		exit;
	}
	
	// Get screen centre
	var CentreX	= Game.Width / 2;
	var CentreY = Game.Height / 2;
	
	var ShiftY = floor(Offset[3]);
	
	// Win messages
	if Game.SpecialState == 1
	{
		if Game.Emeralds == 7
		{
			if RoomState
			{
				var Text1      = tex_charcan;
				var Text2	   = tex_besuper;
				var Text2Frame = Game.Character;
			}
			else
			{
				var Text1      = tex_chargotall;
				var Text2	   = tex_chaosemerald;
				var Text2Frame = 1;
			}	
			draw_sprite(Text1, Game.Character, CentreX + Offset[0], CentreY - 44 + ShiftY);
			draw_sprite(Text2, Text2Frame,	   CentreX + Offset[1], CentreY - 20 + ShiftY);
		}
		else
		{
			draw_sprite(tex_chargot,	  Game.Character, CentreX + Offset[0], CentreY - 44 + ShiftY);
			draw_sprite(tex_chaosemerald, 0,			  CentreX + Offset[1], CentreY - 20 + ShiftY);
		}
	}
	
	// Lose messages
	else if Game.SpecialState == 2
	{
		draw_sprite(tex_special, 0, CentreX + Offset[0], CentreY - 20 + ShiftY);
		draw_sprite(tex_stage,   0, CentreX + Offset[1], CentreY - 20 + ShiftY);
	}
	draw_sprite(spr_results_score,     0, CentreX - 80 + Offset[4], CentreY + 32);
	draw_sprite(spr_results_ringbonus, 0, CentreX - 80 + Offset[5], CentreY + 48);
	
	// Display counters
	text_set_font(Game.Font[FontDigits1], fa_right);
	draw_text(CentreX + 80 + Offset[4], CentreY + 33, Game.Score);
	draw_text(CentreX + 80 + Offset[5], CentreY + 49, Game.SpecialScore);
	
	// Display emeralds
	if RenderFlag
	{
		for (var i = 0; i < Game.Emeralds; i++)
		{
			draw_sprite(tex_emerald_obj, i, CentreX - 58 + 20 * i, CentreY);
		}
	}
}