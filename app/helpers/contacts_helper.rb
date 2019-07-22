module ContactsHelper
  def show_non_blank_field(label, value)
    "<tr><th>#{label}:</th><td>#{show_as_link(value)}</td></tr>".html_safe unless value.blank?
  end

  def show_as_link(value)
    value.match(%r{^(http|https)://}) ? "<a href=#{value}>#{value}</a>".html_safe : value
  end
end
