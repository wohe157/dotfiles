if status --is-login; and not set -q __fish_login_config_sourced
    set -xg EDITOR nvim
    set -xg MANPAGER 'nvim +Man!'
    set -xg LC_ALL en_US.UTF-8
    set -xg LC_CTYPE en_US.UTF-8
    set -xg PYENV_ROOT $HOME/.pyenv

    fish_add_path ~/bin ~/.local/bin /opt/homebrew/bin

    set -x __fish_login_config_sourced 1
end

if status --is-interactive
    if type -q direnv
        eval (direnv hook fish)
    end
    if type -q pyenv
        pyenv init --path --no-rehash | source
    end

    abbr gf "git fetch --all --prune"
    abbr gg "git log --all --oneline --graph -n20"
    abbr gs "git status"

    set fish_greeting
end
