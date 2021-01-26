/// @description Bridge Setup
// You can write your code in this editor

    // Get definitive variables values and apply them
	SegmentAmount = BridgeLength;

	for (var i = 0; i < SegmentAmount; i++) {
		Deflection[i] = (i < SegmentAmount / 2 ? i : SegmentAmount - i - 1) * 2 + 2;
	}
    
    // Set default status variables
	RecoveryAngle	    = 0;
	LogY[SegmentAmount] = 0;
    
    // Create lists
    BridgeLogs                 = ds_list_create();
    BridgeTensions             = ds_list_create();
    BridgeTensionsInterpolated = ds_list_create();