module MetaGraph
  #
  # HashAccessor module provide a function that read value from hash as method.
  # If this module is included on your class and specify a member variables symbol to
  # *hash_accessor* class macro, you can get methods named hash's key and call it,
  # then they will return hash's value.
  #
  module HashAccessor
    #
    # When this module is included on your class, it adds *hash_accessor* class macro to
    # included class.
    #
    def self.included(klass)
      klass.extend ClassMethods
    end

    #
    # mixins
    #
    module ClassMethods
      #
      # Specified your class member variable hash value in this method is to access as the
      # method.
      #
      def hash_accessor(hash_name)
        @hash_name = hash_name
      end
    end

    #
    # Read a hash value by specifing has key. Reading hash value In this method is
    # the hash that specified in _hash_accessor_ class macro.
    #
    # === Argument
    # [key] specify hash key
    #
    def read_hash(key)
      hash_name = self.class.instance_variable_get('@hash_name')
      hash = instance_variable_get("@#{hash_name}")

      hash[key] if hash.key?(key)
    end

    #
    # If the hash that specified to _hash_accessor_ class macro has a key same as 
    # the called method name, get the hash value.
    #
    def method_missing(method, *args, &block)
      value = read_hash(method) || read_hash(method.to_s)
      return value if value

      super(method, *args, &block)
    end
  end
end
