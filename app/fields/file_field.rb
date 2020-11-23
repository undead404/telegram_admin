require 'administrate/field/base'

class FileField < Administrate::Field::Base
  def url(style)
    data.url(style)
  end

  def thumbnail
    data.url(:thumbnail)
  end

  def to_s
    data
  end
end
