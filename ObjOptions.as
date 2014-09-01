/*
Creation date: 23-08-2014
Developer: Diego Fernando Sevillano Cardona
Funtion: This library is a motion motor for objects, manage drag and drop, active zones, return to initial position
dispatch of exactly events in the interaction between objects and active zones, easy system for extend type data, fluid
movement system and easy to understand functionality and implement.
Developer message: "LET'S CODE!!!"
*/

package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.Tween;
 	import fl.transitions.easing.*;
    import fl.transitions.TweenEvent;
	
	
	public class ObjOptions extends MovieClip{

		//Private vars
		private var object:MovieClip;
		private var iniX:int = 0;
		private var iniY:int = 0;
		private var RiniX:int = 0;
		private var RiniY:int = 0;
		private var inMove:Boolean = false;
		private var hasMove:Boolean = true;
		private var clip:MovieClip = new MovieClip;
		private var index:int;
		private var myTweenX:Tween;
		private var myTweenY:Tween;
		private var Tween1:Tween;
		private var currentframe:int;
		private var area_act:Boolean = false;
		private var initArea:MovieClip;

		//public vars
		public areaAlpha:Number = 1;
		public var activeArea:MovieClip = clip;
		
		//constructor
		public function ObjOptions() {
			iniX= this.x;
			iniY= this.y;
			this.addEventListener(MouseEvent.MOUSE_DOWN, Move);
			this.addEventListener(MouseEvent.MOUSE_UP, object_up_action);
		}
		
		//return the object type MovieClip
		public function Obj():MovieClip{
			return this;
		}
		
		/*This function initialize  drag action and save temporally the position of the object in scene
		dispatch the event "holdObject"*/
		public function Move(evt:MouseEvent):void{ 
			index = this.parent.getChildIndex(this);
			MovieClip(this).bringToFront();
			this.startDrag();
			this.removeEventListener(MouseEvent.MOUSE_DOWN, Move);
			this.addEventListener(MouseEvent.MOUSE_MOVE, inzone);
			inMove = true;			
			dispatchEvent(new Event("holdObject", true));
		}
		
		/*This function ends drag action, if is over the active area, the object stay in the zone  position or return to the initial position 
		dispatch the events "releaseObject" and "zoneIn" if touch the active area*/
		public function object_up_action(evt:MouseEvent):void{
			this.stopDrag();
			this.disable_area();
			this.removeEventListener(MouseEvent.MOUSE_MOVE, inzone);
			dispatchEvent(new Event("releaseObject", true));
			if(this.hitTestObject(activeArea)){
				this.gotoAndStop(2);
				this.y = activeArea.y;
				this.x = activeArea.x;
				hasMove = false;
				this.removeEventListener(MouseEvent.MOUSE_DOWN, Move);
				this.removeEventListener(MouseEvent.MOUSE_UP, object_up_action);
				dispatchEvent(new Event("zoneIn", true));
				
			}
			else { 
				moverTween(this,iniX,iniY);
				this.parent.setChildIndex(this,index);
				this.addEventListener(MouseEvent.MOUSE_DOWN, Move);
				dispatchEvent(new Event("zoneOut", true));
			}
		}
		
		public function get_inMove():Boolean{
			return inMove;
		}

		public function get_hasMove():Boolean{
			return hasMove;
		}
		
		public function set_area(area:MovieClip):void{
				this.activeArea = area;
		}
		
		public function inzone(evt:MouseEvent):void{
			if(activeArea != null){
				if(this.hitTestObject(activeArea)){
					enable_area();
					area_act = true;
					dispatchEvent(new Event("overZone", true));
				}
				else if(activeArea.alpha == 1)disable_area();
			}
		}

		//enable and disable area manage the visibility of active area

		public function enable_area():void{
			activeArea.alpha = 1;
		}
		
		public function disable_area():void{
			if(area_act){
				if(activeArea != null)Tween1 = new Tween(activeArea, "alpha", None.easeOut, areaAlpha, 0, 1, true);
				activeArea.alpha = 0;
				area_act = false;
				dispatchEvent(new Event("areaDisabled", true));
			}
		}
	
		
		public function moverTween(objeto:MovieClip, XFin:Number, YFin:Number):void {
			myTweenX = new Tween(objeto, "x", Strong.easeOut, objeto.x, XFin, 0.5,true);
			myTweenY = new Tween(objeto, "y", Strong.easeOut, objeto.y, YFin, 0.5,true);			
		}	
		
		
		MovieClip.prototype.bringToFront = function():void {
			this.parent.setChildIndex(this, this.parent.numChildren-1);
		}
		
		//Initialize the object with the initial features.
		public function reset(){
			moverTween(MovieClip(this), this.iniX, this.iniY);	
			if(!this.hasEventListener(MouseEvent.MOUSE_DOWN))
				this.addEventListener(MouseEvent.MOUSE_DOWN, this.Move);
			if(!this.hasEventListener(MouseEvent.MOUSE_UP))
				this.addEventListener(MouseEvent.MOUSE_UP, this.object_up_action);
			this.gotoAndStop(1);
			this.hasMove = true;
			dispatchEvent(new Event("reset", true));
		}
		
	}
	
}
