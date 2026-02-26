$DIRHOME=/home/youruser

export PATH=$PATH:$DIRHOME/.local/bin
export PATH=$PATH:$DIRHOME/apps/nvim-linux64/bin
#export PATH=$PATH:$DIRHOME/apps/mobile-hacking/platform-tools
export JAVA_HOME=$DIRHOME/apps/dev-dependencies/OpenJDK21U-jdk_x64_linux_hotspot_21.0.6_7/jdk-21.0.6-7
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=$DIRHOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Define the alias for GitListTree
alias gtl='git ls-tree HEAD --name-only'

# Define a function for GitListTreeRecursive and create an alias
alias gtlr='git ls-tree HEAD --name-only -r'

# Define a function for GitListRemotes and create an alias
alias gtr='git fetch --all && git log --remotes --graph'

# Define a function for GitListRemotesReverse and create an alias
alias gtrr='git fetch --all && git log --remotes --reverse'

# Define a function for GitListRemotesOneline and create an alias
alias gtro='git fetch --all && git log --remotes --graph --oneline'

# List files not added to workdir. Including in subdirectories
alias gtu='git ls-files --others --exclude-standard --directory'

# custom ls with icons
alias lls='$DIRHOME/apps/custom-tools/coreutils/bin/ls'

# reload keys
alias lkeys='source ~/custom/custom-startup.sh'

#venv activation alias for python
alias hmvenv="source .venv/bin/activate"


eval "$(oh-my-posh init bash --config $DIRHOME/.cache/oh-my-posh/themes/atomicBit.omp.json)"
