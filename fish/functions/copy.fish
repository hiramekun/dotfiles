function copy
  builtin echo $argv | perl -pe 'chomp'| xsel --clipboard --input
end
