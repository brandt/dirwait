require "listen"

# Private: Monkeypatch Listen to allow reporting of directory changes
module Listen
  class Change
    def change(path, options)
      return if _silencer.silenced?(path, options[:type])

      if change = options[:change]
        _notify_listener(change, path)
      else
        _file_change(path, options)
        _dir_change(path, options) if options[:type] == "Dir"
      end
    end
  end
end

module DirWait
  # Public: Watch the filesystem and wait for a directory to be created.
  class Watch
    # Public: Initialize a new watcher.
    #
    # path  - The String path to watch.
    def initialize(path)
      @watch_path = path
      @existing_parent = find_existing(path)
    end

    # Internal: Find the highest existing directory in a given path.
    #
    # path  - A String path to search.
    #
    # Examples
    #
    #   find_existing('/usr/local/foo')
    #   # => '/usr/local'
    #
    # Returns the String path to the top-most existing directory.
    def find_existing(path)
      until File.directory?(path)
        path = File.dirname(path)
      end
      path
    end

    # Public: Start the initialized listener.
    #
    # Exits cleanly (exit code: 0) if @watch_path was created.
    def start
      $stderr.puts "Watching filesystem events in: #{@existing_parent}"

      callback = Proc.new do |modified, added, removed|
        if added.any? {|i| File.fnmatch(@watch_path, i) }
          puts "Added: #{@watch_path}"
          exit 0
        end
      end

      listener = Listen.to(@existing_parent, ignore!: [], &callback)
      listener.start

      # Set trap so that we can break out of `sleep`
      Signal.trap("INT") do
        puts "Exiting..."
        exit 4
      end

      sleep
    end
  end
end
