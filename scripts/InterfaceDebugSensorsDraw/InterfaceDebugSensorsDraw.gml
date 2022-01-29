function InterfaceDebugSensorsDraw()
{
	/* This code is handled manually. If you make changes to player
	collision code, it won't be reflected here! */
	
	if !Player.AllowCollision
	{
		return;
	}
	
	// Set sensor colour
	var Colour = $FF00FF;
	
	with Player
	{
		if Grounded
		{
			switch CollisionMode[0]
			{
				case 0:
				{
					if Inertia < 0
					{
						draw_point_colour(floor(PosX - RadiusW), floor(PosY + (Angle == 360) * 8), Colour);
					}
					else if Inertia > 0
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
					if Inertia < 0
					{
						draw_point_colour(floor(PosY + RadiusW), floor(PosX), Colour);
					}
					else if Inertia > 0
					{
						draw_point_colour(floor(PosY - RadiusW), floor(PosX), Colour);
					}
					draw_point_colour(floor(PosX + RadiusY), floor(PosY + RadiusX), Colour);
					draw_point_colour(floor(PosX + RadiusY), floor(PosY - RadiusX), Colour);
				}
				break;
				case 2:
				{
					if Inertia < 0
					{
						draw_point_colour(floor(PosX + RadiusW), floor(PosY), Colour);
					}
					else if Inertia > 0
					{
						draw_point_colour(floor(PosX - RadiusW), floor(PosY), Colour);
					}
					draw_point_colour(floor(PosX + RadiusX), floor(PosY - RadiusY), Colour);
					draw_point_colour(floor(PosX - RadiusX), floor(PosY - RadiusY), Colour);
				}
				break;
				case 3:
				{
					if Inertia < 0
					{
						draw_point_colour(floor(PosY - RadiusW), floor(PosX), Colour);
					}
					else if Inertia > 0
					{
						draw_point_colour(floor(PosY + RadiusW), floor(PosX), Colour);
					}
					draw_point_colour(floor(PosX - RadiusY), floor(PosY - RadiusX), Colour);
					draw_point_colour(floor(PosX - RadiusY), floor(PosY + RadiusX), Colour);
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