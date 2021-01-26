function GameTiledataLoad() 
{	
	read_file("data_angval.txt");
	read_file("data_height.txt");
	read_file("data_width.txt");
	read_file("data_ceiling.txt");
	read_file("data_left.txt");	
}

function read_file(name) 
{
	var File = file_text_open_read(name);				
	if File {														
		for (var i = 0; i < 248; i++) {
			switch name {
				case "data_angval.txt": 
					for (var j = 0; j < 4; j++) {
						AngleValueOf[i][j] = file_text_read_real(File);
						file_text_readln(File);
					}
				break;
				case "data_height.txt":
					for (var j = 0; j < 16; j++) {
						HeightValueOf[i][j] = file_text_read_real(File);
						file_text_readln(File);
					}
				break;
				case "data_width.txt":  
					for (var j = 0; j < 16; j++) {
						WidthValueOf[i][j] = file_text_read_real(File);	 
						file_text_readln(File);
					}
				break;
				case "data_left.txt":    
					IsLeftOf[i] = file_text_read_real(File);			
					file_text_readln(File);
				break;
				case "data_ceiling.txt": 
					IsCeilingOf[i] = file_text_read_real(File);			
					file_text_readln(File);
				break;
			}
		}
		file_text_close(File);									 
	}
}