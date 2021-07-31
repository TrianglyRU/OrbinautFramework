/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

	if !Game.SpecialState
	{
		if !Palette.FadeStep 
		{ 
			room_goto(Game.SpecialPrevious);
			Game.SpecialPrevious = noone;
		}
	}