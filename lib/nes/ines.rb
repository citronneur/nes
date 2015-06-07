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
          reserved = file.read(1).unpack('C')[0]
          # Read trainer block
          file.read(512) if !(rom_control_1 & ROM_CONTROL_TRAINER).zero?
          
          prg_roms = Array.new
          (0...nb_pgr_rom ).each do |i|
            prg_roms.push(file.read(16384))
          end
          
          chr_roms = Array.new
          (0...nb_chr_rom).each do |i|
            chr_roms.push(file.read(8192))
          end
          
          return Cartridge.new(prg_roms,chr_roms)
        end
      end
    end
  end
end