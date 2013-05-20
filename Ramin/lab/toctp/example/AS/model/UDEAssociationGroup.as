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
	public class UDEAssociationGroup extends UdeMapObject implements IExternalizable
	{
		private var itsUDEAssociationCollection:ArrayCollection;
		
		public function UDEAssociationGroup()
		{
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsUDEAssociationCollection = input.readObject() as ArrayCollection;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, UDEAssociationGroup"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try{
				super.writeExternal( output );
				output.writeObject( itsUDEAssociationCollection );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, UDEAssociationGroup"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public function get UDEAssociationCollection():ArrayCollection {
			return itsUDEAssociationCollection;
		}
		
		public function set UDEAssociationCollection( aCollection:ArrayCollection ):void {
			itsUDEAssociationCollection = aCollection;
		}
		
		public function addUDEAssociationCollection( aUDE:UDEAssociation ):void {
			if( itsUDEAssociationCollection == null ){
				itsUDEAssociationCollection = new ArrayCollection();
			}
			itsUDEAssociationCollection.addItem( aUDE );
		}
	}
}