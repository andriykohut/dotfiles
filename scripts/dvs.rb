#!/usr/bin/env ruby
# Just delete vim session files

SESSION_PATH = "#{ENV['HOME']}/.vim/sessions/"


def remove_session_files(session_path)
  Dir.foreach(session_path) do |item|
    if not item.start_with? '.'
      fpath = File.join(session_path, item)
      File.delete(fpath)
      puts "'#{item}' deleted"
    end
  end
end

if __FILE__ == $0
  remove_session_files SESSION_PATH
end
