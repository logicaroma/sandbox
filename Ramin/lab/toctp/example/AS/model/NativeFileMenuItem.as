package nl.caesar.pdsm.model { 
    import flash.desktop.NativeApplication;
    import flash.display.NativeMenu;
    import flash.display.NativeMenuItem;
    import flash.display.NativeWindow;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    
    import mx.controls.Alert;
    
    import nl.caesar.pdsm.model.util.Opener;
    import nl.caesar.pdsm.model.util.Saver; 
 /**
 * Maakt een NativeFileMenu aan. Te gebruiken voor 'opslaan', 'laden' en verder..
 * Meer info @ http://help.adobe.com/en_US/FlashPlatform/develop/actionscript/3/WS5b3ccc516d4fbf351e63e3d118666ade46-7de7.html
 * 
*/
    public class NativeFileMenuItem extends Sprite 
    { 
        private var recentDocuments:Array =  
            new Array(new File("app-storage:/STRATEGICNAVIGATION.pdf")); 
        
		[Bindable]
		private var itsModelLocator:ModelLocator = ModelLocator.getInstance();
		                                     
        public function NativeFileMenuItem() 
        { 
            var projectMenu:NativeMenuItem; 
            var helpMenu:NativeMenuItem; 
            try { 
		            if (NativeWindow.supportsMenu && stage != null && stage.nativeWindow != null && stage.nativeWindow.menu != null ){ 
		                stage.nativeWindow.menu = new NativeMenu(); 
		                stage.nativeWindow.menu.addEventListener(Event.SELECT, selectCommandMenu); 
		                projectMenu = stage.nativeWindow.menu.addItem(new NativeMenuItem("Project")); 
		                projectMenu.submenu = createProjectMenu(); 
		                helpMenu = stage.nativeWindow.menu.addItem(new NativeMenuItem("Help")); 
		                helpMenu.submenu = createHelpMenu(); 
		            } 
		            else if (NativeApplication.supportsMenu){ 
		                NativeApplication.nativeApplication.menu.addEventListener(Event.SELECT, selectCommandMenu); 
		                projectMenu = NativeApplication.nativeApplication.menu.addItem(new NativeMenuItem("Project")); 
		                projectMenu.submenu = createProjectMenu(); 
		                helpMenu = NativeApplication.nativeApplication.menu.addItem(new NativeMenuItem("Help")); 
		                helpMenu.submenu = createHelpMenu(); 
		            } 
            }
			catch( e:Error )
			{
				Alert.show("Error in Constructor, NativeFileeMenuItem"+e.errorID + " - " + e.message, e.name );
			}
        } 
                 
        public function createProjectMenu():NativeMenu { 
        	try {
	            var projectMenu:NativeMenu = new NativeMenu(); 
	            projectMenu.addEventListener(Event.SELECT, selectCommandMenu); 
	             
	            var newCommand:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Nieuw")); 
	            newCommand.addEventListener(Event.SELECT, selectCommand); 
	            
	            var saveCommand:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Opslaan")); 
	            saveCommand.addEventListener(Event.SELECT, selectCommand); 
	            
	            var openRecentMenu:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Open Recente projecten"));  
	            openRecentMenu.submenu = new NativeMenu(); 
	            openRecentMenu.submenu.addEventListener(Event.DISPLAYING, updateRecentDocumentMenu); 
	            openRecentMenu.submenu.addEventListener(Event.SELECT, selectCommandMenu); 
	            
	            var copyCommand:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Kopieren")); 
	            copyCommand.addEventListener(Event.SELECT, selectCommand); 
	            copyCommand.keyEquivalent = "c"; 
	            
	            var pasteCommand:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Plak")); 
	            pasteCommand.addEventListener(Event.SELECT, selectCommand); 
	            pasteCommand.keyEquivalent = "v"; 
	            projectMenu.addItem(new NativeMenuItem("", true)); 
	            
	            var preferencesCommand:NativeMenuItem = projectMenu.addItem(new NativeMenuItem("Instellingen")); 
	            preferencesCommand.addEventListener(Event.SELECT, selectCommand); 
	            
            }
			catch( e:Error )
			{
				Alert.show("Error in createProjectMenu, NativeFileeMenuItem"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			} finally { 
            	return projectMenu;
   			} 
        } 
         
        public function createHelpMenu():NativeMenu { 
        	try {
	            var helpMenu:NativeMenu = new NativeMenu(); 
	            helpMenu.addEventListener(Event.SELECT, selectCommandMenu); 
	             
	            var websiteAcademyCommand:NativeMenuItem = helpMenu.addItem(new NativeMenuItem("TOC Academy Website")); 
	            websiteAcademyCommand.addEventListener(Event.SELECT, selectCommand); 
	            
	            var websiteTOCICOCommand:NativeMenuItem = helpMenu.addItem(new NativeMenuItem("TOC-ICO Website")); 
	            websiteTOCICOCommand.addEventListener(Event.SELECT, selectCommand); 
	             
	            helpMenu.addItem(new NativeMenuItem("", true)); 
	            var infoCommand:NativeMenuItem = helpMenu.addItem(new NativeMenuItem("Informatie")); 
	            infoCommand.addEventListener(Event.SELECT, selectCommand); 
	             
	            
	        }
			catch( e:Error )
			{
				Alert.show("Error in createHelpMenu, NativeFileeMenuItem"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}  finally { 
				return helpMenu; 
			}    
        } 
         
        private function updateRecentDocumentMenu(event:Event):void { 
        	try {
		        	var docMenu:NativeMenu = NativeMenu(event.target); 
		             
		            for each (var item:NativeMenuItem in docMenu.items) { 
		                docMenu.removeItem(item); 
		            } 
		             
		            for each (var file:File in recentDocuments) { 
		                var menuItem:NativeMenuItem = docMenu.addItem(new NativeMenuItem(file.name)); 
		                menuItem.data = file; 
		                menuItem.addEventListener(Event.SELECT, selectRecentDocument); 
		            }
		    }
			catch( e:Error )
			{
				Alert.show("Error in updateRecentDocumentMenu, NativeFileeMenuItem"+e.errorID + " - " + e.message, e.name );
				trace( e.getStackTrace() );
			}  
        } 
         
        private function selectRecentDocument(event:Event):void { 
            trace("Selected recent document: " + event.target.data.name); 
        } 
         
        private function selectCommand(event:Event):void { 
            trace("Selected command: " + event.target.label); 
        } 
 
        private function selectCommandMenu(event:Event):void { 
            if (event.currentTarget.parent != null) { 
                var menuItem:NativeMenuItem = 
                        findItemForMenu(NativeMenu(event.currentTarget)); 
                if (menuItem != null) { 
                    trace("Select event for \"" +  
                            event.target.label +  
                            "\" command handled by menu: " +  
                            menuItem.label);
                            switch ( event.target.label )
                            {
                            	case "Nieuw" :
                            	trace("Nieuw project aangemaakt");
                            	itsModelLocator = ModelLocator.newInstance();
                            	break;
                            	
                            	case "Opslaan":
                            	Saver.saveToFile();
                            	break;
                            	case "Openen":
                            	Opener.openFile();
                            	break;
                            	default:
                            	trace( "Menu actie nog niet ondersteund." );
                            	break;
                            }
                }  
            } else { 
                trace("Select event for \"" +  
                        event.target.label +  
                        "\" command handled by root menu."); 
            } 
        } 
         
        private function findItemForMenu(menu:NativeMenu):NativeMenuItem { 
            for each (var item:NativeMenuItem in menu.parent.items) { 
                if (item != null) { 
                    if (item.submenu == menu) { 
                        return item; 
                    } 
                } 
            } 
            return null; 
        } 
    } 
} 