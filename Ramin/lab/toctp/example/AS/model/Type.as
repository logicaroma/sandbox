package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	[Bindable]
	[RemoteClass] 
	public final class Type implements IExternalizable
	{
		public static const A:Number = 1;
		public static const B:Number = 2;
		public static const C:Number = 3;
		public static const D:Number = 4;
		public static const DAccent:Number = 5;
		
		public function readExternal( input:IDataInput ):void {
			
		}
		
		public function writeExternal( output:IDataOutput ):void {
		}
	}
}