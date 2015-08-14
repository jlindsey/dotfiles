require 'pry'
%w[pry-doc pry-stack_explorer awesome_print pry-byebug coolline coderay].each do |lib|
  begin
    require lib
  rescue LoadError
    warn "Unable to load #{lib}"
  end
end

module PryConfig
  # Namespace this setup and call it later so we don't polute
  # the global namespace within a pry session.
  def self.setup!
    Pry.config.should_load_plugins = false
    Pry.config.pager = false
    Pry.config.correct_indent = false
    AwesomePrint.pry!

    Pry.config.input = Coolline.new do |c|
      c.transform_proc = proc do
        CodeRay.scan(c.line, :ruby).term
      end

      c.completion_proc = proc do
        word = c.completed_word
        Object.constants.map(&:to_s).select { |w| w.start_with? word }
      end
    end

    color = -> { Pry.color }
    red  = ->(text) { color[] ? "\001\e[0;31m\002#{text}\001\e[0m\002" : text.to_s }
    blue = ->(text) { color[] ? "\001\e[0;34m\002#{text}\001\e[0m\002" : text.to_s }
    bold = ->(text) { color[] ? "\001\e[1m\002#{text}\001\e[0m\002"    : text.to_s }

    separator = -> { red.(defined?(RbReadline) ? '>' : "\u00BB") }
    name = 'pry'
    colored_name = -> { blue.(name) }

    line = ->(pry) { "[#{bold.(pry.input_array.size)}] " }
    target_string = ->(object, level) do
      level = 0 if level < 0
      unless (string = Pry.view_clip(object)) == 'main'
        "(#{'../' * level}#{string})"
      else
        colored_name.()
      end
    end

    Pry.config.prompt = [
      ->(object, level, pry) do      # Main prompt
        "#{line.(pry)}#{target_string.(object, level)} #{separator.()}  "
      end,
      ->(object, level, pry) do      # Wait prompt in multiline input
        spaces = ' ' * (
          "[#{pry.input_array.size}] ".size +  # Uncolored `line.(pry)`
          name.size +
          target_string.(object, level).size
        )
        "#{spaces} #{separator.()}  "
      end
    ]
  end
end

PryConfig.setup!
