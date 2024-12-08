# git-highlight.zsh
# 
# A Zsh plugin that highlights and color-codes git commands in real-time
# indicating valid, partially matched, or invalid git subcommands.
#
# Created by: Patricio Salazar - (https://patriciosalazar.dev)
# Repository: https://github.com/patriciosebastian/git-highlight
#
# Licensed under the MIT License


# Place valid git commands here
typeset -a validGitCommands=(git init commit push pull status checkout merge branch fetch rebase diff add log stash pop restore reset -m publish rm)

function _git_highlight() {
  # Clear any previous highlights
  region_highlight=()

  # Access the entire current buffer
  local buffer=$BUFFER

  # Split the buffer into words
  # The array "words" will contain each space-separated token
  local words=(${=buffer})

  # Track when subcommand is expected
  local expect_subcommand=false

  # Track position in the buffer string as we iterate through words
  local -i currentPos=0
  
  # Iterate over each word
  for word in "${words[@]}"; do
    local wordLength=${#word}
    local start=$currentPos
    local end=$((start + wordLength))

    # Check needing to adjust for a trailing space after the word
    local nextChar=""
    if (( end < ${#buffer} )); then
      nextChar=${buffer:$end:1}
    fi

    case "$word" in
      '&&'|'||'|';'|'&')
        # Shell operators are not highlighted
        # Reset the subcommand expectation if needed
        expect_subcommand=false
        ;;

      git)
        # Every time 'git' is present, highlight it green and set expect_subcommand to true
        region_highlight+=("$start $end fg=green")
        expect_subcommand=true
        ;;

      *)
        if $expect_subcommand; then
          # Expecting a subcommand for the just-seen 'git'
          local is_valid=false
          local is_partial_match=false

          # Check for full validity
          for cmd in "${validGitCommands[@]}"; do
            if [[ "$word" == "$cmd" ]]; then
              is_valid=true
              break
            fi
          done

          # If not fully valid, check for partial match
          if ! $is_valid; then
            for cmd in "${validGitCommands[@]}"; do
              if [[ "$cmd" == "$word"* ]]; then
                is_partial_match=true
                break
              fi
            done
          fi

          # Highlight accordingly
          # region_highlight expects: "start end style"
          if $is_valid; then
            region_highlight+=("$start $end fg=green")
          elif $is_partial_match; then
            region_highlight+=("$start $end fg=yellow")
          else
            region_highlight+=("$start $end fg=white,bg=red")
          fi

          # After highlighting the subcommand, stop expecting another subcommand
          expect_subcommand=false
        else
          # This word is not after a 'git' command,
          # so just skip highlight it (leave arguments, quotes, etc. as normal).
        fi
        ;;
    esac

    # Move currentPos ahead by the length of the word
    currentPos=$end

    # If there's a space after this word in the buffer, skip it
    if [[ "$nextChar" == " " ]]; then
      ((currentPos++))
    fi
  done
}

# Tell Zsh to run _git_highlight before redrawing the line
zle -N zle-line-pre-redraw _git_highlight
