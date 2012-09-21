previewMarkdown = ($markdown) ->
  $.post "/admin/players/preview_markdown", {markdown: $markdown.val()}, (data) ->
    $('#markdown-preview').html(data)

$ ->
  $markdown = $('textarea#player_bio, textarea#article_body')

  if $markdown.length > 0
    $markdown.closest('ol').append('<li><label>Markdown Preview</label><div id="markdown-preview"></div></li>')

    previewMarkdown($markdown)

    $markdown.keyup (e) ->
      previewMarkdown($markdown)
