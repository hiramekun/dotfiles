function do_enter
  set -l query (commandline)

  if test -n $query
    echo
    eval $query
    echo
    commandline ''
  else
    echo
    ls
    if test (git rev-parse --is-inside-work-tree 2> /dev/null)
      echo
      echo -e "\e[0;33m--- git status ---\e[0m"
      git status -sb
    end
    echo
  end
  commandline -f repaint
end
