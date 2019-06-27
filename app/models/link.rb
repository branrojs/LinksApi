class Link < ApplicationRecord
  validates :url, presence: true,
                  format: {
                    with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}(:[0-9]{1,5})?(\/.*)?\z/ix, 
                    message: 'The string provided is not an url'
                  },
                  uniqueness: true
end
