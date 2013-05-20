package nl.caesar.pdsm.model.util
{
	import flash.events.Event;
	import flash.filesystem.*;
	
	import mx.controls.Alert;
	
	import nl.caesar.pdsm.model.ModelLocator;
	/**
	 * Saves the ModelLocator to the location specified by the user*/
	public class Saver
	{
		public static var file:File;

		public static function saveToFile() :void
		{
			// pick an unused extension
			file = new File("/project.toc");
			
			try 
			{
			   	file.addEventListener(Event.SELECT, dirSelected);
				file.browseForSave('Project opslaan');
			}
			catch (error:Error)
			{
			    trace("Failed:", error.message);
			}
		}

		private static function dirSelected(e:Event) :void
		{
			try {
				// this object will get saved to the file
				var dat:Object = new Object();
				var itsModelLocator:ModelLocator = ModelLocator.getInstance();
				dat.data = itsModelLocator;
				
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeObject(dat);
				fileStream.close();
			}
			catch ( e:Error ) {
				Alert.show( "Kan project niet opslaan. "+e.message, "Fout code "+e.errorID);
			}
			finally {
				Alert.show( "Project is opgeslagen! ", "Succes");
			}
				
		}
	}

}