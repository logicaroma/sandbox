package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class Project implements IExternalizable
	{
		private var itsName:String = "Naam";
		private var itsSystem:String = "Systeem";
		private var itsGoal:String = "Doel";
		
		public function Project()
		{
		}
		
		public function readExternal( input:IDataInput ):void {
			try 
			{
				itsName = input.readObject() as String;
				itsSystem = input.readObject() as String;
				itsGoal = input.readObject() as String;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, Project"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try
			{
				output.writeObject( itsName );
				output.writeObject( itsSystem );
				output.writeObject( itsGoal );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, Project"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}

		public function get name():String {
			return itsName;
		}
		
		public function set name( aName:String ):void {
			itsName = aName;
		}
		
		public function get system():String {
			return itsSystem;
		}
		
		public function set system( aSystem:String ):void {
			itsSystem = aSystem;
		}
		
		public function get goal():String {
			return itsGoal;
		}
		
		public function set goal( aGoal:String ):void {
			itsGoal = aGoal;
		}

	}
}