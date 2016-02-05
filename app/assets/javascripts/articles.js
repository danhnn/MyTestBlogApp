function findBootstrapEnvironment() {
	    var envValues = ["xs", "sm", "md", "lg"];

	    var $el = $('<div>');
	    $el.appendTo($('body'));

	    for (var i = envValues.length - 1; i >= 0; i--) {
	        var envVal = envValues[i];

	        $el.addClass('hidden-'+envVal);
	        if ($el.is(':hidden')) {
	            $el.remove();
	            return i
	        }
	    };
	}

  function makeVerticalMenu(){
    $('.navbar-collapse').removeClass('navbar-nav');
    $('.navbar-collapse').removeClass('navbar-right');
  }

  function makeHorizontalMenu(){
    $('.navbar-collapse').addClass('navbar-nav');
    $('.navbar-collapse').addClass('navbar-right');
  }

  function handleGridResize(){
    var grid = findBootstrapEnvironment();

    if(grid > 1){
      $(".right-section").height($(".left-section").height());
      makeVerticalMenu();
    }else{
    
      makeHorizontalMenu(); 
    }
  }

  function gridResizeForRefresh(){
 		setTimeout(
           function() 
           {
              handleGridResize();

           }, 500);
  }

  function createDummyPost(){
  	 for (i = 0; i < 2 ; i ++) {
          var number = 2 + Math.floor(Math.random() * 3);
          var imageLink = "blog"+ number +".jpg";

          var objectToAppend = '<div class="post">' + 
            '<div class="div-post-image">'+
            '<%= image_tag("blog2.jpg", class: "parent-width fix-height-center") %>' +
          
            '</div>' +
            '<h2>Vegeterian Life</h2>' +
            '<p class="post-summary">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos quam consequatur, totam adipisci alias perspiciatis, quidem sapiente at sunt aperiam.</p>' +

            '<button class="btn btn-primary">Edit</button> ' +
            '<button class="btn btn-warning">Delete</button>' +

          '</div>';

            $(".posts-left").append(objectToAppend);
            $(".posts-right").append(objectToAppend);
          }
  }

  function makeSummaryParagraph(className,limitChar){
  	$(className).each(function(){
      		if( $(this).text().length > limitChar ){
            	var textToHide = $(this).text().substring(0,limitChar) + "...";
            		$(this).html(textToHide);
          		}
  			})
  }

  var ready;
  ready = function() {
     gridResizeForRefresh();

      $( window ).resize(function() {
        handleGridResize();
      });

      //createDummyPost();
      makeSummaryParagraph('.post-summary',100);     
      makeSummaryParagraph('.post-title',30);  
  };

$(document).ready(ready);
$(document).on('page:load', ready);
