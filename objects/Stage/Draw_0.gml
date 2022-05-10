/// @description Update Palette / Draw Water
// You can write your code in this editor
	
	#region Update Palette
	{
		switch room
		{
			case Stage_TSZ:
			{
				palette_upd_colour(PalPrimary, 11, 8, 1, 4);
				palette_sync_colours(PalPrimary, 11, PalPrimary, 12, 18);
				palette_sync_colours(PalPrimary, 11, PalSecondary, 28, 35);
			}
			break;
		}
	}
	#endregion
	
	#region Draw Water Surface
	{
		if WaterEnabled
	    {
			if UpdateObjects
			{
				WaterOffset	= dcos((Renderer.AnimationTime[? GlobalTime] + 90) / 2 mod 360) * 32;
				WaterLevel -= dsin( Renderer.AnimationTime[? GlobalTime]		   mod 360) / 6.75;
			}
			var Width = sprite_get_width(tex_water_surface);

			// Render water surface
			if (WaterLevel - Camera.ViewY) > -16 and( WaterLevel - Camera.ViewY) < global.Height + 16
			{
			    var Length = ceil(global.Width / Width) + 2;
			    for (var i = -1; i < Length; i++)
			    {
					draw_animated_sprite(tex_water_surface, 8, true, (floor(Camera.ViewX / Width) + i) * Width + WaterOffset, WaterLevel);
			    }
			}
	    }
	}
	#endregion