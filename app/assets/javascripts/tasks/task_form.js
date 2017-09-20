var el = $('.btn-primary');
el.on('mouseenter', function() { el.one('mouseout', function () {
    $('.input').focus();
}) });

$(function () {
    $('.datetimepicker1').datetimepicker(
    );
});