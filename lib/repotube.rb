#! /usr/bin/env ruby

module RepoTube
  VERSION = "0.0.0"

  START_TIME = 3370
  OFFSET = 5587
  RANGE = "84132b8~1..dd71748"
  COMMITS = ""
  #COMMITS = `git log #{RANGE} --date=unix --format=tformat:"%at|%h|%s" --reverse`
  def refactor_me

    commits = COMMITS.split("\n")

    commits.map! do |commit|
      c = commit.split("|")
      commit = {
        ut: c[0].to_i,
        ch: c[1],
        cs: c[2]
      }
    end

    commits[0][:offset] = START_TIME
    commits[1][:offset] = OFFSET

    commits.each_index do |i|
      if (i > 1)
        commits[i][:offset] = commits[i-1][:ut] - commits[0][:ut] + OFFSET
      end
    end

    puts "Video Index:"
    commits.each do |commit|
      puts "#{commit[:cs]}: https://youtu.be/V-rIj30x_LM?t=#{commit[:offset]}"
    end


    # START_TIME = 1310 seconds (work begins on what will be the first commit)
    # OFFSET = 2589 seconds (from start to first commit)

    # A 1536785896 | Add and link to stylesheet; start: START_TIME [1310]
    # B 1536785931 | Add minified Eric Meyer Reset CSS; start: OFFSET [2552]
    # C 1536787245 | Add viewport meta element; start: [C - B] 1314 + B.OFFSET [3866]
    # D 1536787353 | start: [D - C] 108 + C.OFFSET [3974] >
    # D happens at 4009

    # A: 0 [t=1310]
    # B: 35 seconds after A [t=2552] (A commit; begin B)
    # C: 1349 seconds after A [t=2587] (B commit; begin C)
    # D: 1457 seconds after A [t=3901] (C commit; begin D)

    #
    # SO.
    #
    # A will get the start time specified as START_TIME
    # B will get the start time specified as OFFSET
    # C will get the start time of B's start time + [B - A]
    # D will get the start time of C's start time + [C - A]
    # D's seconds after C do not matter
  end
end
