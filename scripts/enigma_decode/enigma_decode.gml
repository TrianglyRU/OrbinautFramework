/// @function enigma_decode(value)
function enigma_decode(value) 
{
	return int64(string_digits(base64_decode(value)));
}