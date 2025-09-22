# Config
set -g fish_greeting

if status is-interactive
    if command -q mise
        mise activate fish | source
    end

    if command -q atuin
        atuin init fish | source
    end

    if command -q zoxide
        zoxide init fish | source
    end

    if command -q starship
        starship init fish | source
    end
end

# Disable legacy cryptographic algorithms in Python cryptography library for security
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE /usr/bin/micromamba
set -gx MAMBA_ROOT_PREFIX "/home/mbx/.local/share/mamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<