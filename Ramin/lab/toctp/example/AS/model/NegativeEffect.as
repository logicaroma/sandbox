package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class NegativeEffect extends RoadMapItemImpl implements IRoadMapItem, IExternalizable
	{
		private var itsId:Number;
		private var itsDescriptionEffect:String;
		private var itsDescriptionInjection:String;
		
		public function NegativeEffect()
		{
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsId = input.readInt();
				itsDescriptionEffect = input.readObject() as String;
				itsDescriptionInjection = input.readObject() as String;
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, NegativeEffect"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}		
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try { 
				super.writeExternal( output );
				output.writeInt( itsId );
				output.writeObject( itsDescriptionEffect );
				output.writeObject( itsDescriptionInjection );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, NegativeEffect"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get roadMapId():String {
			return "AI_" + id;
		}
		
		public function get id():Number {
			return itsId;
		}
		
		public function set id( aId:Number ):void {
			itsId = aId;
		}
		
		public function get descriptionEffect():String {
			return itsDescriptionEffect;
		}
		
		public function get description():String {
			return itsDescriptionEffect;
		}
		
		public function set descriptionEffect( aDescriptionEffect:String ):void {
			itsDescriptionEffect = aDescriptionEffect;
		}
		
		public function get descriptionInjection():String {
			return itsDescriptionInjection;
		}
		
		public function set descriptionInjection( aDescriptionInjection:String ):void {
			itsDescriptionInjection = aDescriptionInjection;
		}

	}
}