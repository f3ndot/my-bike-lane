# app/inputs/time_picker_input.rb
class TimePickerInput < SimpleForm::Inputs::Base
  def input
    out = ''
    out << '<div class="input-append bootstrap-timepicker">'.html_safe
    out << @builder.text_field(attribute_name, input_html_options)
    out << '<span class="add-on"><i class="icon-time"></i></span>'.html_safe
    out << '</div>'.html_safe
  end
end