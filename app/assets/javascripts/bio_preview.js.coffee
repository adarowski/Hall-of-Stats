previewBio = ($bio) ->
  $.post "/admin/players/preview_bio", {bio: $bio.val()}, (data) ->
    $('#bio-preview').html(data)

$ ->
  $bio = $('textarea#player_bio')

  if $bio.length > 0
    $bio.closest('ol').append('<li><label>Bio Preview</label><div id="bio-preview"></div></li>')

    previewBio($bio)

    $bio.keyup (e) ->
      previewBio($bio)
