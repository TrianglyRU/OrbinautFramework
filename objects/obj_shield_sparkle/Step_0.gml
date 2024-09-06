if display_timer++ < 24
{
	x += SparkleID < 2 ? -2 : 2;
	y += SparkleID % 2 == 0 ? -2 : 2;
		
	exit;
}
	
instance_destroy();