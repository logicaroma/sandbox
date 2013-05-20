package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	[Bindable]
	[RemoteClass] 
	public class CoreCloudAssumption implements IExternalizable
	{
		private var itsType1:Number;
		private var itsType2:Number;
		private var itsAssumptionItems:ArrayCollection;
		
		public function CoreCloudAssumption()
		{
		}

		public function readExternal( input:IDataInput ):void {
			try {
				itsType1 = input.readInt();
				itsType2 = input.readInt();
				itsAssumptionItems = input.readObject() as ArrayCollection;
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, CoreCloudAssumption" + e.errorID + " - " + e.message, e.name );
			}	
		}
		
		public function writeExternal( output:IDataOutput ):void {
			try{
				output.writeInt( itsType1 );
				output.writeInt( itsType2 );
				output.writeObject( itsAssumptionItems );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, CoreCloudAssumption" + e.errorID + " - " + e.message, e.name );
			}	
		}

		public function get assumptionItems():ArrayCollection {
			if( itsAssumptionItems == null ){
				itsAssumptionItems = new ArrayCollection();
			}
			return itsAssumptionItems;
		}
		
		public function set assumptionItems( aDescription:ArrayCollection ):void {
			itsAssumptionItems = aDescription;
		}
		
		public function addAssumptionItem( aCoreCloudAssumptionItem:CoreCloudAssumptionItem ):void {
			assumptionItems.addItem( aCoreCloudAssumptionItem );
		}

		public function get type1():Number {
			return itsType1;
		}		
		
		public function set type1( aType:Number ):void {
			itsType1 = aType;
		}
		
		public function get type2():Number {
			return itsType2;
		}		
		
		public function set type2( aType:Number ):void {
			itsType2 = aType;
		}
	}
}