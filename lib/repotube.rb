#! /usr/bin/env ruby

require 'pathname'

module RepoTube
  VERSION = "0.1.0"

  class Program
    #COMMITS = `git log #{RANGE} --date=unix --format=tformat:"%at|%h|%s" --reverse`

    attr_reader :git_path, :url, :start, :offset, :first, :last, :commits

    def initialize(args,options)
      @git_path = Pathname.new(File.expand_path('.git', Dir.pwd))

      @url = args.last.chomp unless args.length < 1
      @start = set_value(options['start'].to_i, 0)
      @offset = set_value(options['offset'].to_i, 0)
      @first = set_value(options['first'], "")
      @last = set_value(options['last'], "HEAD")
      @remote = set_value(options['remote'], discover_remote)

      @commits = log_commits

    end

    def is_repo?
      @git_path.exist?
    end

    def log_commits
      # TODO: include the range
      if !@first.empty?
        range = "#{@first}~1..#{@last}"
      else
        range = ""
      end
      if is_repo?
        `git log #{range} --date=unix --format=tformat:"%at|%H|%s" --reverse`
      else
        puts "Oops. repotube must be run in a Git repository"
        abort
      end
    end

    def discover_remote
      `git remote -v`.split("\n")[0].match(/:(.+).git+/)[1]
    end

    def set_value(custom,default)
      if custom.to_s.empty?
        custom = default
      end
      custom
    end

    def process_commits
      commits = @commits.split("\n")

      commits.map! do |commit|
        c = commit.split("|")
        commit = {
          ut: c[0].to_i,
          ch: c[1],
          cs: c[2]
        }
      end

      commits[0][:offset] = @start
      commits[1][:offset] = @offset

      commits.each_index do |i|
        if (i > 1)
          commits[i][:offset] = commits[i-1][:ut] - commits[0][:ut] + @offset
        end
      end

      @commits = commits
    end

    def output_index
      puts "\nYouTube-Friendly Index by Commit"
      puts "(cut and paste into the YouTube description box):\n\n"
      @commits.each do |commit|
        puts  "#{Time.at(commit[:offset]).utc.strftime("%H:%M:%S")} #{commit[:cs]}"
      end
      puts "\n"
    end

    def output_markdown
      markdown = "## [YouTube Video](#{@url}) Indexes by Commit\n"
      @commits.each do |commit|
        markdown += "* [#{commit[:cs]}](https://github.com/#{@remote}/commit/#{commit[:ch]}) [[Video](#{@url}?t=#{commit[:offset]})]\n"
      end
      markdown
    end
    end

  end
end
