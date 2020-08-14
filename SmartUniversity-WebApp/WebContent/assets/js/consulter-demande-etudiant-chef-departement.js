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
	for(span of spans)
	{
		span.onclick = function() {
		  modal.style.display = "none";
		}
	}
});