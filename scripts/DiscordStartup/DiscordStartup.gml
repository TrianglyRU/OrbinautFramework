function DiscordStartup()
{    
    // Get application ID. This one is for Orbianut and provides basic set of icons
    var DiscordAppID = "795659000645287996";
    
    // Initialise Rich Presence
    if !(os_type == os_windows or os_type == os_linux or os_type == os_macosx) or !np_initdiscord(DiscordAppID, true, "0")
    {
        global.RichPresenceSupport = false;
    }
}