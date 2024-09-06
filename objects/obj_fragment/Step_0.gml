// Handle waiting time before starting movement
if WaitTime > 0
{
    WaitTime--;
    exit;
}

visible = DoFlicker ? c_framework.frame_counter % 2 == 0 : true;

x += VelocityX;
y += VelocityY;
VelocityY += 0.21875;