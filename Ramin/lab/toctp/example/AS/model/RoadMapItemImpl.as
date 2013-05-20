package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class RoadMapItemImpl implements IExternalizable
	{
		private var itsOrder:Number;
		private var itsResponsible:String;
		private var itsDate:Date;
		
		public function RoadMapItemImpl(){
			itsOrder = 0;
			itsResponsible = "";
			itsDate = new Date();
		}
		
		public function readExternal( input:IDataInput ):void {
			try {
				itsOrder = input.readInt();
				itsResponsible = input.readObject() as String;
				itsDate = input.readObject() as Date;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, RoadMapItemImpl"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try{
				output.writeInt( itsOrder );
				output.writeObject( itsResponsible );
				output.writeObject( itsDate );
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, RoadMapItemImpl"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}

		public function get order():Number {
			return itsOrder;
		}
		
		public function set order( aOrder:Number ):void {
			itsOrder = aOrder;
		}
		
		public function get responsible():String {
			return itsResponsible;
		}
		
		public function set responsible( aResponsible:String ):void {
			itsResponsible = aResponsible;
		}
		
		public function get date():Date {
			return itsDate;
		}
		
		public function set date( aDate:Date ):void {
			itsDate = aDate;
		}
	}
}