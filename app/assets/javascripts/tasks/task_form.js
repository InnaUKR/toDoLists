var el = $('.btn-primary');
el.on('mouseenter', function() { el.one('mouseout', function () {
    $('.input').focus();
}) });

$(function () {
    $('#datetimepicker1').datetimepicker(
    );
});

$('#star-priority').raty({
    path: '/assets',
    scoreName: 'task[priority]'
});