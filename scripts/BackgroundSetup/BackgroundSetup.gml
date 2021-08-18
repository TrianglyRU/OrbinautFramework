function BackgroundSetup()
{
	switch room
	{	
		case MQZ0:
		{	
			// Get background sprites
			BackgroundSprites = [tex_mqz_newbg00, tex_mqz_newbg01, tex_mqz_newbg02, tex_mqz_newbg03, tex_mqz_newbg04, tex_mqz_newbg05, tex_mqz_newbg06, tex_mqz_newbg07, tex_mqz_newbg08, tex_mqz_newbg09];
			
			BackgroundValues[0] = [0, 0,   0,    0,     0, 0, 0, 0,    0];
			BackgroundValues[1] = [0, 216, 0.2,  0.047, 0, 0, 0, 0,    0];
			BackgroundValues[2] = [0, 267, 0.05, 0.047, 0, 0, 0, 0,    0];
			BackgroundValues[3] = [0, 288, 0.08, 0.047, 0, 0, 0, 0,    0];
			BackgroundValues[4] = [0, 112, 0.12, 0.047, 0, 0, 0, 0,    0];
			BackgroundValues[5] = [0, 288, 0.16, 0.047, 0, 0, 0, 0,    0];
			BackgroundValues[6] = [0, 0,   0.01, 0.047, 0, 0, 0, 0,    0];
			BackgroundValues[7] = [0, 170, 0.2,  0.047, 0, 0, 0, 0,    0];
			BackgroundValues[8] = [0, 311, 0.24, 0.047, 0, 0, 0, 0,	   0];
			BackgroundValues[9] = [0, 216, 0.2,  0.047, 0, 0, 1, 0.35, 2];
		}
		break;
		default: 
		{
			// Get background sprites
			BackgroundSprites = [];
		}
		break;
	}	
}