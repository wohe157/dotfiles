if status --is-login; and not set -q __fish_login_config_sourced
    set -xg EDITOR nvim
    set -xg MANPAGER 'nvim +Man!'
    set -xg LC_ALL en_US.UTF-8
    set -xg LC_CTYPE en_US.UTF-8
    set -xg PYENV_ROOT $HOME/.pyenv

    fish_add_path ~/bin ~/.local/bin /opt/homebrew/bin
    fish_add_path /opt/homebrew/opt/curl/bin

    set -x __fish_login_config_sourced 1
end

if status --is-interactive
    if type -q direnv
        eval (direnv hook fish)
    end
    if type -q pyenv
        pyenv init --path --no-rehash | source
    end

    abbr nv "nvim"
    abbr pnv "poetry run nvim"

    abbr ga "git add"
    abbr gA "git add -A"
    abbr gb "git branch"
    abbr gbd "git branch -D"
    abbr gc "git checkout"
    abbr gC "git commit"
    abbr gCa "git commit --amend --no-edit"
    abbr gCm "git commit -m"
    abbr gf "git fetch --all --prune"
    abbr gg "git log --all --oneline --graph -n20"
    abbr gp "git pull"
    abbr gP "git push origin HEAD"
    abbr gPf "git push origin HEAD --force-with-lease"
    abbr gr "git rebase"
    abbr gra "git rebase --abort"
    abbr grc "git rebase --continue"
    abbr gR "git reset --soft"
    abbr gs "git status"
    abbr gS "git switch"

    set fish_greeting
end
