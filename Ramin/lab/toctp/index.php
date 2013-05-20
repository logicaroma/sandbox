<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <title>Theory Of Constrainst 'Thinking Processes Tool'</title>
        <link rel="stylesheet" href="project.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="shadows.css" type="text/css" media="screen" />
		<link rel="stylesheet" href="buttons.css" type="text/css" media="screen" />
		<script id="indexTmpl" type="text/x-jquery-tmpl">
                <div class="item drop-shadow round">
                 <div class="item-image">
                     <a href="#project/${cid}"><img src="${attributes.image}" alt="${attributes.title}" /></a>
                 </div>
                 <div class="item-artist">${attributes.artist}</div>
                    <div class="item-title">${attributes.title}</div>
                    <div class="item-years">${attributes.years}</div>
                </div>
                </script>
				
			
				<script id="projectTmpl" type="text/x-jquery-tmpl">
                <div class="item  drop-shadow round">
                 <div class="item-image project">
                     <a href="#project/${project}/${attributes.pid}"><img src="${attributes.image}" alt="${attributes.title}" alt="No images in this folder"/></a> 
                 </div>
                 <div class="item-artist">${attributes.artist}</div>
                    <div class="item-title">${attributes.title}</div>
                    <div class="item-price">$${attributes.price}</div>
                </div>
	
                </script>
				
     
                <script id="UdeTmpl" type="text/x-jquery-tmpl">
                <div class="item-detail">
                  <div class="item-image drop-shadow round"><img src="${attributes.large_image}" alt="${attributes.title}" /></div>
                  <div class="item-info">
                    <div class="item-artist">${attributes.artist}</div>
                    <div class="item-title">${attributes.title}</div>
                    <div class="item-price">$${attributes.price}</div>
					<br />
                    <div class="item-link"><a href="${attributes.url}" class="button">Buy this item</a></div>
                    <div class="back-link"><a href="#" class="button">&laquo; Back to Albums</a></div>
                  </div>
                </div>
                </script>

    </head>
    <body>
        <div id="container">
            <div id="header">
                <h1>
                    <a href="index.php">Multi-Level Backbone Gallery</a>
                </h1>
                <h3>Created by Addy Osmani for 'Building Single-page Apps With jQuery's Best Friends'</h3>
            </div>

            <div id="main">
                 <div class="jstest">This application is running with JavaScript turned off.</div>
            </div>
        </div>
        <script src="js/LAB.min.js" type="text/javascript"></script>

        
<?


//PHP fallback to enable graceful degredation


//feel free to substitute with a more secure read-in method
$json = file_get_contents("data/projects.json");
$json_a=json_decode($json,true);
$folderType = $_GET['view'];
$index = $_GET['index'];
$project = $_GET['project'];
$projects = array();
$udes = array();
$i =0; $j =0;
error_reporting(0);

//expose convenient access to projects
foreach ($json_a as $p => $k){
    foreach($k["project"] as $aProject){ 
		 $projects[$i][$j] = $aProject;
         $j++;
	}
	$i++;
} 

//handle 'view' switching
switch($folderType){
	case "project":
		echo "<ul class='project'>";
		 foreach($projects[$index] as $aProject){
			  echo "<li class='item drop-shadow round'><a href='#'>" . $aProject['name'] . "</a>
			  <p>" . $aProject['description'] 	. "</p>
			  <p>" . $aProject['goal']  		. "</p>
			  <p>" . $aProject['createdAt'] 	. " </p> </li>";
		  } 
		echo "</ul>";	    
	break;
	case "ude":
		echo "<ul class='ude'>";
		 foreach($udes[$index] as $aUde){
		   echo "<li class='item drop-shadow round'><a href='#'>" . $aUde['description'] . "</a>
			  <p>" . $aUde['type'] 	. "</p>
			  <p>" . $aUde['connected']  		. "</p> </li>";
		  } 
		echo "</ul>";	    
	break;
	default:
	    $index = 0;
		echo "<ul class='toc'>";
		foreach($json_a as $p => $k){
		   echo "<li class='item drop-shadow round'><a href='index.php?view=project&ind=$index'><img src='" . $k['name'] . "'></img>" .  $k['title']  . "</a> " . $k['years'] ." </li>";
		   $index++;
		}
		echo "</ul>";
	break;
}


?>
        <script type="text/javascript">
		   $LAB
		   .script("js/jquery-1.4.4.min.js").wait()
		   .script("js/jquery.tmpl.min.js")
		   .script("js/underscore-min.js")
		   .script("js/backbone-min.js")
		   .script("js/cacheprovider.js").wait()
		   .script("toctp.js");      
        </script>
    </body>
</html>
