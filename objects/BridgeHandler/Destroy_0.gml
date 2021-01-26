/// @description Activate/Deactivate
// You can write your code in this editor

    // Activate logs
    instance_activate_object(BridgeLog);
    
    // Destroy bridge logs
    for(CurrentLog = 0; CurrentLog < SegmentAmount; CurrentLog++)
	{
        with(ds_list_find_value(BridgeLogs, CurrentLog)) {
             instance_destroy();
        }
    }
    
	// Destroy lists
    ds_list_destroy(BridgeLogs);
    ds_list_destroy(BridgeTensions);
    ds_list_destroy(BridgeTensionsInterpolated);