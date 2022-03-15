/// @description Startup
// You can call your scripts in this editor

	#region Controller Functions
	{
		/// @function menu_add_option(listid,optionid,optionname,redirect)
		function menu_add_option(listid,optionid,optionname,redirect)
		{
			MenuSize[listid]++;
			MenuOption[listid][optionid]   = optionname;
			MenuOption2[listid][optionid]  = optionname;
			MenuRedirect[listid][optionid] = redirect;
		}
	
		/// @function menu_update_option(listid,optionid,newname)
		function menu_update_option(listid,optionid,newname)
		{
			MenuOption[listid][optionid] = newname;
		}
	
		/// @function menu_get_initial_string(listid,optionid)
		function menu_get_initial_string(listid,optionid)
		{
			return MenuOption2[listid][optionid];
		}
	
		/// @function menu_add_header(listid,header)
		function menu_add_header(listid,header)
		{
			MenuHeader[listid] = header;	
		}
	
		/// @function menu_get_boolean(variable)
		function menu_get_boolean(variable)
		{
			if variable
			{
				return "TRUE";
			}
			else
			{
				return "FALSE";
			}
		}
	
		/// @function menu_get_keyname(UTF8value)
		function menu_get_keyname(UTF8value)
		{
			switch UTF8value 
			{
				case 37:  return "LEFT"	 break;
				case 39:  return "RIGHT" break;
				case 38:  return "UP"	 break;
				case 40:  return "DOWN"	 break;
				case 13:  return "ENTER" break;
				case 27:  return "ESC"	 break;
				case 32:  return "SPACE" break;
				case 16:  return "SHIFT" break;
				case 162: return "CTRL"	 break;
				case 163: return "CTRL"	 break;
				case 164: return "ALT"	 break;
				case 165: return "ALT"	 break;
				case 8:	  return "BS"	 break;
				case 9:	  return "TAB"	 break;
				case 36:  return "HOME"	 break;
				case 35:  return "END"	 break;
				case 46:  return "DEL"	 break;
				case 45:  return "INS"	 break;
				case 33:  return "PGUP"  break;
				case 34:  return "PGDN"  break;
				case 19:  return "PAUSE" break;
				case 44:  return "PRSCR" break;
				case 112: return "F1"	 break;
				case 113: return "F2"	 break;
				case 114: return "F3"	 break;
				case 115: return "F4"	 break;
				case 116: return "F5"	 break;
				case 117: return "F6"	 break;
				case 118: return "F7"	 break;
				case 119: return "F8"	 break;
				case 120: return "F9"	 break;
				case 121: return "F10"	 break;
				case 122: return "F11"	 break;
				case 123: return "F12"	 break;
				case 96:  return "NUM0"	 break;
				case 97:  return "NUM1"	 break;
				case 98:  return "NUM2"	 break;
				case 99:  return "NUM3"	 break;
				case 100: return "NUM4"	 break;
				case 101: return "NUM5"	 break;
				case 102: return "NUM6"	 break;
				case 103: return "NUM7"	 break;
				case 104: return "NUM8"	 break;
				case 105: return "NUM9"	 break;
				case 106: return "MULT"  break;
				case 111: return "DIV"	 break;
				case 107: return "ADD"	 break;
				case 109: return "SUB"	 break;
				case 110: return "DEC"	 break;
				case 81:  return "Q"	 break;
				case 87:  return "W"	 break;
				case 69:  return "E"	 break;
				case 82:  return "R"	 break;
				case 84:  return "T"	 break;
				case 89:  return "Y"	 break;
				case 85:  return "U"	 break;
				case 73:  return "I"	 break;
				case 79:  return "O"	 break;
				case 80:  return "P"	 break;
				case 219: return "LBRKT" break;
				case 221: return "RBRKT" break;
				case 65:  return "A"	 break;
				case 83:  return "S"	 break;
				case 68:  return "D"	 break;
				case 70:  return "F"	 break;
				case 71:  return "G"	 break;
				case 72:  return "H"	 break;
				case 74:  return "J"	 break;
				case 75:  return "K"	 break;
				case 76:  return "L"	 break;
				case 186: return "SMCLN" break;
				case 90:  return "Z"	 break;
				case 88:  return "X"	 break;
				case 67:  return "C"	 break;
				case 86:  return "V"	 break;
				case 66:  return "B"	 break;
				case 78:  return "N"	 break;
				case 77:  return "M"	 break;
				case 188: return "LESS"	 break;
				case 190: return "MORE"	 break;
				case 191: return "RSLSH" break;
				case 49:  return "1"	 break;
				case 50:  return "2"	 break;
				case 51:  return "3"	 break;
				case 52:  return "4"	 break;
				case 53:  return "5"	 break;
				case 54:  return "6"	 break;
				case 55:  return "7"	 break;
				case 56:  return "8"	 break;
				case 57:  return "9"	 break;
				case 48:  return "0"	 break;
				case 187: return "EQUAL" break;
				case 220: return "LSLSH" break;
				default:  return "UNDEF";
			}
		}
	}
	#endregion
	
	#region Startup
	{
		// Initialise MenuIDs. 20 by default
		for (var i = 0; i < 20; i++)
		{
			MenuHeader[i]	  = "TEMPLATE HEADER";
			MenuSize[i]	      = 0;
			PreviousMenuID[i] = 0;
		}
		MenuID   = 0;
		OptionID = 0;
	
		// Set font and its align
		draw_set_font(Font.FontMenu);
		draw_set_halign(fa_center);
	}
	#endregion
	
	#region Data Read
	{
		for (var i = 0; i < 4; i++)
		{	
			// If empty, display as "new game" slot
			if global.SaveData[i] == 0
			{
				DisplayData[i] = "SAVE " + string(i + 1) + " - NEW GAME";
			}
		
			// If has data, setup stuff
			else
			{
				var DataCharacter = global.SaveData[i][0];
				var DataZone      = global.SaveData[i][1];
				var DataEmeralds  = global.SaveData[i][2];
				var DataLives     = global.SaveData[i][3];
				var DataConts     = global.SaveData[i][4];
				var GameCleared   = global.SaveData[i][5];
		
				switch DataCharacter
				{
					case 0:
						var DataCharacter = "S";
					break;
					case 1:
						var DataCharacter = "T";
					break;
					case 2:
						var DataCharacter = "K";
					break;
					default:
						var DataCharacter = "UNK";
				}

				// Set information to display
				if !GameCleared
				{
					DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " ZONE " + string(DataZone) + " - " + "L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
				}
				else
				{
					DisplayData[i] = "SAVE " + string(i + 1) + " - " + string(DataCharacter) + " CLEAR " + " - " + "L" + string(DataLives) + " C"  + string(DataConts) + " E" + string(DataEmeralds);
				}
			}
		}
	}
	#endregion
	
	#region Setup
	{
		/* The game will use global.ZoneID of the selected saveslot as an index for this array,
		and therefore it should contain the first acts of your zones in their gameplay order
	
		Use 'noone' to fill the blanks slots for the zones that do not exist yet */
		ZoneOrder =
		[
			noone,
			noone,
			noone,
			noone
		];
		StartStage = noone;
	
		// Main Menu
		menu_add_header(0,    "ORBINAUT FRAMEWORK" + "\n\nDEVELOPER MENU");
		menu_add_option(0, 0, "GAME START",   1);
		menu_add_option(0, 1, "SCENE SELECT", 3);
		menu_add_option(0, 2, "OPTIONS",      6);	
		menu_add_option(0, 3, "EXIT GAME",    noone);
	
		// Game Start
		menu_add_header(1,    "SELECT A SAVE FILE");
		menu_add_option(1, 0, "NO SAVE MODE",		  3);
		menu_add_option(1, 1, string(DisplayData[0]), 3);
		menu_add_option(1, 2, string(DisplayData[1]), 3);
		menu_add_option(1, 3, string(DisplayData[2]), 3);
		menu_add_option(1, 4, string(DisplayData[3]), 3);
		menu_add_option(1, 5, "DELETE SAVE",		  7);
	
		// Scene Select
		menu_add_header(2,    "SELECT SCENE TYPE");
		menu_add_option(2, 0, "STAGE",  4);
		menu_add_option(2, 1, "SCREEN", 5);
	
		// Character Select
		menu_add_header(3,    "SELECT A PLAYER");
		menu_add_option(3, 0, "SONIC",	  2);
		menu_add_option(3, 1, "TAILS",	  2);
		menu_add_option(3, 2, "KNUCKLES", 2);
		
		// Stage Select
		menu_add_header(4,    "SELECT A STAGE");
		menu_add_option(4, 0, "TEST STAGE",  Stage_TSZ);
		menu_add_option(4, 1, "- -",		 noone);
		menu_add_option(4, 2, "- -",		 noone);
		menu_add_option(4, 3, "- -",		 noone);
		menu_add_option(4, 4, "- -",		 noone);
	
		// Screen select
		menu_add_header(5,    "SELECT A SCREEN");
		menu_add_option(5, 0, "SPLASH",   Screen_Splash);
		menu_add_option(5, 1, "CONTINUE", Screen_Continue);
		menu_add_option(5, 2, "- -",	  noone);
		menu_add_option(5, 3, "- -",	  noone);
		menu_add_option(5, 4, "- -",	  noone);
	
		// Options
		menu_add_header(6,    "OPTIONS");
		menu_add_option(6, 0, "FULLSCREEN: ",   noone);
		menu_add_option(6, 1, "WINDOW SIZE: ",  noone);
		menu_add_option(6, 2, "SOUND VOLUME: ", noone);
		menu_add_option(6, 3, "MUSIC VOLUME: ", noone);
	
		// Game Start (delete data)
		menu_add_header(7,    "SELECT A SAVE FILE TO DELETE");
		menu_add_option(7, 0, "SLOT 1", noone);
		menu_add_option(7, 1, "SLOT 2", noone);
		menu_add_option(7, 2, "SLOT 3", noone);
		menu_add_option(7, 3, "SLOT 4", noone);
	}
	#endregion