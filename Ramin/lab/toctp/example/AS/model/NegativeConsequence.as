package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class NegativeConsequence implements IExternalizable
	{
		private var itsId:Number;
		private var itsDescription:String;
		private var itsLeftAssumption:String;
		private var itsRightAssumption:String;
		private var itsExported:Boolean;
				
		public function NegativeConsequence()
		{
		}
		
		public function readExternal( input:IDataInput ):void {
			try {
				itsId = input.readInt();
				itsDescription = input.readObject() as String;
				itsLeftAssumption = input.readObject() as String;
				itsRightAssumption = input.readObject() as String;
				itsExported = input.readBoolean();
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, NegativeConsequence"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			} 	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try {
				output.writeInt( itsId );
				output.writeObject( itsDescription );
				output.writeObject( itsLeftAssumption );
				output.writeObject( itsRightAssumption );
				output.writeBoolean( itsExported );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, NegativeConsequence"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get id():Number {
			return itsId;
		}
		
		public function set id( aId:Number ):void {
			itsId = aId;
		}
		
		public function get description():String {
			if( itsDescription == null ){
				itsDescription = "";
			}
			return itsDescription;
		}
		
		public function set description( aDescriptionEffect:String ):void {
			itsDescription = aDescriptionEffect;
		}
		
		public function get leftAssumption():String {
			return itsLeftAssumption;
		}
		
		public function set leftAssumption( aAssumption:String ):void {
			itsLeftAssumption = aAssumption;
		}
		
		public function get rightAssumption():String {
			return itsRightAssumption;
		}
		
		public function set rightAssumption( aAssumption:String ):void {
			itsRightAssumption = aAssumption;
		}
		public function get isExported():Boolean {
			return itsExported;
		}
		
		public function set isExported( aIsExported:Boolean ):void {
			itsExported = aIsExported;
		}
	}
}