/// @function string_distort(string, length, distStart)
function string_distort(String, Length, distStart) 
{	
	var Len = string_length(String);
	
	if Len > Length 
	{
		String = string_copy(String, 0, Length);
		Len = Length;
	}
	
	if distStart <= Len 
	{
		var OrigString = String;
		String = string_copy(String, 0, distStart);
		for(var i = distStart; i < Len; i++)
		{
			String += string_char_at(OrigString, i + 1) == " " ? " " : string_char_at("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789:", irandom(36) + 1);
		}
	}
	
	return String;
}