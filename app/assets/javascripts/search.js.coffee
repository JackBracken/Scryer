# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(->
  $("[name='search[category_required][]']").chosen({max_selected_options: 2})
  $("[name='search[category_optional][]']").chosen()
  $("[name='search[character_required][]']").chosen({max_selected_options: 4})
  $("[name='search[character_optional][]']").chosen()
  $("[name='search[fandom]']").chosen().on('change', (e,p) -> handleFandom(e,p))
  $("[name='search[crossovers][]']").chosen({allow_single_deselect: true}).on('change', (e,p) -> handleFandom(e,p))
  $("[name='search[status]']").chosen({allow_single_deselect: true})
  $("[name='search[language]']").chosen({allow_single_deselect: true})
  $("[name='search[rating][]']").chosen()
  $("[name='search[sort_by]']").chosen()
  $("[name='search[order_by]']").chosen()

  $('#advanced_search :checkbox').click ->
    elem = $(this)

    label_elem = $("label[for='"+elem.attr("name")+"']")
    label = label_elem.data("type")
    if (elem.is(':checked'))
      label = "Excluded " + label
    else
      label = "Included " + label

    label_elem.text(label)

  handleFandom = (e,p) ->
    fandom = $("option:selected", $("[name='search[fandom]']"));
    crossover = $("option:selected", $("[name='search[crossovers][]']"));

    crossover_req = (crossover.map (c) -> "&fandom[]="+$(this).val()).toArray().join('')

    $.getJSON("/characters?fandom[]="+fandom.val()+crossover_req, (data) ->
      select = $("[name='search[character_required][]']")
      select2 = $("[name='search[character_optional][]']")
      options = select.prop('options')
      options2 = select2.prop('options')
      $('option', select).remove()
      $('option', select2).remove()

      $.each(data, (k,v) ->
        options[options.length] = new Option(v.name,v.character_id)
        options2[options.length] = new Option(v.name,v.character_id)
      )

      $("[name='search[character_required][]']").trigger('chosen:updated');
      $("[name='search[character_optional][]']").trigger('chosen:updated');
    )
)
