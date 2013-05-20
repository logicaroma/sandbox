package nl.caesar.pdsm.model
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import mx.controls.Alert;
	import mx.utils.StringUtil;
	
	[Bindable]
	[RemoteClass] 
	public class Obstacle extends RoadMapItemImpl implements IRoadMapItem, IExternalizable
	{
		private var itsDescription:String;
		private var itsTempGoal:String;
		private var itsId:Number;
		private var itsGenerate:Boolean;
		
		public function Obstacle()
		{
			itsGenerate = false;
			itsDescription = "Obstakel";
			itsTempGoal = "";
		}
		
		public override function readExternal( input:IDataInput ):void {
			try {
				super.readExternal( input );
				itsDescription = input.readObject() as String;
				itsTempGoal = input.readObject() as String;
				itsId = input.readInt();
				itsGenerate = input.readBoolean();
			}
			catch( e:Error )
			{
				Alert.show("Error in readExternal, Obstacle"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}	
		}
		
		public override function writeExternal( output:IDataOutput ):void {
			try {	
				super.writeExternal( output );
				output.writeObject( itsDescription );
				output.writeObject( itsTempGoal );
				output.writeInt( itsId );
				output.writeBoolean( itsGenerate );
			}
			catch( e:Error )
			{
				Alert.show("Error in writeExternal, Obstacle"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}
		}
		
		public function get roadMapId():String {
			return "TD_" + id;
		}

		public function get id():Number {
			return itsId;
		}
		
		public function set id( aId:Number ):void {
			itsId = aId;
		}
		
		public function get generate():Boolean {
			return itsGenerate;
		}
		
		public function set generate( aGenerate:Boolean ):void {
			itsGenerate = aGenerate;
			if( aGenerate ){
				generateGoal();
			}
		}

		public function get description():String {
			return itsDescription;
		}
		
		public function set description( aDescription:String ):void {
			itsDescription = aDescription;
			if( generate ){
				generateGoal();
			}
		}
		
		public function get tempGoal():String {
			return itsTempGoal;
		}
		
		public function set tempGoal( aTempGoal:String ):void {
			if( aTempGoal != itsTempGoal ){
				generate = false;
			}
			itsTempGoal = aTempGoal;
		}
		
		private function generateGoal():void {
			itsTempGoal = description;
			
			var intZ:Number = 0;
			var intWoordWeg:Number = 0;
			
			//zoek op geen
			var intPlaats:Number = itsTempGoal.toUpperCase().search( "GEEN" );
			if( !isNaN( intPlaats ) && intPlaats > 0 ){
				//kijk of een van de volgende twee woorden eindigt op 'en'
				var aantalSpaties:Number = 0;
				for( var intY:Number = intPlaats; intY<itsTempGoal.length; intY++ ){
					if( itsTempGoal.charAt( intY ) == " " ){
						aantalSpaties++;
					}
					
					if( aantalSpaties == 2 || aantalSpaties == 3 || intY + 1 > itsTempGoal.length ){
						//intZ is afhankelijk of de teller aan het einde is
						if( intY + 1 > itsTempGoal.length ){
							intZ = intY - 1;
						}
						else{
							intZ = intY - 2;
						}
						
						if( itsTempGoal.substr( intZ, 2 ).toLowerCase() == "en" ){
							var myString:String = "aeiou";
							if( myString.search( itsTempGoal.charAt( intZ - 3 ) ) > -1 ){
								itsTempGoal = itsTempGoal.substr( intPlaats ) + itsTempGoal.substr( itsTempGoal.length - (intPlaats+3) );
								intWoordWeg = 1;
								break;
							}
						}
					}										
				}	
					
				if( intWoordWeg == 0 ){
					if( itsTempGoal.toUpperCase().substr( intPlaats ).search( "GEEN TIJD" ) > -1 || 
						itsTempGoal.toUpperCase().substr( intPlaats ).search( "GEEN GELD" ) > -1 ){
						//geen eruit
						itsTempGoal = itsTempGoal.substring( 0, intPlaats ) + itsTempGoal.substr( intPlaats + 4 );
					}	
					else{
						itsTempGoal = itsTempGoal.substring( 0, intPlaats ) + itsTempGoal.substr( intPlaats + 1 );
					}
				}		
			}

			replaceWord( "NOG", "" );
			replaceWord( "ONBEKEND", "bekend" );
			replaceWord( "ZONDER", "met" );
			replaceWord( "NIETS", "" );
			replaceWord( "NIKS", "" );
			replaceWord( "NIET", "" );
			
			//Tussentijdse doel wijzigen als de tussentijdse doel anders is dan de obstakel beschrijving
			if( itsTempGoal != itsDescription ) {
				trace ("Temp Goal aangemaakt " + itsTempGoal );
				//van de eerste letter een hoofdletter maken
				itsTempGoal = itsTempGoal.charAt(0).toUpperCase() + itsTempGoal.substr( 1 );
			}
			else {
				trace ("Temp Goal niet aangemaakt " + itsTempGoal );
				itsTempGoal = "";
			}
			
		}
		
		private function replaceWord( aOriginalWord:String, aNewWord:String ):void {
			var intPlaats:Number = itsTempGoal.toUpperCase().search( aOriginalWord.toUpperCase() );
			if( intPlaats > -1 ){
				var myNewWord:String = StringUtil.trim( aNewWord );
				if( myNewWord.length > 0 ){
					myNewWord = myNewWord + ' ';
				}
				itsTempGoal = itsTempGoal.substring( 0, intPlaats ) + myNewWord + itsTempGoal.substr( intPlaats + aOriginalWord.length + 1 );
			}
		}
	}
}