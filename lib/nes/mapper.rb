module Nes
  module Mapper
    class << self
      # load mapper from cartridge
      # @param cartridge {Cartridge}
      def load(cartridge)
        raise 'invalid mapper' unless cartridge.mapper == 0
        return NROM.new(cartridge.prg_rom);
      end
    end
    
    # Mapper ineterface
    class Mapper
      # Read address from prg rom
      # @param address {address}
      def read(address)
        raise 'not implemented'
      end
    end
    
    # No mapper
    class NROM < Mapper
      # load from cartridge
      # @param prg_rom {string}
      def initialize(prg_rom)
        @prg_rom = prg_rom
      end
      
      # read directly from prg rom
      # @param address {integer}
      def read(address)
        return @prg_rom[address - 0x8000]
      end
    end
  end
end