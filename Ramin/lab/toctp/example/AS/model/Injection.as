package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class Injection extends RoadMapItemImpl implements IRoadMapItem, IExternalizable
	{
		private var itsAlways:String;
		private var itsId:Number;
		private var itsDescription:String;
		private var itsIsCopy:Boolean;
		private var itsImpact:Number = 1;
		private var itsEffort:Number = 1;
		private var itsDifferentSolution:String;
		private var itsIsSolution:Boolean;
		private var itsConsolidated:Boolean = false;
		
		public function Injection()
		{
			itsId = -1;
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsAlways = input.readObject() as String;
				itsId = input.readInt();
				itsDescription = input.readObject() as String;
				itsIsCopy = input.readBoolean();
				itsImpact = input.readInt();
				itsEffort = input.readInt();
				itsDifferentSolution = input.readObject() as String;
				itsIsSolution = input.readBoolean();
				itsConsolidated = input.readBoolean();
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, Injection"+e.errorID + " - " + e.message , e.name );
			}	
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try {	
				super.writeExternal( output );
				output.writeObject( itsAlways );
				output.writeInt( itsId );
				output.writeObject( itsDescription );
				output.writeBoolean( itsIsCopy );
				output.writeInt( itsImpact );
				output.writeInt( itsEffort );
				output.writeObject( itsDifferentSolution );
				output.writeBoolean( itsIsSolution );
				output.writeBoolean( itsConsolidated );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, Injection"+e.errorID + " - " + e.message , e.name );
			}
		}
		
		public function get roadMapId():String {
			return "I_" + id;
		}		
		
		public function get id():Number {
			return itsId;
		}
		
		public function set id( aId:Number ):void {
			itsId = aId;
		}
		
		public function get always():String {
			return itsAlways;
		}
		
		public function set always( aString:String ):void {
			itsAlways = aString;
		}
		
		public function get isCopy():Boolean {
			return itsIsCopy;
		}
		
		public function set isCopy( aBool:Boolean ):void {
			itsIsCopy = aBool;
		}
		
		public function get description():String {
			return itsDescription;
		}
		
		public function set description( aDescription:String ):void {
			itsDescription = aDescription;
		}
		
		public function get impact():Number {
			return itsImpact;
		}
		
		public function set impact( aImpact:Number ):void {
			itsImpact = aImpact;
		}
		
		public function get effort():Number {
			return itsEffort;
		}
		
		public function set effort( aEffort:Number ):void {
			itsEffort = aEffort;
		}

		public function get differentSolution():String {
			return itsDifferentSolution;
		}
		
		public function set differentSolution( aDifferentSolution:String ):void {
			itsDifferentSolution = aDifferentSolution;
		}
		
		public function get isSolution():Boolean {
			return itsIsSolution;
		}
		
		public function set isSolution( aIsSolution:Boolean ):void {
			itsIsSolution = aIsSolution;
		}
		public function get isConsolidated():Boolean {
			return itsConsolidated;
		}
		
		public function set isConsolidated( aBoolean:Boolean ):void {
			itsConsolidated = aBoolean;
		}
	}
}