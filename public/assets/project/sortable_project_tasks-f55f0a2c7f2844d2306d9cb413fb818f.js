var ready;
ready = function(){
    $('.sortable').sortable();
}

$(document).ready(ready);
$(document).on('page:load', ready);
