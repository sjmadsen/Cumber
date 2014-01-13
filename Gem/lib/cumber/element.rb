module Cumber

  class Element
    include Cumber

    attr_accessor :name

    def self.find_by_name(name)
      command = "mainWindow.withName('#{name}');"
      Cumber.execute_step(command)
    end

    def initialize(name = nil)
      @name = name
    end

  end

end