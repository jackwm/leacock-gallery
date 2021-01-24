LeacockGallery.helpers do

  def quantify(word, n)
    if n > 1
      word.pluralize
    else
      word
    end
  end

end
