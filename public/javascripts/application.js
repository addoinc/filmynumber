jQuery(document).ready(function(){
    init_userbar();
    init_opinions();
});

function sucessful_login(){
    
    $('#page').load('/movies', init_opinions);
    
    $('#fnlsr').load('/user_session', init_userbar);
    if( $('#login_dialog').dialog('isOpen') ) {
	$('#login_dialog').dialog('close');
    }
    if( $('#register_dialog').dialog('isOpen') ) {
	$('#register_dialog').dialog('close');
    }
}

function profile_updated(){
}

function init_userbar(){
    jQuery("#login_dialog").dialog({
	bgiframe: true, autoOpen: false, height: 350, width: 400, modal: true,
	open: function(event, ui){
	    $('#login_dialog').load('/user_session/new', init_userbar_links);
	},
	close: function(event, ui){
	    if( $.client.os == "Linux" ) {
	        $('#chart').css('display', 'block');
	    }
	}
    });
   
    jQuery("#register_dialog").dialog({
	bgiframe: true, autoOpen: false, height: 350, width: 400, modal: true,
	open: function(event, ui){
		$('#register_dialog').load('/users/new');
	},
	close: function(event, ui){
	    if( $.client.os == "Linux" ){
	        $('#chart').css('display', 'block');
	    }
	}
    });

    jQuery("#profile_dialog").dialog({
	bgiframe: true, autoOpen: false, height: 350, width: 400, modal: true,
	open: function(event, ui){
		$('#profile_dialog').load('/account/edit');
	},
	close: function(event, ui){
	    if( $.client.os == "Linux" ){
	        $('#chart').css('display', 'block');
	    }
	}
    });

    init_userbar_links();
}

function init_userbar_links(){
    $('.login').click(function(event_obj){
	render_login_screen();
	event_obj.preventDefault();
	return false;
    });

    $('.register').click(function(event_obj){
	render_register_screen();
	event_obj.preventDefault();
	return false;
    });

    $('.profile').click(function(event_obj){
	render_profile_screen();
	event_obj.preventDefault();
	return false;	
    });
}

function render_register_screen(){
    if( $.client.os == "Linux" ) {
	$('#chart').css('display', 'none');
    }
    if( $('#login_dialog').dialog('isOpen') ) {
	$('#login_dialog').dialog('close');
    }
    jQuery('#register_dialog').dialog('open');
}

function render_login_screen(){
    if( $.client.os == "Linux" ) {
	$('#chart').css('display', 'none');
    }
    if( $('#register_dialog').dialog('isOpen') ) {
	$('#register_dialog').dialog('close');
    }
    jQuery('#login_dialog').dialog('open');
}

function render_profile_screen(){
    if( $.client.os == "Linux" ) {
	$('#chart').css('display', 'none');
    }
    jQuery('#profile_dialog').dialog('open');
}

function init_opinions(){
    
    $('.load_chart').click(function(event_obj){
	$("input[type='hidden'][name='current_movie_name']").val( $(event_obj.target).html() );
        load_movie_analytics( $(event_obj.target).attr('movie_id') );
	event_obj.preventDefault();
	return false;
    });

    $('.seen').click(function(event_obj){
	give_opinion(event_obj, "seen")
    });
    $('.watchable').click(function(event_obj){
	give_opinion(event_obj, "watchable")
    });
    $('.watchable_twice').click(function(event_obj){
	give_opinion(event_obj, "watchable_twice")
    });
    $('.watchable_multi').click(function(event_obj){
	give_opinion(event_obj, "watchable_multi")
    });
}

function give_opinion(event_obj, opinion_about){
    $("#" + opinion_about + "_wait_state_" + event_obj.target.value ).css('display', 'block');
    var opinion = event_obj.target.checked ? "1" : "0";
    var auth_token = $(":input[name='auth_token']")[0].value;
    $.ajax({
        type: 'POST',
	url: "/movies/" + event_obj.target.value + "/" + opinion_about,
	data: {
	    _method: "put", opinion: opinion, authenticity_token: auth_token
        },
	success: function(data) {
	    $("#" + opinion_about + "_wait_state_" + event_obj.target.value ).css('display', 'none');
        },
	error: function(data) {
	    event_obj.target.checked = false;
	    $("#" + opinion_about + "_wait_state_" + event_obj.target.value ).css('display', 'none');
	    render_login_screen();
	},
	dataType: 'text'
    });
}

function get_flex_app(app_name){
    if (navigator.appName.indexOf ("Microsoft") !=-1) {
	return document.frames['chart_frame'].document.getElementsByName(app_name)[0];
    } else {
	return document.getElementsByName('chart_frame')[0].contentWindow.document.getElementsByName(app_name)[0];
    }
}

function load_movie_analytics( movie_id ){
    get_flex_app("filmy").getMovieStats(movie_id); 
}

function get_movie_name(){
    return $("input[type='hidden'][name='current_movie_name']").val();
}
