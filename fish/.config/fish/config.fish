set -g fish_greeting
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1

if status is-interactive
    if command -q mise
        mise activate fish | source
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q starship
        starship init fish | source
    end

    if command -q atuin
        atuin init fish | source
        # Adding below fix when up-arrow no longer working with atuin
        bind up _atuin_bind_up
    end
end

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE /usr/bin/micromamba
set -gx MAMBA_ROOT_PREFIX "/home/mbx/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<

# Aliases
alias cd="z" # zoxide
alias ls="eza -la --color=always --group-directories-first"
set -gx PATH /usr/sbin $PATH

# Normally I use mise for handling zig verisons, 
# but in this case I want specifically a new dev verison
set -x PATH ~/.zig $PATH
