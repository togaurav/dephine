require 'open-uri'
require 'json'

module Dephine
  class Dictionary
    # Public: Returns the Array meanings of the word.
    attr_reader :meanings

    # Public: Initialize some definitions of a word.
    #
    # word - A String to be defined.
    def initialize(word)
      raise ArgumentError, "Word shouldn't be blank" if word.empty?

      @meanings = []
      url = "https://www.google.com/dictionary/json?callback=define&q=#{word}&" \
      "sl=en&tl=en&restrict=pr%2Cde&client=te"

      # fetch and parse the json document
      content = JSON.parse(open(url).read[7..-11])

      content['primaries'].each do |primary|
        @meanings << {
          type: primary['terms'][0]['labels'][0]['text'],
          phonetic: primary['terms'][1]['text'],
          meanings: []
        }

        # add meanings
        primary['entries'][1..-1].each do |entry|
          @meanings[-1][:meanings] << {
            text: entry['terms'][0]['text'].gsub('x27', "'") \
              .gsub(/x3.*?3e/, ''),
            examples: []
          }

          # add examples of a meaning
          if entry.has_key?('entries')
            entry['entries'].each do |eg|
              @meanings[-1][:meanings][-1][:examples] << eg['terms'][0]['text'] \
                .gsub('x27', "'").gsub(/x3.*?3e/, '')
            end
          end

        end if primary.has_key?('entries')
      end if content.has_key?('primaries')
    end
  end
end
