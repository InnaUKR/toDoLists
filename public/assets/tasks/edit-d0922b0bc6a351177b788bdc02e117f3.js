$(function () {
    $('#datetimepicker1').datetimepicker(
    );
});



$('#star-priority').raty({
    path: '/assets',
    scoreName: 'priority',
    score: function() {
        return $(this).attr('data-score');
    }
});
