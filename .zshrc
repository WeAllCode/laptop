autoload -U promptinit
promptinit

prompt pure

# Set up some basic aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Set up some basic environment variables
export PATH=$PATH:/usr/local/bin

# Set up some basic options
setopt AUTO_CD     # Automatically cd into a directory if you just type the directory name
setopt CORRECT_ALL # Automatically correct the spelling of commands
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion

# Set up a simple greeting
echo "Welcome to We All Code, happy coding!"
echo ""
