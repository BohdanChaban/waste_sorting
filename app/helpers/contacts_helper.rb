module ContactsHelper
	def show_non_blank_field(label, value)
  content_tag(:th, "#{label}:", colspan: ["3"]) + content_tag(:td,"#{value}") unless value.blank?
  end
end
