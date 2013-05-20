package nl.caesar.pdsm.model.util
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import nl.caesar.pdsm.model.ModelLocator;
	import nl.caesar.pdsm.model.UdeMap.UdeMapObject;
	
	public class Serialization
	{
		private static var itsModelLocater:ModelLocator = ModelLocator.getInstance();
		
		private static var itsData:String;
		
		// The currentFile opened (and saved) by the application
		private var currentFile:File;

		// The FileStream object used for reading and writing the currentFile
		private var stream:FileStream;
		
		// The default directory
		private var defaultDirectory:File;
		
		public function Serialization(){
			stream = new FileStream();
			defaultDirectory = File.documentsDirectory;
		}
		
		public function save():void
		{
			var myUdeMapObject:UdeMapObject;
			for each( myUdeMapObject in itsModelLocater.udeMap.udeAssumption ){
				myUdeMapObject.shape = null;
			}
			for each( myUdeMapObject in itsModelLocater.udeMap.UDECollection ){
				myUdeMapObject.shape = null;
			}
			for each( myUdeMapObject in itsModelLocater.udeMap.UDEAssociationCollection ){
				myUdeMapObject.shape = null;
			}
			for each( myUdeMapObject in itsModelLocater.udeMap.UDEAssociationGroupCollection ){
				myUdeMapObject.shape = null;
			}
			for each( myUdeMapObject in itsModelLocater.udeMap.udeCompromise ){
				myUdeMapObject.shape = null;
			}
			
			var myString:String = JSON.encode( itsModelLocater );
			itsData = myString;
			
			saveAs();
			
//			var mySharedObject:SharedObject = new SharedObject();
//			mySharedObject.
		}
		
		public function load():void {
			openFile();
		}
		
		private function openFile(event:MouseEvent=null):void
		{ 
		    var fileChooser:File;
		    if (currentFile) 
		    {
		        fileChooser = currentFile;
		    }
		    else
		    {
		        fileChooser = defaultDirectory;
		    }
		    fileChooser.browseForOpen("Open");
		    fileChooser.addEventListener(Event.SELECT, fileOpenSelected);
		}
		
		private function fileOpenSelected(event:Event):void
		{
		    currentFile = event.target as File;
		    stream = new FileStream();
		    stream.openAsync(currentFile, FileMode.READ);
		    stream.addEventListener(Event.COMPLETE, fileReadHandler);
		    stream.addEventListener(IOErrorEvent.IO_ERROR, readIOErrorHandler);
		    currentFile.removeEventListener(Event.SELECT, fileOpenSelected);
		}
		
		private function fileReadHandler(event:Event):void 
		{
		    var myModelLocator:ModelLocator = stream.readObject() as ModelLocator;
		    stream.close();
		    itsModelLocater.setData( myModelLocator );
		    stream.close();
		}
		
		private function saveFile(event:MouseEvent = null):void 
		{
		    if (currentFile) {
			    if (stream != null) 
			    {
			        stream.close();
			    }
		        stream = new FileStream();
		        stream.openAsync(currentFile, FileMode.WRITE);
			    stream.addEventListener(IOErrorEvent.IO_ERROR, writeIOErrorHandler);
			    stream.writeObject( itsModelLocater );
			    stream.close();
		    } 
		    else
		    {
		        saveAs();
		    }
		}
		
		private function saveAs(event:MouseEvent = null):void 
		{
			var fileChooser:File;
			if (currentFile)
			{
				fileChooser = currentFile;
			}
			else
			{
				fileChooser = defaultDirectory;
			}
			fileChooser.browseForSave("Save As");
			fileChooser.addEventListener(Event.SELECT, saveAsFileSelected);
		}
		
		private function saveAsFileSelected(event:Event):void 
		{
			currentFile = event.target as File;
			saveFile();
			currentFile.removeEventListener(Event.SELECT, saveAsFileSelected);
		}

		private function readIOErrorHandler(event:Event):void 
		{
			trace("The specified currentFile cannot be opened.");
		}

		private function writeIOErrorHandler(event:Event):void 
		{
			trace("The specified currentFile cannot be saved.");
		}

	}
}