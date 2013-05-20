package nl.caesar.pdsm.model.util
{
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.net.FileFilter;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import nl.caesar.pdsm.model.ModelLocator;

	public class Opener
	{
		public static var file:File;
		private var itsModelLocator:ModelLocator = ModelLocator.getInstance();
		
		public static function openFile() :void
		{
			file = new File();
			
			var fileFilter:FileFilter = new FileFilter("TOC Project", "*.toc;");
			file.addEventListener(Event.SELECT, dirSelected);
			file.browseForOpen('Open een bestaand project', [fileFilter]);
			
		}

		private static function dirSelected(e:Event) :void
		{
			if ( file.extension == "toc" ) {
				try {
					// this will be our object back
					var dat:Object = new Object();
		
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					dat = fileStream.readObject();
					fileStream.close();
					
					Application.application.itsModelLocator.setData(dat.data);
				} catch ( e:Error ) {
					Alert.show("Kan het bestand niet lezen.."+e.message, "Fout "+e.errorID);
					trace(e.getStackTrace());
				} 
					
				Application.application.showIntroScreen();
			}
			else {
				Alert.show("Kan het bestand niet lezen.. Controleer of het een .toc bestand is", "Fout bestand");
			}
		}
		public static function onOpenFileInvoked(aFile:File):void{
			try {
					// this will be our object back
					var dat:Object = new Object();
					file = new File();
					file = aFile;
					trace("File location "+file.nativePath);
					var fileStream:FileStream = new FileStream();
					fileStream.open(file, FileMode.READ);
					dat = fileStream.readObject();
					fileStream.close();
					
					Application.application.itsModelLocator.setData(dat.data);
				} catch ( e:Error ) {
					Alert.show("Kan het bestand niet lezen.."+e.message, "Fout "+e.errorID);
				} finally {
					Alert.show("Project is geopend!", "Succes");
				}
		}
	}

}