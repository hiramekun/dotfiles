function fish_prompt
	set laststatus $status
    set_color -o normal
    printf '❰' 
	set_color normal
	printf '%s' $USER
    set_color -o normal
    printf '❙'
	set_color -o $fish_color_cwd
    printf '%s' (echo $PWD | sed -e "s|^$HOME|~|")
    set_color -o normal
    printf '❱' 
	set_color normal
	printf '%s ' (__fish_git_prompt)

    if test $laststatus -eq 0
		printf "\n%s>> " (set_color -o $fish_color_cwd)
    else
        printf "\n%s>> " (set_color -o red)
    end

	set_color $fish_color_cwd
end
