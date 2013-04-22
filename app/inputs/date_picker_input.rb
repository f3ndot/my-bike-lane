# app/inputs/date_picker_input.rb
class DatePickerInput < SimpleForm::Inputs::Base
  def input
    out = ''
    out << '<div class="input-append date">'.html_safe
    out << @builder.text_field(attribute_name, input_html_options)
    out << '<span class="add-on"><i class="icon-calendar"></i></span>'.html_safe
    out << '</div>'.html_safe
  end
end