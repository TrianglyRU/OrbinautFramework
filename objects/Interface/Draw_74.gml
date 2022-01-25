/// @description Draw 2
// You can call your scripts in this editor
	
	/* Anything called here will be rendered
	using game resolution */
	
	// Anything here will be drawn BELOW fade
	InterfaceRendererLowProcess();
	InterfaceOverlayDraw();
	InterfaceResultsDraw();
	InterfaceGameOverDraw();
	InterfacePauseProcess();
	InterfacePauseDraw();
	InterfaceRendererUpdate();
	
	// Anything here will be drawn ABOVE fade
	InterfaceRendererHighProcess();
	InterfaceCardDraw();
	InterfaceRendererUpdate();