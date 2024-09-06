if timer < 128
{
    if timer == 96
    {
        // Start the fade-in effect and double the speed of the banner movement
        fade_perform_black(FADEROUTINE.IN, 1);
        speed_x *= 2;
        speed_y *= 2;
    }
    else if timer >= 8
    {
        // Move the banner and zone texts towards their target positions
        offset_banner = min(offset_banner + speed_y, 0);
        offset_zonename = max(offset_zonename - speed_x, 0);
        offset_zone = max(offset_zone - speed_x, 0);
        offset_act = max(offset_act - speed_x, 0);
    }
}
else
{
    if timer == 192
    {
        c_framework.allow_pause = true;
        instance_destroy();
    }
    else if timer >= 160
    {
        // Move the zone texts towards their original positions
        offset_zonename -= speed_x;
        offset_zone += speed_x;
        offset_act += speed_x;
    }
    else if timer >= 136
    {
        // Move the banner towards its original position
        offset_banner -= speed_y;
    }
}

timer++;