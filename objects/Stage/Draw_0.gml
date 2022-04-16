/// @description Update Palette / Draw Water
// You can call your scripts in this editor
	
	#region Update Palette
	{
		switch room
		{
			case Stage_TSZ:
			{
				// Update colour
				palette_upd_colour(PalPrimary, 11, 8, 1, 4);
				
				// Sync others
				var Colour = palette_get_colour(PalPrimary, 11);
				{
					palette_set_colour(PalSecondary, 18, Colour); 
					palette_set_colour_range(PalPrimary, 12, 18, Colour);
				}
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