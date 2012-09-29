previewMarkdown = ($markdown, context) ->
  params = {markdown: $markdown.val(), context: context}
  $.post "/admin/players/preview_markdown", params, (data) ->
    $('#markdown-preview').html(data)

$ ->
  $markdown = $('textarea#player_bio, textarea#article_body')
  playerId = $('#edit_player fieldset.inputs:first').attr('id')

  if $markdown.length > 0
    $markdown.closest('ol').append('<li><label>Markdown Preview</label><div id="markdown-preview"></div></li>')

    previewMarkdown($markdown, playerId)

    $markdown.keyup (e) ->
      previewMarkdown($markdown, playerId)
