/// @description Randomise Finish Object
// You can write your code in this editor
	
	if !Active
	{
		var Random = choose(0, 1);
		if  Random
		{
			// Leave Sign Post
			instance_destroy(EggPrison);
			instance_destroy(PrisonButton);
		}
		else
		{
			// Leave Egg Prison
			instance_destroy(SignPost);
		}
		Active = true;
	}