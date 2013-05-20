package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import nl.caesar.pdsm.model.UdeMap.UdeMapObject;
	
	[Bindable]
	[RemoteClass] 
	public class Assumption extends UdeMapObject implements IExternalizable
	{
		private var itsDescription:String;
		
		public function Assumption()
		{
		}
		
		public function get description():String {
			return itsDescription;
		}
		
		public function set description( aDescription:String ):void {
			itsDescription = aDescription;
		}
		
		public override function readExternal( input:IDataInput ):void {
			super.readExternal( input );
			itsDescription = input.readObject() as String;
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			super.writeExternal( output );
			output.writeObject( itsDescription );
		}

	}
}