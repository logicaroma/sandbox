package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import nl.caesar.pdsm.model.UdeMap.UdeMapObject;
	
	[Bindable]
	[RemoteClass] 
	public class CoreCloud extends UdeMapObject  implements IExternalizable
	{
		private var itsCoreCloudAssumptions:ArrayCollection;
		private var itsConsolidatedInjections:ArrayCollection;
		private var itsA:String;
		private var itsB:String;
		private var itsC:String;
		private var itsD:String;
		private var itsDAccent:String;
		private var itsSolution:String;
		private var itsExported:Boolean;
	
		
		public function CoreCloud(){
			itsCoreCloudAssumptions = new ArrayCollection();
			itsConsolidatedInjections = new ArrayCollection
			itsA = "";
			itsB = "";
			itsC = "";
			itsD = "";
			itsDAccent = "";	
			itsSolution = "";	
			itsExported = false;	
		}
		public function isNull():Boolean{
			if ( itsA == "" || itsB == "" || itsC == "" || itsD == "" || itsDAccent == ""){
				return false;
			}
			else {
				return true;
			}
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				
				itsCoreCloudAssumptions = input.readObject() as ArrayCollection;
				itsConsolidatedInjections = input.readObject() as ArrayCollection;
				itsA = input.readObject() as String;
				itsB = input.readObject() as String;
				itsC = input.readObject() as String;
				itsD = input.readObject() as String;
				itsDAccent = input.readObject() as String;
				itsSolution = input.readObject() as String;
				itsExported = input.readBoolean();
				
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, CoreCloud "+e.errorID + " - " + e.message, e.name );
			}	
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try {
				super.writeExternal( output );
				output.writeObject( itsCoreCloudAssumptions );
				output.writeObject( itsConsolidatedInjections );
				output.writeObject( itsA );
				output.writeObject( itsB );
				output.writeObject( itsC );
				output.writeObject( itsD );
				output.writeObject( itsDAccent );
				output.writeObject( itsSolution );
				output.writeBoolean( itsExported );
				}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, CoreCloud "+e.errorID + " - " + e.message, e.name );
			}
		}

		public function get coreCloudAssumptions():ArrayCollection {
			return itsCoreCloudAssumptions;
		}
		
		public function set coreCloudAssumptions( aCollection:ArrayCollection ):void {
			itsCoreCloudAssumptions = aCollection;
		}
		
		public function addCoreCloudAssumptions( aCoreCloudAssumptions:CoreCloudAssumption ):void {
			itsCoreCloudAssumptions.addItem( aCoreCloudAssumptions );
		}

		public function setCloudParameter( aType:Number, aText:String ):void {
			if( aType == Type.A ){
				itsA = aText;
			}
			else if( aType == Type.B ){
				itsB = aText;
			}
			else if( aType == Type.C ){
				itsC = aText;
			}
			else if( aType == Type.D ){
				itsD = aText;
			}
			else if( aType == Type.DAccent ){
				itsDAccent = aText;
			}
			else{
				throw new Error( "Invalid argument type for Type." );
			}
		}
		
		public function getCloudParameter( aType:Number ):String {
			if( aType == Type.A ){
				return itsA;
			}
			else if( aType == Type.B ){
				return itsB;
			}
			else if( aType == Type.C ){
				return itsC;
			}
			else if( aType == Type.D ){
				return itsD;
			}
			else if( aType == Type.DAccent ){
				return itsDAccent;
			}
			else{
				throw new Error( "Invalid argument type for Type." );
			}
		}
		
		public function set a( aA:String ):void {
			itsA = aA;
		}
		
		public function get a():String {
			return itsA;
		}
		
		public function set b( aB:String ):void {
			itsB = aB;
		}
		
		public function get b():String {
			return itsB;
		}
		
		public function set c( aC:String ):void {
			itsC = aC;
		}
		
		public function get c():String {
			return itsC;
		}
		
		public function set d( aD:String ):void {
			itsD = aD;
		}
		
		public function get d():String {
			return itsD;
		}
		
		public function set da( aDA:String ):void {
			itsDAccent = aDA;
		}
		
		public function get da():String {
			return itsDAccent;
		}
	
		public function get assumptionsDAtoB():CoreCloudAssumption {
			return getAssumptions( Type.DAccent, Type.B );
		}
		
		public function get assumptionsDAtoC():CoreCloudAssumption {
			return getAssumptions( Type.DAccent, Type.C );
		}
		
		public function get assumptionsDtoB():CoreCloudAssumption {
			return getAssumptions( Type.D, Type.B );
		}
		
		public function get assumptionsDtoC():CoreCloudAssumption {
			return getAssumptions( Type.D, Type.C );
		}
		
		public function get assumptionsDtoDa():CoreCloudAssumption {
			return getAssumptions( Type.D, Type.DAccent );
		}
		
		public function get consolidatedInjections():ArrayCollection {
			return itsConsolidatedInjections;
		}
		
		public function set consolidatedInjections( aCollection:ArrayCollection ):void {
			itsConsolidatedInjections = aCollection;
		}
		public function get synchronizeConsolidatedInjections():ArrayCollection {
			var myCollection:ArrayCollection = new ArrayCollection();
			for each( var aCoreCloudAssumption:CoreCloudAssumption in coreCloudAssumptions ){
				for each( var aItem:CoreCloudAssumptionItem in aCoreCloudAssumption.assumptionItems ){
					for each( var aInjection:Injection in aItem.injections ){
						if( aInjection.isCopy ){
							var myMax:Number = 0;
							for each( var myInjection:Injection in myCollection ){
								if( myInjection.id > myMax ){
									myMax = myInjection.id;
								}
							}
							myMax++;
							aInjection.id = myMax;
							myCollection.addItem( aInjection );
						}
					}
				}
			}
			
			return myCollection;
		}
		public function addConsolidatedInjection( aInjection:Injection ):void {
			
			var newInjection:Injection = new Injection ();
			var myMax:Number = 0;
			for each( var myInjection:Injection in itsConsolidatedInjections ){
				if( myInjection.id > myMax ){
					myMax = myInjection.id;
				}
			}
			myMax++;
			newInjection.id = myMax;
			newInjection.description = aInjection.description;
			newInjection.always = aInjection.always;
			newInjection.isCopy = aInjection.isCopy;
			newInjection.impact = aInjection.impact;
			newInjection.effort = aInjection.effort;
			newInjection.differentSolution = aInjection.differentSolution;
			newInjection.isSolution = aInjection.isSolution;
			newInjection.isConsolidated = true;
			aInjection.isConsolidated = true;
			
			itsConsolidatedInjections.addItem( newInjection );
		}
		public function get solution():String {
			return itsSolution;
		}
		
		public function set solution( aSolution:String ):void {
			itsSolution = aSolution;
		}
		
		private function getAssumptions( aType1:Number, aType2:Number ):CoreCloudAssumption {
			for each( var aCoreCloudAssumption:CoreCloudAssumption in coreCloudAssumptions ){
				if( aCoreCloudAssumption.type1 == aType1 && aCoreCloudAssumption.type2 == aType2 ){
					return aCoreCloudAssumption;
				}
			}
			
			var myCoreCloudAssumption:CoreCloudAssumption = new CoreCloudAssumption();
			myCoreCloudAssumption.type1 = aType1;
			myCoreCloudAssumption.type2 = aType2;
			itsCoreCloudAssumptions.addItem( myCoreCloudAssumption );
			return myCoreCloudAssumption;
		}
		public function get isExported():Boolean {
			return itsExported;
		}
		
		public function set isExported( aExported:Boolean ):void {
			itsExported = aExported;
		}

	}
}