ObjOptions
==========

Created by: Diego Cardona(@RootDiego). 
==========================

This library is a motion motor for objects, manage drag and drop, active zones, return to initial position dispatch
of exactly events in the interaction between objects and active zones, easy system for extend type data, fluid movement 
system and easy to understand functionality and implement.
-------------------------------------------------------------------------------------------------------------------------


How to implement:


- The class of the Object in AS3 must to extend of ObjOptions(this class extends from movieclip).
	Ex.
			package{
								public class test extend ObjOptions{
										public function test(){
										}
								}
							}
- Drag and the hability to return to the initial position starts automatically.
-------------------------------------------------------------------------------------------------------------------------

Accesible variables:


	- areaAlpha(Int): default value is 1, this variable determinate the level of alpha color of the active area when is touched for the object.
			
	- activeArea(MovieClip): default value is a empty movieClip, this variable is the area that determinate the final position
			of the Object, this movieclip may to have the alpha in a zero value, and will be illuminated when the object touch them.
-------------------------------------------------------------------------------------------------------------------------

Accesible functions:

	- Obj(): return a Movieclip instance of the current object.
	
	- Move(): is the current handler of the mouse down event.
	
	- object_up_action(): is the current handler of the mouse up event.
	
	- get_inMove(): return true if the object is currently in move.
	
	- get_hasMove(): return true if the object isn't in the final position.
	
	- disable_area(): don't show the active area.
	
	- reset(): reset  all attributes of the object to the initial state.
	
	
	
	my friends let's code!
