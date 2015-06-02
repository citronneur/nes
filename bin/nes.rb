$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nes/ines'

Nes::INes::load('/home/sylvain/dev/rom/super_mario_bros.nes')
