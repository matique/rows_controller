module Rows::Utils

# formatting
  def resource_format(x)
    return '--'.html_safe  if x.nil?
    bool = x.class == Time || x.class == Date || x.class == DateTime ||
	   x.class == ActiveSupport::TimeWithZone
    return x.strftime('%d.%m.%Y').html_safe  if bool
#    return I18n.l(x)                if bool
#    return x.to_s.html_safe         if x.class == Fixnum
    return x.to_s.html_safe         if x.kind_of?(Integer)
    return 'X'.html_safe            if x.class == TrueClass
    return '&ensp;'.html_safe       if x.class == FalseClass
    return x.call                   if x.class == Proc
    return '---'.html_safe          if x.empty?
    str = x.to_s
    return str.gsub(/\r*\n/, '<br/>')
  end

end
