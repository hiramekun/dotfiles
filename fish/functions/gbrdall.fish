function gbrdall
  git branch | grep $argv | xargs git branch -d
end
