$(document).ready(function () {
	// Get the modal of the image
	let modals = document.getElementsByClassName("modal-img-justification");
	
	// Get the image and insert it inside the modal - use its "alt" text as a caption
	let imgs = document.getElementsByClassName("justification-image");
	let modalImgs = document.getElementsByClassName("img-modal");
	let captionTexts = document.getElementsByClassName("caption-modal-justification");
	
	for(img of imgs)
	{
		img.onclick = function(){
			for(modal of modals)
			{
			  modal.style.display = "block";
			} 
			
			for(modalImg of modalImgs)
			{
			  modalImg.src = this.src;
			}
			
			for(captionText of captionTexts)
			{
			  captionText.innerHTML = this.alt;
			}
		}
	}
	// Get the <span> element that closes the modal
	let spans = document.getElementsByClassName("close-img-modal");
	
	// When the user clicks on <span> (x), close the modal
	for(span of spans)
	{
		span.onclick = function() {
		  modal.style.display = "none";
		}
	}
	//upload file
    $('input[type="file"]').change(function(e){
        let fileName = e.target.files[0].name;
        let fileExtention = fileName.split('.').pop();
        
        if(fileName.length > 10)
       	{
        	fileName = fileName.substring(0, 10) + "..." + fileExtention;
       	}
        
        $('.custom-file-label').html(fileName);
    });
    
    //preview justification selected in upload case
    function readURL(input, target) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();
            
            reader.onload = function (e) {
                target.attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#input-upload-justification").change(function(){
        readURL(this, $('#justification-out-modal'));
    });
    
    $("#input-upload-justification-modal").change(function(){
        readURL(this, $('#justification-in-modal'));
    });
    
    //table des historoqies
    
    let tablePageLength = 5;
    
	let table =  $('#table-historique').DataTable({
		"sDom": '<"top">rt<"bottom"p><"clear">',
		"pageLength": tablePageLength,
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sZeroRecords": "Aucune autre justification n'a été enregistrer.",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 2 }
       	  ],  
    });

});