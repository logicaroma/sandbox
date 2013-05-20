package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class CoreCloudAssumptionItem implements IExternalizable
	{
		private var itsDescription:String;
		private var itsInjections:ArrayCollection;

		public function readExternal( input:IDataInput ):void {
			try {
				itsDescription = input.readObject() as String;
				itsInjections = input.readObject() as ArrayCollection;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, CoreCloudAssumptionItem"+e.errorID + " - " + e.message, e.name );
			}	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try {
				output.writeObject( itsDescription );
				output.writeObject( itsInjections );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, CoreCloudAssumptionItem"+e.errorID + " - " + e.message, e.name );
			}	
		}
		
		public function get description():String {
			return itsDescription;
		}
		
		public function set description( aDescription:String ):void {
			itsDescription = aDescription;
		}
		
		public function get injections():ArrayCollection {
			if( itsInjections == null ){
				itsInjections = new ArrayCollection();
			}
			return itsInjections;
		}
		
		public function set injections( aInjections:ArrayCollection ):void {
			itsInjections = aInjections;
		}
		
		public function addInjection( aInjection:Injection ):void {
			if( aInjection.id == -1 ){
				var myMax:Number = 0;
				for each( var myInjection:Injection in itsInjections ){
					if( myInjection.id > myMax ){
						myMax = myInjection.id;
					}
				}
				myMax++;
				aInjection.id = myMax;
			}
			injections.addItem( aInjection );
		}
	}
}