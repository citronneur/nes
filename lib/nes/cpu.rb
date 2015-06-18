module Nes
  class AddressingMode
    Immediate = 0
    Absolute = 1
  end
  class CPU
    def initialize(memory)
      # memory
      @memory = memory
      
      # program counter
      @pc = 0x8000
      
      # cpu flags
      @carry_flag = 0
      @zero_flag = 0
      @interupt_disable = 0
      @decimal_mode_flag = 0
      @break_command = 0
      @overflow_flag = 0
      @negative_flag = 0
      
      # registers
      @a = 0 # accumulator
      @s = 0 # stack
      @x = 0
      
      @instruction = {
        0x78 => lambda { self.sei },
        0x8D => lambda { self.sta AddressingMode::Absolute },
        0x9A => lambda { self.txs },
        0xA2 => lambda { self.ldx AddressingMode::Immediate },
        0xA9 => lambda { self.lda AddressingMode::Immediate },
        0xD8 => lambda { self.cld }
      }
    end
    
    # run CPU
    def run()
      while true
        opcode = @memory.read(@pc)
        @pc += 1
        puts opcode.to_s(16)
        break unless @instruction.has_key?(opcode)
        @instruction[opcode].call
        # print flags
        puts "CF{#{@carry_flag}} ZF{#{@zero_flag}} ID{#{@interupt_disable}} DM{#{@decimal_mode_flag}} BC{#{@break_command}} OF{#{@overflow_flag}} NF{#{@negative_flag}}"
        # print registers
        puts "A{#{@a}} S{#{@s}} X{#{@x}}"
        yield
      end
    end
    
    # set interrupt disable
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#SEI
    def sei()
      puts 'SEI'
      @interupt_disable = 1
    end
    
    # store accumulator
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#STA
    # @param addressing_mode {AdressingMode} type of adressing mode
    def sta(addressing_mode)
      puts 'STA'
      case addressing_mode
      when AddressingMode::Absolute
        address = @memory.read(@pc)
        address = address << 8 + @memory.read(@pc + 1)
        @pc += 2
        @memory.write(address, @accumulator)
      end
    end
    
    # load into accumulator register
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#LDA
    # @param addressing_mode {AdressingMode} type of adressing mode
    def lda(addressing_mode)
      puts 'LDA'
      case addressing_mode
      when AddressingMode::Immediate
        @a = @memory.read(@pc)
        @pc += 1
      end
    end
    
    # clear decimal model
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#CLD
    def cld()
      puts 'CLD'
      @decimal_mode_flag = 0
    end
    
    # Load x register
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#LDX
    # @param adressing_mode {AdressingMode} type of adressing mode
    def ldx(addressing_mode)
      puts 'LDX'
      case addressing_mode
      when AddressingMode::Immediate
        @x = @memory.read(@pc)
        @pc += 1
      end
      @zero_flag = 1 if @x == 0
      @negative_flag = 1 if @x & 0x80
    end
    
    # Transfer x to stack(s) register
    # @see http://www.obelisk.demon.co.uk/6502/reference.html#TXS
    def txs()
      puts 'TXS'
      @s = @x
    end
  end
end