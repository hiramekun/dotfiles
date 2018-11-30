function ndenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (ndenv sh-"$command" $argv|psub)
  case '*'
    command ndenv "$command" $argv
  end
end
