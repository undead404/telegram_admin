require 'administrate/field/base'

$break = "\r\n\r\n"

class MultiMessageField < Administrate::Field::Base
  def to_paragraphs
    return [''] if data.blank?

    paragraphs = []
    max_paragraph_length = resource.image.present? ? 200 : 4096
    inline_paragraphs = (data.split $break).map(&:strip).reject(&:blank?)
    next_paragraph = ''
    inline_paragraphs.each do |inline_paragraph|
      next_paragraph_extended = next_paragraph.present? ? "#{next_paragraph}#{$break}#{inline_paragraph}" : inline_paragraph
      if next_paragraph_extended.length > max_paragraph_length
        paragraphs.push next_paragraph
        next_paragraph = inline_paragraph
        max_paragraph_length = 4096
      else
        next_paragraph = next_paragraph_extended
      end
    end
    paragraphs.push next_paragraph
    paragraphs
  end

  def to_s
    if data.is_a? Array
      data.join $break
    else
      data.to_s
    end
  end
end
