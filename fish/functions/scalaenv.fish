true (command scalaenv rehash 2>/dev/null &)
function scalaenv
  set command $argv[1]
  if [ (count $argv) -gt 0 ]
    set -e argv[1]
  end
  switch "$command"
  case rehash shell
    eval (scalaenv "sh-$command" $argv)
  case '*'
    command scalaenv "$command" $argv
  end
end
