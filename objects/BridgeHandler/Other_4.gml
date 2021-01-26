/// @description Spawn Logs
// You can write your code in this editor

    for (CurrentLog = 0; CurrentLog < SegmentAmount; CurrentLog++) 
	{
        Log              = instance_create_depth(x + 8 + 16 * CurrentLog, y + 8, depth, BridgeLog);
        Log.ParentBridge = id;
        Log.LogId        = CurrentLog;
        Log.sprite_index = BridgeSprite;
        
        ds_list_add(BridgeLogs, Log);
        ds_list_add(BridgeTensions, 0);
        ds_list_add(BridgeTensionsInterpolated, 0);
    }