$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nes/ines'
require 'nes/cpu'
require 'nes/mapper'
require 'nes/memory'

cartridge = Nes::INes::load('/home/sylvain/dev/rom/super_mario_bros.nes')

cpu = Nes::CPU.new(Nes::Memory.new(Nes::Mapper::load(cartridge)))
(0...100).each do
  cpu.step()
end
