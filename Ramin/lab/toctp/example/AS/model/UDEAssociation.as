package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	import nl.caesar.pdsm.components.udemap.UdeMapItem;
	import nl.caesar.pdsm.model.UdeMap.UdeMapObject;
	
	[Bindable]
	[RemoteClass] 
	public class UDEAssociation extends UdeMapObject implements IExternalizable
	{
		private var itsStartObject:UdeMapObject;
		private var itsEndObject:UdeMapObject;
		private var itsAssumption:Assumption;
		
		public function UDEAssociation()
		{
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsStartObject = input.readObject() as UdeMapObject;
				itsEndObject = input.readObject() as UdeMapObject;
				itsAssumption = input.readObject() as Assumption;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, UDEAssociation"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try {
				super.writeExternal( output );
				output.writeObject( itsStartObject );
				output.writeObject( itsEndObject );
				output.writeObject( itsAssumption );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, UDEAssociation"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get StartObject():UdeMapObject {
			return itsStartObject;
		}
		
		public function set StartObject( aObject:UdeMapObject ):void {
			itsStartObject = aObject;
		}
		
		public function get EndObject():UdeMapObject {
			return itsEndObject;
		}
		
		public function set EndObject( aObject:UdeMapObject ):void {
			itsEndObject = aObject;
		}
		
		public function get assumption():Assumption {
			return itsAssumption;
		}
		
		public function set assumption( aAssumption:Assumption ):void {
			itsAssumption = aAssumption;
		}
	}
}