module Admin::ApplicationHelper
  def form_text_field option = {}
    %Q{
      <div class="form-group">
        <label>#{option[:text_label]}</label>
        <div class="input-group">
          <span class="input-group-addon">
            <i class="fa #{option[:text_class] || "fa-user"}"></i>
          </span>
          <input value="#{option[:text_value]}" class="form-control input-medium" type="#{option[:text_type]||'text'}" name="#{option[:text_name]}">
        </div>
      </div>
    }.html_safe
  end

  def form_select_field option = {}
    str = ''
    str += '<div class="form-group">'
    str += "<label>#{option[:text_label]}</label>"
    str += "<select class='form-control input-medium' name='#{option[:text_name]}'>"
    option[:text_option].each do |k, v|
      str += "<option value=#{k} selected='selected'>#{v}</option>"
    end
    str += '</select></div>'
    str.html_safe
  end
end