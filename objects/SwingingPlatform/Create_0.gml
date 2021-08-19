/// @description Insert description here
// You can write your code in this editor

    OriginX = x;
    OriginY = y;
    XDist = 0;
    YDist = 0;
    Amplitude = (ChainCount + 2) * ChainDistance + sprite_get_width(spr_swing_platform) div 2;
    Unload = false;
    
    object_set_solidbox(XRadius, YRadius, false);
    object_set_depth(Player, false);