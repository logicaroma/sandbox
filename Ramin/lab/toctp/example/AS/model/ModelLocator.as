package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
		
	[Bindable]
	[RemoteClass] 
	public class ModelLocator implements IExternalizable
	{
		private static var instance:ModelLocator;
		private var itsProject:Project;
		private var itsUdeCollection:ArrayCollection;
		
		private var itsUdeMap:UDEMap;
		private var itsRoadMap:RoadMap;
		
		private var itsDefaultArrow:Object = {shaftThickness:1,headWidth:8,headLength:3,
					shaftPosition:.10,edgeControlPosition:.50};
		private var itsDefaultSelectedArrow:Object = {shaftThickness:4,headWidth:14,headLength:6,
					shaftPosition:.10,edgeControlPosition:.50};
		
		public function ModelLocator()
		{
		}
		
		public function readExternal( input:IDataInput ):void {
			try {
				itsProject = input.readObject() as Project
				itsUdeCollection = input.readObject() as ArrayCollection;
				
				itsUdeMap = input.readObject() as UDEMap;
				itsRoadMap = input.readObject() as RoadMap;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, ModelLocator"+e.errorID + " - " + e.message, e.name );
			}
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try {
				output.writeObject( itsProject );
				output.writeObject( itsUdeCollection );
				output.writeObject( itsUdeMap );
				output.writeObject( itsRoadMap );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, ModelLocator"+e.errorID + " - " + e.message, e.name );
			}
		}
		
		public function setData( aModelLocator:ModelLocator ):void {
			try {
				itsProject = aModelLocator.project;
				itsUdeCollection = aModelLocator.udeCollection;
				itsUdeMap = aModelLocator.udeMap;
				itsRoadMap = aModelLocator.roadMap;
			}
			catch( e:Error )
			{
				Alert.show("Error in setData, ModelLocator"+e.errorID + " - " + e.message, e.name );
			}
		}
		
		public static function getInstance():ModelLocator {
			if(instance == null){
				instance = new ModelLocator();
			}
			return instance;
			
		}
		
		public static function newInstance():ModelLocator {
			var myModel:ModelLocator = ModelLocator.getInstance();
			myModel.itsProject = new Project();
			myModel.itsUdeCollection = null;		
			myModel.itsUdeMap = null;
			myModel.itsRoadMap = null;
			
			return myModel;
		
		}
		public function get udeCollection():ArrayCollection {
			if( itsUdeCollection == null ){
				itsUdeCollection = new ArrayCollection();
			}
			return itsUdeCollection;
		}
		
		public function set udeCollection( aCollection:ArrayCollection ):void {
			itsUdeCollection = aCollection;
		}
		
		public function get project():Project {
			if( itsProject == null ){
				itsProject = new Project();
			}
			return itsProject;
		}
		
		public function set project( aProject:Project ):void {
			itsProject = aProject;
		}
		
		public function addUde( aUde:UDE ):void {
			var myMaxId:Number = 0;
			
			for each( var myUde:UDE in itsUdeCollection ){
				if( myUde.id > myMaxId ) myMaxId = myUde.id;
			}
			myMaxId++
			aUde.id = myMaxId;
			itsUdeCollection.addItem( aUde );
		}
		
		public function addUdeAt( aUde:UDE, position:int ):void {
			var myMaxId:Number = 0;
			
			for each( var myUde:UDE in itsUdeCollection ){
				if( myUde.id > myMaxId ) myMaxId = myUde.id;
			}
			myMaxId++
			aUde.id = myMaxId;
			itsUdeCollection.addItemAt( aUde, position );
		}
		
	
		public function get udeMap():UDEMap {
			if( itsUdeMap == null ){
				itsUdeMap = new UDEMap();
			}
			return itsUdeMap;
		}
		
		public function set udeMap( aUdeMap:UDEMap ):void {
			itsUdeMap = aUdeMap;
		}		
		public function get defaultArrow():Object {
			return itsDefaultArrow;
		}
		public function get defaultSelectedArrow():Object {
			return itsDefaultSelectedArrow;
		}
		public function get roadMap():RoadMap {
			if( itsRoadMap == null ){
				itsRoadMap = new RoadMap();
			}
			return itsRoadMap;
		}
		
		public function set roadMap( aRoadMap:RoadMap ):void {
			itsRoadMap = aRoadMap;
		}
	}
}