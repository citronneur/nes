module Nes
  class Cartridge
    # @param prg_roms {Array} list of program roms
    # @param chr_roms {Array} list character roms
    def initialize(prg_roms, chr_roms)
      @prg_roms = prg_roms
      @chr_roms = chr_roms
    end
  end
end