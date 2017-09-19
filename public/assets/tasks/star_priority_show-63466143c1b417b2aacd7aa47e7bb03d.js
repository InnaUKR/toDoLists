$('.star-priority').raty({
    path: '/assets',
    readOnly: true,
    score: function() {
        return $(this).attr('data-score');
    }
});
