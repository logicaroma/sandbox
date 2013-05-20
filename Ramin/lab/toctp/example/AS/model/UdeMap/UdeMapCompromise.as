package nl.caesar.pdsm.model.UdeMap
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class UdeMapCompromise extends UdeMapObject implements IExternalizable
	{
		public function UdeMapCompromise()
		{
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal(input);
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, UdeMapCompromise "+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try {
				super.writeExternal(output);
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, UdeMapCompromise "+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}

	}
}