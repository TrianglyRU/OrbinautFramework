function PlayerPush()
{
	/* Pushing flag is set when colliding with object
	or in PlayerGroundWallCollision script  */
	
	if !(Pushing != false)
	{
		exit;
	}
	
	if Pushing == FlipLeft and Input.Right or Pushing == FlipRight and Input.Left
	or !Input.Left and !Input.Right
	{
		Pushing = false;
	}
	else
	{
		Animation = AnimPush;
	}
}