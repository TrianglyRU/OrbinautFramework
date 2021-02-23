/// @function enigma(value, decode)
function enigma(value, decode) 
{
	if decode
	{
		return string_digits(base64_decode(value));
	}
	else
	{
		value = string(value);
		var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_+|\=-№;:?/";
		for(var i = string_length(value); i < 16; i++)
		{
			value = string_insert(string_char_at(chars, irandom(72) + 1), value, irandom(i + 1));
		}
		return base64_encode(value);
	}
}