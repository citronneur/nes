module Nes
  class AdressingMode
    Immediate
  end
  class CPU
    def initialize(memory)
      @memory = memory
      @pc = 0x8000
      @carry_flag = 0
      @zero_flag = 0
      @interupt_disable = 0
      @decimal_mode_flag = 0
      @break_command = 0
      @overflow_flag = 0
      @negative_flag = 0
      
      @instruction = {
        0x78 => lambda { self.sei },
        0xD8 => lambda { self.cld AdressingMode::Immediate }
      }
    end
    
    def step()
      opcode = @memory.read(@pc)
      @pc += 1
      puts opcode
      @instruction[opcode].call
    end
    
    # set interrupt disable
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#SEI
    def sei()
      puts 'set interrupt disable'
      @interupt_disable = 1
    end
    
    # clear decimal model
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#CLD
    def cld()
      puts 'clear decimal model'
      @decimal_mode_flag = 0
    end
  end
end