function fish_prompt
    echo ""
    echo -n "(fish) "
    set_color --bold normal
    echo -n (prompt_pwd)
    set_color normal
    echo (git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ \@\1/")
    echo -n "❯ "
end
