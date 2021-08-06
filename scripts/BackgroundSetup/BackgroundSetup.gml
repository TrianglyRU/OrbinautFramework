function BackgroundSetup()
{
	switch room
	{	
		case MQZ0:
		{
			// Get background sprites
			BackgroundSprites = [tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg00, tex_mqz_newbg01, tex_mqz_newbg01, tex_mqz_newbg02, tex_mqz_newbg02, tex_mqz_newbg02, tex_mqz_newbg03];
			
			// tex_mqz_bg00
			BackgroundValues[0] = [0, 0, 0,    0,     0, 0, 0,   215, 0,  0, 0];
			BackgroundValues[1] = [0, 0, 0.2,  0.047, 0, 0, 215, 266, 1,  0, 0];
			BackgroundValues[2] = [0, 0, 0.05, 0.047, 0, 0, 267, 287, 0,  0, 0];
			BackgroundValues[3] = [0, 0, 0.08, 0.047, 0, 0, 288, 327, 0,  0, 0];
			
			// tex_mqz_bg01
			BackgroundValues[4] = [0, 0, 0.12, 0.047, 0, 0, 112, 215, 0, 0, 0];
			BackgroundValues[5] = [0, 0, 0.16, 0.047, 0, 0, 245, 327, 0, 0, 0];
			
			// tex_mqz_bg02
			BackgroundValues[6] = [0, 0, 0.01, 0.047, 0, 0, 0,   71,  0, 0, 0];
			BackgroundValues[7] = [0, 0, 0.2,  0.047, 0, 0, 170, 215, 0, 0, 0];
			BackgroundValues[8] = [0, 0, 0.24, 0.047, 0, 0, 311, 382, 0, 0, 0];
			
			// tex_mqz_bg03
			BackgroundValues[9] = [0, 0, 0.2, 0.047, 0, 0, 216, 328, 1, 0.35, 2];
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