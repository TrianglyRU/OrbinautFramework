/// @description Insert description here
// You can write your code in this editor
    
    Unload = OriginX + Amplitude < Camera.PosX or OriginX - Amplitude > Camera.PosX + Game.Width 
          or OriginY + Amplitude < Camera.PosY or OriginY - Amplitude > Camera.PosY + Game.Height;
          
    if Unload exit;
    
    RotationAngle = Stage.Time * Speed mod 360;
    
    var RAng = dsin(RotationAngle);
    XDist = dcos(90 + RAng * AngleX) * ChainDistance;
    YDist = dsin(90 + RAng * AngleY) * ChainDistance;
    var Count = ChainCount + 1;
    
    x = floor(OriginX + XDist * Count);
    y = floor(OriginY + YDist * Count);
    
    object_act_solid(false, true, false);