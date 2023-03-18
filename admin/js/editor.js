$(document).ready(function(){	
	function elFinderBrowser (callback, value, meta) {
  tinymce.activeEditor.windowManager.open({
	file: media_path,// use an absolute path!
    //file: '../elfinder/elfinder.html',
	title: 'elFinder 2.0',
    width: 900,  
    height: 450,
    resizable: 'yes'
  }, {
    oninsert: function (file, elf) {
      var url, reg, info;		
      // URL normalization
      url = file.url;	  
	  url = base_url + url.replace(media_replace_path, "");	
      reg = /\/[^/]+?\/\.\.\//;
      while(url.match(reg)) {
        url = url.replace(reg, '/');
      } 
      // Make file info
      info = file.name + ' (' + elf.formatSize(file.size) + ')';	 
      // Provide file and text for the link dialog
      if (meta.filetype == 'file') {
        callback(url, {text: info, title: info});
      }

      // Provide image and alt text for the image dialog
      if (meta.filetype == 'image') {       
		callback(url, {alt: info});
      }

      // Provide alternative source and posted for the media dialog
      if (meta.filetype == 'media') {
        callback(url);
      }
    }
  });
  return false;
};

var imageFilePicker = function (callback, value, meta) {               
    $("#image_box").modal("show");	
				
	var iframe0 = document.getElementById("image_media_box");
	var iframe0document=iframe0.contentDocument||iframe0.contentWindow.document;
	var inputIframe = iframe0document.getElementById("media_path");
	$("#add_image_to_editor").on('click', function(callback){
			set_media_editor();
			tinymce.activeEditor.insertContent("<img src='"+image_url_get+"' style='width: 480'>");
			callback(image_url_get);
		});
	//callback(inputIframe.value);
	/*tinymce.activeEditor.windowManager.open({
        title: 'Image Picker',
        url: inputIframe.value,
        width: 650,
        height: 550,
        buttons: [{
            text: 'Insert',
            onclick: function () {
                //.. do some work
				callback(inputIframe.value);
                tinymce.activeEditor.windowManager.close();
            }
        }, {
            text: 'Close',
            onclick: 'close'
        }],
    }, {
        oninsert: function (url) {
            callback(url);
            console.log("derp");
        },
    });*/
};

	tinymce.init({
		width:618,
		height:480,
		mode : "specific_textareas",
		
		editor_selector : "tct",
		 
		//selector: "textarea",
		plugins: [
		"advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
		"searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
		"save table contextmenu directionality emoticons template paste textcolor sh4tinymce "
		],	
		relative_urls: false,
		remove_script_host: false,
		toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | styleselect",
		toolbar2: "| link unlink anchor | image media | forecolor backcolor | print preview code | sh4tinymce",
		/*file_browser_callback: function(field_name, url, type, win) {
            if(type=='image') $('#my_form input').click();
        },*/
		image_advtab: true,		
		filemanager_crossdomain: false,	
		//file_browser_callback_types: 'file image media',
		//file_browser_callback : elFinderBrowser,
		file_picker_callback: function(callback, value, meta) {
           imageFilePicker(callback, value, meta);
          },
		setup :
		  function(ed) {
			ed.on('init', function() 
			{
				this.getDoc().body.style.fontSize = '14px';
			});
		  }
	});
	

	$("#save_post").click(function()
	{
		$("#save_post").attr('disabled','disabled');		
		$.ajax({
		           type: "POST",
		           url: ROOT_URL,
				    dataType:'html',
		            data:						
					{				    
						content: tinyMCE.activeEditor.getContent(),					
						title: $("#title").val(),						
						desc: $("#desc").val(),						
						avatar: $("#avatar").val(), 
						external_link: $("#external_link").val(),
						category: $("#category").val(),						
						status: $("#status").val(),
						key_word: $("#key_word").val(),
						meta_desc: $("#meta_desc").val(),										
						type: $("#type").val(),
						is_hot: $("#is_hot").val(),
						action: act
				   },	   
		           success: function(data)
		           {
						$("#save_post").removeAttr('disabled');
						$("#rs_msg").empty().append(data).fadeIn();	
						$("#save_post").blur();						
						if( (act == "edit_item_process") && data.replace(/(\r\n|\n|\r)/gm, "") == "Cập nhật thành công")
						{							
							setTimeout(function(){window.location.href = "post.jsp?action=view_list";}, 2000);	
						}
		           }
		         });
			    return false; 
	});		
});


function show_info()
	{
		var pre_post_intro = "<table> <tr> <td>";
		pre_post_intro += $("#tit").val();
		pre_post_intro += "</td> <tr> <td>";
		pre_post_intro += "<img src='"+$("#image_intro").val()+"'>";
		pre_post_intro += "</td> <td>";
		pre_post_intro += $("#post_intro").val();
		pre_post_intro += " </td> </tr> </table>";
		$("#rs").append(pre_post_intro);		
	}
function set_image()
{	
	var img = "<img src ='"+$("#image_add").val()+"' />";	
	$("#image_box").modal("hide");
}	
function show_base_url()
{	
	alert(baseurl);	
}

var img_over_view = "#img_over_view";

function set_media()
{
	/*var _path = $("#file_path").val();
	$(obj).empty().val(_path);
	$("#image_box").modal("hide");*/
	var iframe0 = document.getElementById("image_media_box");
	var iframe0document=iframe0.contentDocument||iframe0.contentWindow.document;
	var inputIframe = iframe0document.getElementById("media_path");
	$(obj).empty().val(inputIframe.value);
	$("#image_box").modal("hide");	
}
var image_url_get = "";
function set_media_editor()
{
	var iframe0 = document.getElementById("image_media_box");
	var iframe0document=iframe0.contentDocument||iframe0.contentWindow.document;
	var inputIframe = iframe0document.getElementById("media_path");	
	$("#image_box").modal("hide");	
	image_url_get = inputIframe.value;
}
	
function show_image_list()
{
	$("#image_box").show();
}
function get_image()
{
		var pot = $("#select_image:checked").val();
		var lt = '<img src="';
		var rt = '" />';
		$("#return_image_path").val(lt+$("#image_path_"+pot).html().trim()+"/"+$("#image_name_"+pot).html().trim()+rt);
}