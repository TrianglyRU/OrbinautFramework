/// @function boss_flash(type, amount)
function boss_flash(type, amount)
{
	if !variable_instance_exists(id, "Obj_BossFlashTimer")
	{
		Obj_BossFlashTimer = abs(amount) * 2;
	}
	
	if !(--Obj_BossFlashTimer)
	{
		
	}
}