function GameVideoMemoryClear()
{
	// Clear textures. You might want not to perform this
	// between acts if doing S3K-like act transitions to avoid a lag
	draw_texture_flush();
	
	// Clear palette surfaces. We call it here, because surfaces have to be cleared
	// at room end, but in the draw (!) event at the same time (else there is a bug on NVidia graphic cards)
	with Palette
	{
		DoReset = true;
		event_perform(ev_gui_end, 0);
	}
}