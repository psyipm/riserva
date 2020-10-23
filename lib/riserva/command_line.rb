require 'choice'

Choice.options do
  option :perform do
    short '-p'
    long '--perform=OPERATION'
    desc 'Operation to perform, valid options: backup (default), clean'
    valid %w[backup clean]
    default 'backup'
  end

  header ''
  header 'Specific options:'

  option :config do
    short '-C'
    long '--config=CONFIG'
    desc 'Path to riserva.yml, can also be defined as RISERVA_CONFIG environment variable'
  end

  separator ''
  separator 'Common options: '

  option :help do
    long '--help'
    desc 'Show this message'
  end

  option :version do
    short '-v'
    long '--version'
    desc 'Show version'
    action do
      puts Riserva.version
      exit
    end
  end
end
