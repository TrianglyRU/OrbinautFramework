function InterfaceDebugSensorsDraw()
{
	/* This code is handled manually. If you make changes to player
	collision code, it won't be reflected here! */
	
	if !Game.DevMode
	{
		return;
	}
	
	layer_set_visible(layer_get_id(Game.TileLayers[2]), DebugSensors and Player.Layer == LayerA);
	layer_set_visible(layer_get_id(Game.TileLayers[3]), DebugSensors and Player.Layer == LayerB);
	
	if !DebugSensors
	{
		return;
	}
	
	draw_set_alpha(0.5);
	draw_rectangle_colour(Camera.ViewX, Camera.ViewY, Camera.ViewX + Game.Width, Camera.ViewY + Game.Height,
						  c_black,		c_black,	  c_black,					 c_black,		false);
	draw_set_alpha(1.0);
	
	if !Player.AllowCollision
	{
		return;
	}
	
	// Set sensor colour
	var Colour = $00FF00;
	
	with Player
	{
		if Grounded
		{
			switch CollisionMode[0]
			{
				case 0:
				{
					if Gsp < 0
					{
						draw_point_colour(floor(PosX - RadiusW), floor(PosY + (Angle == 360) * 8), Colour);
					}
					else if Gsp > 0
					{
						draw_point_colour(floor(PosX + RadiusW), floor(PosY + (Angle == 360) * 8), Colour);
					}
					if !OnObject
					{
						draw_point_colour(floor(PosX - RadiusX), floor(PosY + RadiusY), Colour);
						draw_point_colour(floor(PosX + RadiusX), floor(PosY + RadiusY), Colour);
					}
				}
				break;
				case 1:
				{
					draw_point_colour(floor(PosX + RadiusY), floor(PosY + RadiusX), Colour);
					draw_point_colour(floor(PosX + RadiusY), floor(PosY - RadiusX), Colour);
					
					if Angle >= 90 and Angle <= 270
					{
						if !Game.SKWallCollision or Angle mod 90 != 0
						{
							break;
						}
					}
					if Gsp < 0
					{
						draw_point_colour(floor(PosX), floor(PosY + RadiusW), Colour);
					}
					else if Gsp > 0
					{
						draw_point_colour(floor(PosX), floor(PosY - RadiusW), Colour);
					}	
				}
				break;
				case 2:
				{
					draw_point_colour(floor(PosX + RadiusX), floor(PosY - RadiusY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY - RadiusY), Colour);
					
					if Angle >= 90 and Angle <= 270
					{
						if !Game.SKWallCollision or Angle mod 90 != 0
						{
							break;
						}
					}
					if Gsp < 0
					{
						draw_point_colour(floor(PosX + RadiusW), floor(PosY), Colour);
					}
					else if Gsp > 0
					{
						draw_point_colour(floor(PosX - RadiusW), floor(PosY), Colour);
					}
				}
				break;
				case 3:
				{
					draw_point_colour(floor(PosX - RadiusY), floor(PosY - RadiusX), Colour);
					draw_point_colour(floor(PosX - RadiusY), floor(PosY + RadiusX), Colour);
					
					if Angle >= 90 and Angle <= 270
					{
						if !Game.SKWallCollision or Angle mod 90 != 0
						{
							break;
						}
					}
					if Gsp < 0
					{
						draw_point_colour(floor(PosX), floor(PosY - RadiusW), Colour);
					}
					else if Gsp > 0
					{
						draw_point_colour(floor(PosX), floor(PosY + RadiusW), Colour);
					}	
				}
				break;
			}
		}
		else
		{
			if abs(Xsp) >= abs(Ysp)
			{
				var MoveDirection = Xsp > 0 ? "MoveRight" : "MoveLeft";
			}
			else
			{
				var MoveDirection = Ysp > 0 ? "MoveDown" : "MoveUp";
			}
			switch MoveDirection
			{
				case "MoveDown":
				{
					draw_point_colour(floor(PosX - RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX + RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY + RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY + RadiusY), Colour);
				}
				break;
				case "MoveUp":
				{
					draw_point_colour(floor(PosX - RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX + RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY - RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY - RadiusY), Colour);
				}
				break;
				case "MoveLeft":
				{
					draw_point_colour(floor(PosX - RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY + RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY + RadiusY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY - RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY - RadiusY), Colour);
				}
				break;
				case "MoveRight":
				{
					draw_point_colour(floor(PosX + RadiusW), floor(PosY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY + RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY + RadiusY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY - RadiusY), Colour);
					draw_point_colour(floor(PosX + RadiusX), floor(PosY - RadiusY), Colour);
				}
				break;
			}
		}
	}
}