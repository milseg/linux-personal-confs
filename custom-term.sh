export DIRHOME=/home/youruser

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

export PATH=$PATH:/usr/local/go/bin

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

#listening network ports served
alias chkports="ss -tulp"

#open files and network connections
alias netwconn="lsof -i -P -n"

#delete files with given regex
alias delreg='find . -type f -regextype posix-egrep -regex ".*\.tmp$" -delete'
alias delregtest='find . -type f -regextype posix-egrep -regex ".*\.tmp$" -print'

#system monitor
alias sysmon='htop'

#gpu monitor
alias gpumon='nvtop'

#files and folders size
fsize() {
    if [ -z "$1" ]; then
        echo "Usage: fsize <filename|folder>"
        return 1
    fi
    output=$(du -sh "$1" 2>/dev/null)
    echo "${output%%$'\t'*}"
}

#copy file content to clipboard 
clip() {
    if [ -z "$1" ]; then
        echo "Usage: clip <filename>"
        return 1
    fi
    cat "$1" | xsel --clipboard
}

#output clipboard(initialize file with)
glue() {
    if [ -z "$1" ]; then
        echo "Usage: glue <filename>"
        return 1
    fi
    xsel --clipboard --output "$1"
}

#Search files and folders by name
search() {
    local name="$1"
    local type="${2:-b}"  # Default to 'b' (both)
    local depth="${3:-}"
    local depth_flag=""
    local type_flag=""

    if [ -n "$type" ] && [[ "$type" =~ ^[0-9]+$ ]]; then
        depth="$type"
    fi

    case "$type" in
        f) type_flag="-type f" ;;
        d) type_flag="-type d" ;;
        b) type_flag="" ;;
        *) type_flag="" ;;
    esac

     # If depth is provided and is a number, use it as depth
    if [ -n "$depth" ] && [[ "$depth" =~ ^[0-9]+$ ]]; then
        depth_flag="-maxdepth $depth"
    else
	echo "Usage: search <name> [depth|type] [depth]"
        echo "  Depth is a number"
        return 1
    fi

    if [ -z "$name" ]; then
        echo "Usage: search <name> [depth|type] [depth]"
        echo "  type:  'f' for files, 'd' for directories, 'b' for both (default)"
        echo "  depth: optional max depth (e.g., 1, 2). If none given, then recurses"
        return 1
    fi

    find . $depth_flag $type_flag -iname "$name" -printf "%p [%y]\n"
}

#Search files and folders by regex
searx() {
    local regex="$1"
    local type="${2:-b}"  # Default to 'b' (both)
    local depth="${3:-}"
    local depth_flag=""
    local type_flag=""

    if [ -n "$type" ] && [[ "$type" =~ ^[0-9]+$ ]]; then
        depth="$type"
    fi

    case "$type" in
        f) type_flag="-type f" ;;
        d) type_flag="-type d" ;;
        b) type_flag="" ;;
        *) type_flag="" ;;
    esac

     # If depth is provided and is a number, use it as depth
    if [ -n "$depth" ] && [[ "$depth" =~ ^[0-9]+$ ]]; then
        depth_flag="-maxdepth $depth"
    else
	echo "Usage: searx <regex> [depth|type] [depth]"
        echo "  Depth is a number"
        return 1
    fi

    if [ -z "$regex" ]; then
        echo "Usage: searx <regex> [depth|type] [depth]"
        echo "  type:  'f' for files, 'd' for directories, 'b' for both (default)"
        echo "  depth: optional max depth (e.g., 1, 2). If none given, then recurses"
        return 1
    fi

    find . $depth_flag $type_flag -regextype posix-extended -iregex ".*$regex" -printf "%p [%y]\n"
}

pdfmg() {
  output="${1:-final.pdf}"
  find . -maxdepth 1 -type f -name "*.pdf" ! -name "$output" -print0 \
    | sort -z \
    | xargs -0 sh -c 'pdfunite "$@" "$0"' "$output"
}

# Count how many .<ext> files exist in <dir>
cext() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: cext <dir> <ext>"
        return 1
    fi
    if [ ! -d "$1" ]; then
        echo "Error: '$1' is not a directory"
        return 1
    fi
    ext="${2#.}"
    find "$1" -type f -name "*.$ext" | wc -l
}

#Outputs lines b to e from a file
lines() {
    local name="$1"
    local b="${2:-}"  # Default to 'b' (both)
    local e="${3:-}"
    
    if [ -z "$regex" ]; then
        echo "Usage: lines <filename> [begin] [end]"
        echo "  begin:  first line on the print range"
        echo "  end: last line on the print range"
        return 1
    fi

    if [ -n "$b" ] && [ -n "$e" ] && [[ "$b" =~ ^[0-9]+$ ]] && [[ "$e" =~ ^[0-9]+$ ]]; then
        awk 'NR>=$b && NR<=$e' "$name"
        return $?
    fi
    
    if [ -n "$b" ] && [[ "$b" =~ ^[0-9]+$ ]]; then
        awk 'NR>=$b' "$name"
        return $?
    fi
    
    if [ -n "$e" ] && [[ "$e" =~ ^[0-9]+$ ]]; then
        awk 'NR<=$e' "$name"
        return $?
    fi
    
    cat "$name"
}

#concurrently runs a command
conc() {
    local n="${1:-5}"
    local cmd="${2:-}"
    seq $n | xargs -P $n -I{} sh -c "$cmd; echo"
}

eval "$(oh-my-posh init bash --config $DIRHOME/.cache/oh-my-posh/themes/atomicBit.omp.json)"
