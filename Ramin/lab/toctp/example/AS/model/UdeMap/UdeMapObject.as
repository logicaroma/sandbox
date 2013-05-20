package nl.caesar.pdsm.model.UdeMap
{
	import flash.display.DisplayObject;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	[Bindable]
	[RemoteClass] 
	public class UdeMapObject implements IExternalizable
	{
		private var itsX1:Number;
		private var itsX2:Number;
		private var itsY1:Number;
		private var itsY2:Number;
		private var itsWidth:Number;
		private var itsHeight:Number;
		private var itsShape:DisplayObject; //this shape should NOT be saved to a file
		
		public function UdeMapObject() {
			clear();
			
		}
		
		public function readExternal( input:IDataInput ):void {
			itsX1 = input.readInt() as Number;
			itsX2 = input.readInt() as Number;
			itsY1 = input.readInt() as Number;
			itsY2 = input.readInt() as Number;
			itsWidth = input.readInt() as Number;
			itsHeight = input.readInt() as Number;
		}
		
		public function writeExternal( output:IDataOutput ):void {
			output.writeInt( itsX1 );
			output.writeInt( itsX2 );
			output.writeInt( itsY1 );
			output.writeInt( itsY2 );
			output.writeInt( itsWidth );
			output.writeInt( itsHeight );
		}
		
		public function get x1():Number {
			return itsX1;
		}
		
		public function set x1( aX:Number ):void {
			itsX1 = aX;
		}
		
		public function get x2():Number {
			return itsX2;
		}
		
		public function set x2( aX:Number ):void {
			itsX2 = aX;
		}
		
		public function get y1():Number {
			return itsY1;
		}
		
		public function set y1( aY:Number ):void {
			itsY1 = aY;
		}
		
		public function get y2():Number {
			return itsY2;
		}
		
		public function set y2( aY:Number ):void {
			itsY2 = aY;
		}
		
		public function get height():Number {
			return itsHeight;
		}
		
		public function set height( aHeight:Number ):void {
			itsHeight = aHeight;
		}
		
		public function get width():Number {
			return itsWidth;
		}
		
		public function set width( aWidth:Number ):void {
			itsWidth = aWidth;
		}
		
		public function get shape():DisplayObject {
			return itsShape;
		}
		
		public function set shape( aShape:DisplayObject ):void {
			itsShape = aShape;
		}
		
		public function clear():void {
			itsShape = null;
			itsX1 = -1;
			itsX2 = -1;
			itsY1 = -1;
			itsY2 = -1;
			itsHeight = -1;
			itsWidth = -1;
		}
	}
}