require 'nes/cartridge'

module Nes
  module INes
    class << self
      # Read ines file and built cartridge
      # @param filepath {string} file path
      # @return {nes.Cartridge} load cartridge
      def load(filepath)
        File.open(filepath) do |file|
          raise 'invalid ines magic' unless file.read(4) == "NES\x1a"
          return Cartridge.new(1,1)
        end
      end
    end
  end
end