# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(->
  $("[name='search[category_required][]']").chosen({max_selected_options: 2})
  $("[name='search[category_optional][]']").chosen()
  $("[name='search[character_required][]']").chosen({max_selected_options: 4})
  $("[name='search[character_optional][]']").chosen()
  $("[name='search[fandom]']").chosen()
  $("[name='search[crossovers]']").chosen({allow_single_deselect: true})
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
)
