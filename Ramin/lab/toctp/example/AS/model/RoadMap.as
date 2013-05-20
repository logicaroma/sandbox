package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class RoadMap implements IExternalizable
	{
		private var itsModelLocater:ModelLocator = ModelLocator.getInstance();

		private var itsNegativeEffectCollection:ArrayCollection;
		private var itsObstacleCollection:ArrayCollection;
		
		public function RoadMap()
		{
		}

		public function readExternal( input:IDataInput ):void {
			try
			{
				itsNegativeEffectCollection = input.readObject() as ArrayCollection;
				itsObstacleCollection = input.readObject() as ArrayCollection;
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, RoadMap"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try
			{
				output.writeObject( itsNegativeEffectCollection );
				output.writeObject( itsObstacleCollection );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, RoadMap"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get negativeEffect():ArrayCollection {
			if( itsNegativeEffectCollection == null ){
				itsNegativeEffectCollection = new ArrayCollection();
			}
			return itsNegativeEffectCollection;
		}
		
		public function set negativeEffect( aArrayCollection:ArrayCollection ):void {
			itsNegativeEffectCollection = aArrayCollection;
		}
		
		public function addNegativeEffect( aNegativeEffect:NegativeEffect ):void {		
			var myMaxId:Number = 0;
			for each( var myNegativeEffect:NegativeEffect in negativeEffect ){
				if( myNegativeEffect.id > myMaxId ) myMaxId = myNegativeEffect.id;
			}
			myMaxId++
			aNegativeEffect.id = myMaxId;
			
			itsNegativeEffectCollection.addItem( aNegativeEffect );
		}
		
		public function get obstacleCollection():ArrayCollection {
			if( itsObstacleCollection == null ){
				itsObstacleCollection = new ArrayCollection();
			}
			return itsObstacleCollection;
		}
		
		public function set obstacleCollection( aArrayCollection:ArrayCollection ):void {
			itsObstacleCollection = aArrayCollection;
		}
		
		public function addObstacleCollection( aObstacle:Obstacle ):void {
			var myMaxId:Number = 0;
			for each( var myObstacle:Obstacle in obstacleCollection ){
				if( myObstacle.id > myMaxId ) myMaxId = myObstacle.id;
			}
			myMaxId++
			aObstacle.id = myMaxId;
			
			obstacleCollection.addItem( aObstacle );
		}
				
		public function get productCollection():ArrayCollection {
			var myArrayCollection:ArrayCollection = new ArrayCollection();
			
			var myRoadMapItem:IRoadMapItem;
			for each( myRoadMapItem in itsModelLocater.udeMap.coreCloud.consolidatedInjections ){
				if( Injection( myRoadMapItem ).isSolution ){
					myArrayCollection.addItem( myRoadMapItem );
				}
			}
			for each( myRoadMapItem in obstacleCollection ){
				myArrayCollection.addItem( myRoadMapItem );
			}
			for each( myRoadMapItem in negativeEffect ){
				myArrayCollection.addItem( myRoadMapItem );
			}
			
			return myArrayCollection;
		}
	}
}