module Nes
  class Cartridge
    attr_reader :mapper
    attr_reader :prg_rom
    # @param prg_roms {String} list of program roms
    # @param chr_roms {String} list character roms
    # @param mapper {Integer} mapper number
    # @param battery {Boolean} battery backed RAM
    def initialize(prg_rom, chr_rom, mapper, battery)
      @prg_rom = prg_rom
      @chr_rom = chr_rom
      @mapper = mapper
      @battery = battery
    end
  end
end