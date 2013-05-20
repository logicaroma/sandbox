
var cache = new CacheProvider;


/**
  * Here we create the model 'TOCTP'; used to define the "backbone".  
  * @type Backbone.Model
 */
var APP = Backbone.Model.extend({
	udeCollection: function() { return 'c' + udeCollection._currentcollection; }
   // udeMapExport: function() { return 'c' + toc._currentproject; }
    //coreCloudExport: function() { return 'c' + toc._currentproject; }
});
function removeFallbacks(){
	  var query = $('.jstest,.gallery');
	        if(query.length){
	          query.remove();
	        }
	}
/**
 * Here we create the model 'Project'; used to define a Project describing the systemboundaries and goal, .  
 * @type Backbone.Model
*/
var Project = Backbone.Model.extend({
	defaults: {
		name: 'Your name',
		system: 'Describe the systems boundries',
		goal: 'What is the goal of this project?'
	}
  //project: function() { return 'c' + toc._currentproject; }
});

/**
 * Here we create the model 'TOCTP'; used to define the "backbone".  
 * @type Backbone.Model
*/
var UDE = Backbone.Model.extend({
	defaults: {
		description: 'Describe the undesirable effect',
		type:	['default'],//other options are entrypoint, assumption, compromise
		connected: false,
		connectedTo: [],//'[Array with pid of the connected udes]'
		connectionType: []//[Array of relations]
	},
	
	
	// types of UDEs are, default, assumption, compromis, entrypoint
	getType: 	function( item ) {  	return item.get('type');			},
	setType: 	function( aValue ) {	this.set({ type: aValue })			},
	//description
	getDescription: function( item ) {		return item.get('description'); 	},
	setDescription: function( aValue ) {	this.set({ description: aValue })	},
	
	initialize: function(){
		console.log('Ude Initialized');
		this.bind("change:description", function(){
			var desc = this.get("description");
			console.log("My Description is changed into.. "+ desc)
		})
	}
});

var UdeCollection = Backbone.Collection.extend({
	modal: UDE,
	url		: '/ude',
	comparator: function(item) {
        return item.get('pid');
    }
});
var ProjectCollection = Backbone.Collection.extend({
	modal: Project,
	url		: '/project',
	comparator: function(item) {
        return item.get('pid');
    }
});
var UdeMap = Backbone.Model.extend({
	defaults: {
		udes:	function(){
			if( toc._udes ){
				return toc._udes;
			} else {
				return false;
			}
			
		},
		connections	: []
	},
	initialize: function(){
		return this;
	},
	
	isLinkedToItem: function ( item ){
		//@TODO returns true or false based on the connectage
		return true;
	},
	getLinkedItem: function( aId ) {
		if(this.isLinkedToObject( aId )){
			return toc._udes.get(aid);
		} else {return false;}
	},
	setLinkedItem: 	function( item ) {
		if( !this.isLinkedToItem(item) ){
			this.connectedTo.add( item );
			return true;
		} else {
			console.log("UDEs are already connected")
			return false;
		};
	},
});

var UdeMapCollection = Backbone.Collection.extend({
	modal: UdeMap,
	url		: '/udemap',
	connectItems: 	function( itemA, itemB ) {
		if( !itemA.isLinkedTo( itemB ) ){
				return toc._udes.getById(aid).connect;
		} else {
			return false;
		};
	},
	disconnectItems: function( itemA, itemB ){
		return null;
	},
});

/**
 * Views
 */

/**
 * IndexView: The default view seen when opening up the application for the first time. This 
 * contains the overview of projects in the JSON store. Prior to rendering 
 * our jQuery templates here we remove any messages or elements displayed in the version where 
 * JavaScript is disabled.
 * @type Backbone.View
 */
var IndexView = Backbone.View.extend({
    el: $('#main'),
    indexTemplate: $("#indexTmpl").template(),

    render: function() {
        removeFallbacks();
        var sg = this;
        
        this.el.fadeOut('slow', function() {
        sg.el.empty();
        $.tmpl(sg.indexTemplate, sg.model.toArray()).appendTo(sg.el);
        sg.el.fadeIn('slow');
        });
        return this;
    }
}); //end of IndexView


/**
 * ProjectView: The project information view. Displays the Name of the project, the system boundaries definition and goal from the JSON store. Prior to rendering 
 * our jQuery templates here we remove any messages or elements displayed in the version where 
 * JavaScript is disabled.
 * @type Backbone.View
 */
var ProjectView = Backbone.View.extend({
    el: $('#main'),
    projectTemplate: $("#projectTmpl").template(),

    render: function() {
        removeFallbacks();
        var sg = this;
        
        this.el.fadeOut('slow', function() {
        sg.el.empty();
        $.tmpl(sg.projectTemplate, sg.model.toArray()).appendTo(sg.el);
        sg.el.fadeIn('slow');
        });
        return this;
    }
}); //end of ProjectView

/**
 * ProjectView: The project information view. Displays the Name of the project, the system boundaries definition and goal from the JSON store. Prior to rendering 
 * our jQuery templates here we remove any messages or elements displayed in the version where 
 * JavaScript is disabled.
 * @type Backbone.View
 */
var UdeView = Backbone.View.extend({
    el: $('#main'),
    udeTemplate: $("#udeTmpl").template(),

    render: function() {
        removeFallbacks();
        var sg = this;
        
        this.el.fadeOut('slow', function() {
        sg.el.empty();
        $.tmpl(sg.udeTemplate, sg.model.toArray()).appendTo(sg.el);
        sg.el.fadeIn('slow');
        });
        return this;
    }
}); //end of UdeView


/**
 * The Controllers
 * First controller is the main controller of our app.
 */

/**
 * TOC: The controller that defines our main application 'toc'. Here we handle how 
 * routes should be interpreted, the basic initialization of the application with data through 
 * an $.ajax call to fetch our JSON store and the creation of collections and views based on the 
 * models defined previously.
 * @type Backbone.Controller
 */
var TOC = Backbone.Controller.extend({
    _index: null,
    _project: null,
    _ude: null,
    _projects: null,
    _udes :null,
   
    _udemaps: null,
    _clouds:null,
    _negativeEffects: null,
    _negativeConsequences: null,
    _obstacles: null,
	_injections:null,
	_roadmaps:null,
	_milestones:null,
	_currentproject:null,
	_data:null,
    routes: {
    	//index gets a view containing an Overview of the projects
        "": "index",
        "project/:id": "getProject",
        "project/:id/" : "getUdes",
        "project/:id/:num" : "getProjectect",
        
    },

    initialize: function(options) {
    
        var ws = this;
       
        if (this._index === null){
            $.ajax({
                url: 'data/projects.json',
                dataType: 'json',
                data: {},
                success: function(data) {
				    ws._data = data;
                   //Creating new Colledctions based on the ws._data object
                    ws._projects = new ProjectCollection(data),
                   
                   /**
                    ws._assumptions: new AssumptionCollection(data),
                    ws._compromises: new CompromiseCollection(data),
                    ws._udemaps: new UdeMapCollection(data),
                    ws._clouds: new CloudCollection(data),
                    ws._negativeEffects: new NegativesEffectCollection(data),
                    ws._negativeConsequences: new NegativeConsequenceCollection(data),
                    ws._obstacles: new ObstacleCollection(data),
                	ws._injections: new InjectionCollection(data),
                	ws._roadmaps: new RoadMapCollection(data),
                	ws._milestones: new RoadMapMilestoneCollection(data),
                	*/
                	//ws._currentproject:null,
                	
                	//creating Views based on collections set 
                	ws._index = new IndexView({ model: ws._projects});
				    
				    Backbone.history.loadUrl();
                }
            });
            return this;
        }
        return this;
    }, //end of initiolize();
    
    /**
	 * Handle rendering the initial view for the application
	 * @type function
	*/
    index: function() {
        this._index.render();
    },
	
	/**
	 * Example of a function which is required for each View after the Index and Project
----
	 * TOC -> hasUdes: Handle URL routing for Udes. As Udes aren't
	 * traversed in the default initialization of the app, here we create a new
	 * UdeCollection for a particular project based on indices passed through
	 * the UI. We then create a new UdeView instance, render the Ude's
----
	 * All of this is cached using the CacheProvider we defined earlier
	 * 
	 * @type function
	 * @param {String}
	 *            id An ID specific to a particular project based on CIDs
	 */
	hasUdes:function(id){
		
	   var properindex = id.replace('c','');	
	   this._currentproject = properindex;
	   this._udes = cache.get('uc' + properindex) || cache.set('uc' + properindex, new UdeCollection(data[propertyindex].udes));
	   this._udeView = cache.get('uc' + properindex) || cache.set('uc' + properindex, new UdeCollection(data[propertyindex].udes));
	   
	   //this._subprojects = cache.get('pc' + properindex) || cache.set('pc' + properindex, new ProjectCollection(this._data[properindex].project));
	   //this._projects = cache.get('sv' + properindex) || cache.set('sv' + properindex, new SubalbumView({model: this._subprojects}));
	   this._udeView.render();
	},
	
	directproject: function(id){

	},

	/**
	 * TOC -> getProject: Handle routing for access to specific images within projects. This method 
	 * checks to see if an existing subprojects object exists (ie. if we've already visited the 
	 * project before). If it doesn't, we generate a new ProjectCollection and finally create 
	 * a new ProjectView to display the image that was being queried for. As per hasUdes, variable/data 
	 * caching is employed here too
	 * @type function
	 * @param {String} num An ID specific to a particular image being accessed
	 * @param {Integer} id An ID specific to a particular project being accessed
	 */
	  getProject: function(num, id){
	    this._currentproject = num;
	    
	    num = num.replace('c','');
	    
		if(this._subprojects == undefined){
		   this._subprojects = cache.get('pc' + num) || cache.set('pc' + num, new ProjectCollection(this._data[num].project));
		 }	
	    this._subprojects.at(id)._view = new ProjectView({model: this._subprojects.at(id)});
	    this._subprojects.at(id)._view.render();
	    
	  }
});


toc = new TOC();
Backbone.history.start();



