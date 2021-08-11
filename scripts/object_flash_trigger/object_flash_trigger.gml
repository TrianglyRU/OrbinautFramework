/// @function object_flash_trigger(amount, duration)
function object_flash_trigger(amount, duration)
{	
	Obj_FlashTimer	  = amount * 2 - 1;
	Obj_FlashSubTimer = duration;
	Obj_FlashDuration = duration;
}