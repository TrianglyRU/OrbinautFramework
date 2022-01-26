/// @description Draw 2
// You can call your scripts in this editor
	
	/* Anything called here will be rendered
	using game resolution */
	
	/* Low plane is rendered below the fade
	and is affected by palette functions */
	InterfaceRendererLowProcess();
	InterfaceOverlayDraw();
	InterfaceResultsDraw();
	InterfaceGameOverDraw();
	InterfacePauseProcess();
	InterfacePauseDraw();
	InterfaceRendererUpdate();
	
	/* High plane is rendered above the fade
	and isn't affected by palette functions */
	InterfaceRendererHighProcess();
	InterfaceCardDraw();
	InterfaceRendererUpdate();