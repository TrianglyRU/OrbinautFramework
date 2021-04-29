/// @description Insert description here
// You can write your code in this editor
	
	draw_self();
	
	string_set_font(Game.Font[FontDebug], "left");
	switch Mode
	{
		// Collide all
		case 0: 
		string_display(x - objXRadiusSolid, y - 34, "All", 0.85);
		break;
		
		// Collide sides and bottom
		case 1: 
		string_display(x - objXRadiusSolid, y - 34, "Sides and Bottom", 0.85);
		break;
		
		// Collide sides and top
		case 2: 
		string_display(x - objXRadiusSolid, y - 34, "Sides and Top", 0.85);
		break;
		
		// Collide top and bottom
		case 3: 
		string_display(x - objXRadiusSolid, y - 34, "Top and Bottom", 0.85);
		break;
		
		// Collide only top
		case 4: 
		string_display(x - objXRadiusSolid, y - 34, "Top", 0.85);
		break;
		
		// Collide only bottom
		case 5: 
		string_display(x - objXRadiusSolid, y - 34, "Bottom", 0.85);
		break;
		
		// Collide only sides
		case 6: 
		string_display(x - objXRadiusSolid, y - 34, "Sides", 0.85);
		break;
		
		// No collision
		case 7: 
		string_display(x - objXRadiusSolid, y - 34, "Non-solid", 0.85);
		break;
		
	}