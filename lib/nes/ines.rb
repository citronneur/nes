require 'nes/cartridge'

ROM_CONTROL_HORIZONTAL_MIRRORING = 0x01
ROM_CONTROL_BATTERY_BACKED_RAM = 0x02
ROM_CONTROL_TRAINER = 0x04
ROM_CONTROL_FOUR_SCREEN_MIRRORING = 0x08
ROM_CONTROL_MAPPER_LOWER_MASK = 0xF0

module Nes
  module INes
    class << self
      # Read ines file and built cartridge
      # @param filepath {string} file path
      # @return {nes.Cartridge} load cartridge
      def load(filepath)
        File.open(filepath) do |file|
          
          raise 'invalid ines magic' unless file.read(4) == "NES\x1a"
          
          nb_pgr_rom = file.read(1).unpack('C')[0]
          nb_chr_rom = file.read(1).unpack('C')[0]
          rom_control_1 = file.read(1).unpack('C')[0]
          rom_control_2 = file.read(1).unpack('C')[0]
          nb_page_ram = file.read(1).unpack('C')[0]
          reserved = file.read(7).unpack('C')[0]
          # Read trainer block
          file.read(512) if !(rom_control_1 & ROM_CONTROL_TRAINER).zero?
          
          # Compute Mapper
          mapper = (rom_control_2 & ROM_CONTROL_MAPPER_LOWER_MASK) | (rom_control_1 & ROM_CONTROL_MAPPER_LOWER_MASK) > 4
          
          # Battery backed RAM
          battery = !(rom_control_1 & ROM_CONTROL_BATTERY_BACKED_RAM).zero?
          
          # Read program ROM
          prg_rom = file.read(nb_pgr_rom * 16384)
          
          # Read character ROM          
          chr_rom = file.read(nb_chr_rom * 8192)
          
          return Cartridge.new(prg_rom, chr_rom, mapper, battery)
        end
      end
    end
  end
end