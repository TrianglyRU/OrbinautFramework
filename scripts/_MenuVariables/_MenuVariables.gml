function _MenuVariables()
{	
	Saveslot[0]		_init;
	Saveslot[1]		_init;
	Saveslot[2]		_init;
	Saveslot[3]		_init;
	
	MenuState		_init;
	MenuOption		_init;	
	ControlEditMode _init;
	DataDeleteMode  _init;
	SaveNewData     _init;
	StageToLoad     _init;

	// Menu state macro
	#macro Main 	        0
	#macro DataSelect		1        
	#macro Options		    2
	#macro FrameworkConfig  3
	#macro AudioVideoConfig 4
	#macro InputConfig		5
	#macro StageSelect      6
	#macro CharacterSelect  7
}