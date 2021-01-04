RSpec::Matchers.define :have_content_type do |expected|
  match do |actual|
    begin
      actual.content_type == content_type(expected)
    rescue ArgumentError
      false
    end
  end
  
  def content_type(type)
    types = {
      html: "text/html",
      json: "application/json",
    }
    types[type.to_sym] || "unknowncontent type"
  end
end