package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	
	import nl.caesar.pdsm.model.UdeMap.UdeMapObject;
	
	[Bindable]
	[RemoteClass] 
	public class UDE extends UdeMapObject implements IExternalizable
	{
		private var itsId:Number = -1;
		private var itsDescription:String;
		private var itsTop:Boolean = false;
		private var itsEntryPoint:Boolean = false;
		private var itsNegativeConsequence:ArrayCollection;
		private var itsConsequence:String;
		private var itsCoreCloud:CoreCloud;
				
		public function UDE()
		{
			itsDescription = "";
			itsNegativeConsequence = new ArrayCollection();
		}
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsId = input.readInt();
				itsDescription = input.readObject() as String;
				itsTop = input.readBoolean();
				itsEntryPoint = input.readBoolean();
				itsNegativeConsequence = input.readObject() as ArrayCollection; 
				itsConsequence = input.readObject() as String;
				itsCoreCloud = input.readObject() as CoreCloud;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, UDE"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try{
				super.writeExternal( output );
				output.writeInt( itsId );
				output.writeObject( itsDescription );
				output.writeBoolean( itsTop );
				output.writeBoolean( itsEntryPoint );
				output.writeObject( itsNegativeConsequence ); //Hierna gaat er iets miss
				output.writeObject( itsConsequence );
				output.writeObject( itsCoreCloud );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, UDE"+e.errorID + " - " + e.message, e.name );
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
			return itsDescription;
		}
		
		public function set description( aDescription:String ):void {
			itsDescription = aDescription;
		}
		
		public function get top():Boolean {
			return itsTop;
		}
		
		public function set top( aTop:Boolean ):void {
			itsTop = aTop;
		}
		
		public function get entryPoint():Boolean {
			return itsEntryPoint;
		}
		
		public function set entryPoint( aEntryPoint:Boolean ):void {
			itsEntryPoint = aEntryPoint;
		}
		
		public function get negativeConsequence():ArrayCollection {
			if( itsNegativeConsequence == null ){
				itsNegativeConsequence = new ArrayCollection();
			}
			return itsNegativeConsequence;
		}
		
		public function set negativeConsequence( aCollection:ArrayCollection ):void {
			itsNegativeConsequence = aCollection;
		}
		
		public function addNegativeConsequence( aNegativeConsequence:NegativeConsequence ):void {		
			try {
				var myMaxId:Number = 0;
				for each( var myNegativeConsequence:NegativeConsequence in negativeConsequence ){
					if( myNegativeConsequence.id > myMaxId ) myMaxId = myNegativeConsequence.id;
				}
				myMaxId++
				aNegativeConsequence.id = myMaxId;
				
				itsNegativeConsequence.addItem( aNegativeConsequence );
			}
			catch( e:Error )
			{
				Alert.show("Error in addNegativeConsequence, UDE "+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get consequence():String {
			trace ( "UDE : itsConsequence requested " );
			return itsConsequence;
		}
		
		public function set consequence( aConsequence:String ):void {
			itsConsequence = aConsequence;
			trace ( "UDE : itsConsequence updated " + aConsequence );
		}
		
		public function get coreCloud():CoreCloud {
			if( itsCoreCloud == null ){
				itsCoreCloud = new CoreCloud();
			}
			return itsCoreCloud;
		}
		
		public function set coreCloud( aCoreCloud:CoreCloud ):void {
			itsCoreCloud = aCoreCloud;
		}
	}
}