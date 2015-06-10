module Nes
  class CPU
    def initialize(memory)
      @memory = memory
      @pc = 0x8000
    end
    
    def step()
      opcode = @memory.read(@pc)
      puts opcode
    end
  end
end