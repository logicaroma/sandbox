package nl.caesar.pdsm.event
{
	import flash.events.Event;
	
	public class ToolboxEvent extends Event
	{
		
		public static const DRAW_OVAL:String = "onDrawOval";
		public static const ASSUMPTION:String = "onAssumption";
		public static const COMPROMISE:String = "onCompromise";
		public static const ENLARGE_UDE_MAP:String = "onEnlargeUdeMap";
		public static const LINK_UDE:String = "onLinkUde";
		public static const ENTRY_POINT:String = "onEntryPoint";
		public static const LEFT:String = "onLeft";
		public static const RIGHT:String = "onRight";
		public static const UP:String = "onUp";
		public static const DOWN:String = "onDown";
		public static const DROP_CORE_CLOUD:String = "onDropCoreCloud";
		
		public var data:*;
				
		public function ToolboxEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ToolboxEvent(type, bubbles, cancelable);
		}
			

	}
}