ActionView::Base.field_error_proc = proc do |html_tag, instance|
  # Don't wrap fields in <div class="field_with_errors>...</div>
  html_tag
end
