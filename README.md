# RepoTube
*YouTube time-marked URLs from Git commit timestamps*

## Installation

```
$ gem install repotube
```

## Usage

```
$ repotube -h
repotube 0.3.0 -- YouTube time-marked URLs from Git commit timestamps

Usage:

  repotube [options] <youtube short URL>

Options:
-s SECONDS, --start SECONDS  Set the timestamp for the first commit; defaults to 0
-o SECONDS, --offset SECONDS  Set the offset, from the start of the video, for the first commit;
                           defaults to 0
   -f HASH, --first HASH   Set the hash of the first commit in the video
   -l HASH, --last HASH    Set the hash of the last commit in the video
-r USERNAME/REPO, --remote USERNAME/REPO  Set the remote repo path on GitHub; auto-detected if repo has a remote
-d FILENAME, --readme FILENAME  Set the README file name; defaults to README.md
        -n, --no-readme    Disable generating the README.md file
        -x, --no-intro     Supress '00:00:00 Introduction' marker in YouTube output
        -h, --help         Show this message
        -v, --version      Print the name and version
        -t, --trace        Show the full backtrace when an error occurs
```
