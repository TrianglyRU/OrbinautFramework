/// @function enigma_encode(value)
function enigma_encode(value) 
{
	value = string(value);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*()_+|\=-№;:?/";
	for (var i = string_length(value); i < 16; i++)
	{
		value = string_insert(string_char_at(chars, irandom(72) + 1), value, irandom(i + 1));
	}
	return base64_encode(value);
}