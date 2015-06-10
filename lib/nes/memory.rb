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
  end
end