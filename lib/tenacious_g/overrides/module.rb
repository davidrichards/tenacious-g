class Module
  # Stolen wholesale out of active_support.  I didn't want the whole gem
  # in this gem. 
  def alias_method_chain(target, feature)
    # Strip out punctuation on predicates or bang methods since
    # e.g. target?_without_feature is not a valid method name.
    aliased_target, punctuation = target.to_s.sub(/([?!=])$/, ''), $1
    yield(aliased_target, punctuation) if block_given?

    with_method, without_method = "#{aliased_target}_with_#{feature}#{punctuation}", "#{aliased_target}_without_#{feature}#{punctuation}"

    alias_method without_method, target
    alias_method target, with_method

    case
      when public_method_defined?(without_method)
        public target
      when protected_method_defined?(without_method)
        protected target
      when private_method_defined?(without_method)
        private target
    end
  end
  
  # Moves a method safely into a new name, only if it exists.  The default
  # name is original_#{method_name}.  So, archive_method(:x) creates
  # original_x as a method, and removes x, so that a module can then use
  # the x method name for something else.  To be honest, I'm not really
  # sure why I can't create a new method without overriding the old one,
  # it seems like it used to work, and I may have something boinked in my
  # system, but it's late and I could be wrong too. 
  def archive_method(target, opts={})
    target = target.to_sym
    prefix = opts[:prefix] || "original_"
    new_name = (prefix.to_s + target.to_s).to_sym
    define_method(target, lambda{nil}) if not method_defined?(target.to_s)
    
    alias_method(new_name, target)

    case
      when public_method_defined?(target)
        public new_name
      when protected_method_defined?(target)
        protected new_name
      when private_method_defined?(target)
        private new_name
    end
    
    remove_method(target)
  end
  
end
