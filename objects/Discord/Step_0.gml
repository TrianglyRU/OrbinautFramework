/// @description Update RP
// You can write your code in this editor
	
	// Send information to Discord
	np_setpresence(BottomString, TopString, MainImage, SmallImage);
	np_setpresence_more(SmallImageDesc, MainImageDesc, false);
 // np_setpresence_timestamps(global.GameStartTime, 0, false); // <- uncomment this if you want to display the playtime
	np_update();