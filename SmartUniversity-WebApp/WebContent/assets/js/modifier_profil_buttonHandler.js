$('#button-user').click(() =>{
    let isReadonly = $('#user').is('[readonly]');
    if(isReadonly)
    {
        $('#user').prop("readonly", false); 
    }
    else
    {
        $('#user').prop("readonly", true); 
    }
});

$('#button-pass').click(() =>{
    let isReadonly = $('#pass').is('[readonly]');
    if(isReadonly)
    {
        $('#pass').prop("readonly", false);
    }
    else
    {
        $('#pass').prop("readonly", true); 
    }
});

$('#button-nom').click(() =>{
    let isReadonly = $('#nom').is('[readonly]');
    if(isReadonly)
    {
        $('#nom').prop("readonly", false); 
    }
    else
    {
        $('#nom').prop("readonly", true); 
    }
});


$('#button-prenom').click(() =>{
    let isReadonly = $('#prenom').is('[readonly]');
    if(isReadonly)
    {
        $('#prenom').prop("readonly", false); 
    }
    else
    {
        $('#prenom').prop("readonly", true); 
    }
});

$('#button-adresse').click(() =>{
    let isReadonly = $('#adresse').is('[readonly]');
    if(isReadonly)
    {
        $('#adresse').prop("readonly", false); 
    }
    else
    {
        $('#adresse').prop("readonly", true); 
    }
});

$('#button-date_n').click(() =>{
    let isReadonly = $('#date_n').is('[readonly]');
    if(isReadonly)
    {
        $('#date_n').prop("readonly", false); 
    }
    else
    {
        $('#date_n').prop("readonly", true); 
    }
});

$('#button-email').click(() =>{
    let isReadonly = $('#email').is('[readonly]');
    if(isReadonly)
    {
        $('#email').prop("readonly", false); 
    }
    else
    {
        $('#email').prop("readonly", true); 
    }
});

$('#button-telephone').click(() =>{
    let isReadonly = $('#telephone').is('[readonly]');
    if(isReadonly)
    {
        $('#telephone').prop("readonly", false); 
    }
    else
    {
        $('#telephone').prop("readonly", true); 
    }
});