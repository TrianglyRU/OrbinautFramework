function StageLayersSetup()
{	
	var GameWidth = 400;
	var DataLen = 2;
	//var WaveData = [-1,-1,-1,-2,-2,-3,-3,-3,-4,-4,-4,-5,-5,-6,-6,-6,-6,-6,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-7,-6,-6,-6,-6,-6,-5,-5,-4,-4,-4,-3,-3,-3,-2,-2,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	var WaveData = [1,2,3,3,2,1,0,0,0,0,0,0,0,0,0,0,-1,-2,-3,-3,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-2,-3,-3,-2,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	
	FxWaves = fx_create("_filter_waves");
	fx_set_single_layer(FxWaves, true);
	layer_set_fx("GraphicsA", FxWaves);
	layer_set_fx("AnimatedTiles", FxWaves);
	layer_set_fx("GraphicsB", FxWaves);
	
	fx_set_parameter(FxWaves, "g_DataLen",   DataLen);
	fx_set_parameter(FxWaves, "g_WaveData",  WaveData);
	fx_set_parameter(FxWaves, "g_DataSize",  array_length(WaveData));
	fx_set_parameter(FxWaves, "g_ScreenWid", GameWidth);
}