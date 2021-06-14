/// @description Stage Camera
// You can call your scripts in this editor
	
	if (Stage.GamePaused) exit;

	// Follow the character
	ScreenCameraFollowPlayer();
	
	// Set camera dynamic offsets
	ScreenCameraHandleOffsets();
	
	// Update camera position
	ScreenCameraPositionUpdate();