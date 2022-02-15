/// @description Draw 2
// You can call your scripts in this editor
	
	/* Anything called here will be rendered
	using game resolution */
	
	/* Low plane is rendered below the fade and is affected by palette functions.
	Please note that you have to add global.ScreenBuffer to your x positions here */
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