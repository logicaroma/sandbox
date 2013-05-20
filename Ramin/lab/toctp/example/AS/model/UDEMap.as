package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class UDEMap implements IExternalizable
	{
		private var itsUDECollection:ArrayCollection;
		private var itsUDEAssociationCollection:ArrayCollection;
		private var itsUDEAssociationGroupCollection:ArrayCollection;
		private var itsCoreCloud:CoreCloud;
		private var itsUdeAssumptionCollection:ArrayCollection;
		private var itsUdeCompromiseCollection:ArrayCollection;
		private var itsWidth:Number = 1500;
		private var itsHeight:Number = 1500;
		
		public function UDEMap()
		{
		}
		
		public function readExternal( input:IDataInput ):void {
			try 
			{
				
				itsUDECollection = input.readObject() as ArrayCollection;
				itsUDEAssociationCollection = input.readObject() as ArrayCollection;
				itsUDEAssociationGroupCollection = input.readObject() as ArrayCollection;
				itsCoreCloud = input.readObject() as CoreCloud;
				itsUdeAssumptionCollection = input.readObject() as ArrayCollection;
				itsUdeCompromiseCollection = input.readObject() as ArrayCollection;
				itsWidth = input.readFloat() as Number;
				itsHeight = input.readFloat() as Number;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, UDEMap"+e.errorID + " - " + e.message , e.name );
			}	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try
			{
				output.writeObject( itsUDECollection );
				output.writeObject( itsUDEAssociationCollection );
				output.writeObject( itsUDEAssociationGroupCollection );
				output.writeObject( itsCoreCloud );
				output.writeObject( itsUdeAssumptionCollection );
				output.writeObject( itsUdeCompromiseCollection );
				output.writeFloat( itsWidth );
				output.writeFloat( itsHeight );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, UDEMap "+e.errorID + " - " + e.message, e.name );
			}	
		}

		public function get UDECollection():ArrayCollection {
			if( itsUDECollection == null ){
				itsUDECollection = new ArrayCollection();
			}
			return itsUDECollection;
		}
		
		public function set UDECollection( aCollection:ArrayCollection ):void {
			itsUDECollection = aCollection;
		}
		
		public function addUDE( aUDE:UDE ):void {
			if( itsUDECollection == null ){
				itsUDECollection = new ArrayCollection();
			}
			itsUDECollection.addItem( aUDE );
		}
		
		public function get UDEAssociationCollection():ArrayCollection {
			if( itsUDEAssociationCollection == null ){
				itsUDEAssociationCollection = new ArrayCollection();
			}
			return itsUDEAssociationCollection;
		}
		
		public function set UDEAssociationCollection( aCollection:ArrayCollection ):void {
			itsUDEAssociationCollection = aCollection;
		}
		
		public function addUDEAssociation( aUDEAssociationCollection:UDEAssociation ):void {
			if( itsUDEAssociationCollection == null ){
				itsUDEAssociationCollection = new ArrayCollection();
			}
			itsUDEAssociationCollection.addItem( aUDEAssociationCollection );
		}
		
		public function get UDEAssociationGroupCollection():ArrayCollection {
			if( itsUDEAssociationGroupCollection == null ){
				itsUDEAssociationGroupCollection = new ArrayCollection();
			}
			return itsUDEAssociationGroupCollection;
		}
		
		public function set UDEAssociationGroupCollection( aCollection:ArrayCollection ):void {
			itsUDEAssociationGroupCollection = aCollection;
		}
		
		public function addUDEAssociationGroup( aUDEAssociationGroupCollection:UDEAssociationGroup ):void {
			if( itsUDEAssociationGroupCollection == null ){
				itsUDEAssociationGroupCollection = new ArrayCollection();
			}
			itsUDEAssociationGroupCollection.addItem( aUDEAssociationGroupCollection );
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
		
		public function get udeCompromise():ArrayCollection {
			if( itsUdeCompromiseCollection == null ){
				itsUdeCompromiseCollection = new ArrayCollection();
			}
			return itsUdeCompromiseCollection;
		}
		
		public function set udeCompromise( aCollection:ArrayCollection ):void {
			itsUdeCompromiseCollection = aCollection;
		}
		
		public function addCompromise( aCompromise:Compromise ):void {
			udeCompromise.addItem( aCompromise );
		}
		
		public function get udeAssumption():ArrayCollection {
			if( itsUdeAssumptionCollection == null ){
				itsUdeAssumptionCollection = new ArrayCollection();
			}
			return itsUdeAssumptionCollection;
		}
		
		public function set udeAssumption( aAssumptionCollection:ArrayCollection ):void {
			itsUdeAssumptionCollection = aAssumptionCollection;
		}
		
		public function addAssumption( aAssumption:Assumption ):void {
			//trace("addAssumption in UDEMap.as " + aAssumption.x1 , aAssumption.x2 );
			udeAssumption.addItem( aAssumption );
		}
		public function set width( aWidth:Number ):void{
			itsWidth = aWidth;
		}
		public function get width( ):Number {
			return itsWidth;
		}
		public function set height( aHeight:Number ):void{
			itsHeight = aHeight;
		}
		public function get height( ):Number {
			return itsHeight;
		}
	}
}