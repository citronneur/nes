module Nes
  class Memory
    # @param mapper {Mapper} program rom mapper
    def initialize(mapper)
      @mapper = mapper
    end
    
    # Read address from memory and return byte
    # @param address {integer} address in memory
    def read(address)
      # Program ROM adress
      return @mapper.read(address) if address >= 0x8000
    end
    
    # Write value at address
    # @param address {integer (uint16)} memory address
    # @param value {integer (uint8)} value to write
    def write(address, value)
      puts "0x#{address.to_s(16)} = #{value}"
    end
  end
end