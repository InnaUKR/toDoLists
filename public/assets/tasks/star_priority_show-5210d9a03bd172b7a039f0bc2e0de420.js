$(function () {
    $('.star-priority').raty({
        path: '/assets',
        readOnly: true,
        scoreName: 'task[priority]',
        score: function () {
            return $(this).attr('data-score');
        }
    });
});
