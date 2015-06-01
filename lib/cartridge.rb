module Nes
  # Read ines file and built cartridge
  # @param filepath {string} file path
  # @return {nes.Cartridge} load cartridge
  def load(filepath)
    File.open(filepath) do |file|
      return Cartridge.new(1,1)
    end
  end
  
  class Cartridge
    def initialize(numPrgRom, numChrRom)
      @numPrgRom = numPrgRom
      @numChrRom = numChrRom
    end
  end
end