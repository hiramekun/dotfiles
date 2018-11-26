function copy
  builtin echo $argv | perl -pe 'chomp'| pbcopy
end
