$('.youtube_embed_partial_video').live('click', function() {
   $(this).hide();
   var parent = $(this).parent();
   $(".youtube_embed_main_video iframe", parent).attr('src', $(".youtube_embed_main_video iframe", parent).attr('src') + '?autoplay=1');
   $(".youtube_embed_main_video", parent).show();
});