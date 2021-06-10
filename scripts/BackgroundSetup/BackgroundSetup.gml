/// @function
function BackgroundSetup()
{
	switch room
	{
		case MQZ1:
		case MQZ2:
		{
			// Background objects
			BackgroundObject = [MQZBackground00, MQZBackground01, MQZBackground02];
			
			// Set properties
			PositionX     = [0, 0, 0];
			PositionY     = [0, 0, 0];
			ScrollX       = [0, 0, 0];
			ScrollY       = [0, 0, 0];
			OffsetX       = [0, 0, 0];
			OffsetY       = [0, 0, 0];
			RenderTop     = [0, 0, 0];
			RenderBottom  = [0, 0, 0];
			InclineHeight = [0, 0, 0];
			InclineForce  = [0, 0, 0];
		}
		break;
		default: 
		{
			// Background objects
			BackgroundObject = [noone, noone, noone];
			
			// Set properties
			PositionX     = [0, 0, 0];
			PositionY     = [0, 0, 0];
			ScrollX       = [0, 0, 0];
			ScrollY       = [0, 0, 0];
			OffsetX       = [0, 0, 0];
			OffsetY       = [0, 0, 0];
			RenderTop     = [0, 0, 0];
			RenderBottom  = [0, 0, 0];
			InclineHeight = [0, 0, 0];
			InclineForce  = [0, 0, 0];
		}
		break;
	}
	
	// Create bgobjects
	for (var i = 0; i < array_length(BackgroundObject); i++)
	{
		if BackgroundObject[i] != noone
		{
			instance_create_layer(PositionX[i], PositionY[i], "BackgroundObjects", BackgroundObject[i]);
		}
	}
}