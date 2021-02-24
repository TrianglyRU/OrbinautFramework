/// @function enigma_decode(value)
function enigma_decode(value) 
{
	return string_digits(base64_decode(value));
}