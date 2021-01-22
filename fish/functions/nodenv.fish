command nodenv rehash 2>/dev/null
function nodenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (nodenv sh-"$command" $argv|psub)
  case '*'
    command nodenv "$command" $argv
  end
end
