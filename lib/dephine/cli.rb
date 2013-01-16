module Dephine
  class CLI
    class << self
      def start(args)
        banner = []
        banner << 'Dephine, Google dictionary in terminal'
        banner << 'Usage: dephine [word]'

        if args.empty?
          puts banner.join("\n")
        else
          define(args[0])
        end
      end

      private
      def define(arg)
        word = Dephine::Dictionary.new(arg)

        if word.meanings.empty?
          abort("Word not found in the dictionary!")
        end

        puts arg
        word.meanings.each do |m|
          puts
          puts "#{m[:type].downcase} #{m[:phonetic]}"
          m[:meanings].each do |d|
            puts "  #{d[:text]}"
            d[:examples].each do |eg|
              puts "    - #{eg}"
            end
            puts
          end
        end
      end
    end
  end
end
