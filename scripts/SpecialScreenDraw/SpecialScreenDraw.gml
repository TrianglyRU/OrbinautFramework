function SpecialScreenDraw()
{
	// Exit if not coming from a Special Stage, or fading out
	if !Game.SpecialState or State == 3
	{
		exit;
	}
	
	// Get screen centre
	var CentreX	= Game.Width / 2;
	var CentreY = Game.Height / 2;
	var ShiftY  = floor(Offset[3]);
	
	// Win messages
	if Game.SpecialState == 1
	{
		if Game.Emeralds == 7
		{
			if State
			{
				var Text1      = tex_sstage_character_canbe;
				var Text2	   = tex_sstage_besuper;
				var Text2Frame = Game.Character;
			}
			else
			{
				var Text1      = tex_sstage_character_gotall;
				var Text2	   = tex_sstage_chaosemerald;
				var Text2Frame = 1;
			}	
			draw_sprite(Text1, Game.Character, CentreX + Offset[0], CentreY - 44 + ShiftY);
			draw_sprite(Text2, Text2Frame,	   CentreX + Offset[1], CentreY - 20 + ShiftY);
		}
		else
		{
			draw_sprite(tex_sstage_character_got, Game.Character, CentreX + Offset[0], CentreY - 44 + ShiftY);
			draw_sprite(tex_sstage_chaosemerald,  0,			  CentreX + Offset[1], CentreY - 20 + ShiftY);
		}
	}
	
	// Lose messages
	else if Game.SpecialState == 2
	{
		draw_sprite(tex_sstage_stage, 0, CentreX + Offset[1], CentreY - 20 + ShiftY);
	}
	draw_sprite(gui_results_score,     0, CentreX - 80 + 22 + Offset[4], CentreY + 35);
	draw_sprite(gui_results_ringbonus, 0, CentreX - 80 + 42 + Offset[5], CentreY + 51);
	
	// Display counters
	draw_set_font(game_font(font_counter));
	draw_set_halign(fa_right);

	draw_text(CentreX + 80 + Offset[4], CentreY + 33, Game.Score);
	draw_text(CentreX + 80 + Offset[5], CentreY + 49, Game.SpecialScore);
	
	// Display emeralds
	if RenderFlag
	{
		for (var i = 0; i < Game.Emeralds; i++)
		{
			draw_sprite(tex_sstage_reward, i, CentreX - 58 + 20 * i, CentreY);
		}
	}
}