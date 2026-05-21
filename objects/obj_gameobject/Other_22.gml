/// @description End Step (Pre-Framework) - Path Step

// This event can be used as a End Step that is guaranteed
// to run BEFORE obj_game's End Step
//
// obj_player and objects that can be directly attached to it
// are using this event

// This event should also be used instead of the regular Step event if your Game Object moves along a path
//
// This is necessary because when using a path, the object's X and Y positions
// are updated after the Step event, which can cause some Orbinaut's code
// to work incorrectly