eval "$(starship init zsh)"

export EDITOR=/usr/bin/nvim

#Cmatrix thing
alias matrix='cmatrix -s -C cyan'

#iso and version used to install ArcoLinux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

#systeminfo
alias probe="sudo -E hw-probe -all -upload"

# Replace ls with exa
alias ls='exa -l --color=always --group-directories-first --icons'  # long format
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l='exa -lah --color=always --group-directories-first --icons' # tree listing

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"

#available free memory
alias free="free -mt"

#continue download
alias wget="aria2c"

#readable output
alias df='df -h'

#Pacman for software managment
alias search='sudo pacman -Qs'
alias remove='sudo pacman -R'
alias install='sudo pacman -S'
alias linstall='sudo pacman -U '
alias update='sudo pacman -Syyu'
alias clrcache='sudo pacman -Scc'
alias updb='paru && sudo pacman -Sy'
alias orphans='sudo pacman -Rns $(pacman -Qtdq)'

#Paru as aur helper - updates everything
alias pget='paru -S '
alias prm='paru -Rs '
alias psr='paru -Ss '
alias upall='paru -Syyu --noconfirm'

#Flatpak Update
alias fpup='flatpak update'

#grub update
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'

#get fastest mirrors in your neighborhood
alias ram='rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist'
alias reft='sudo systemctl enable reflector.service reflector.timer && sudo systemctl start reflector.service reflector.timer'

#quickly kill stuff
alias kc='killall conky'

#Bash aliases
alias mkfile='touch'
alias thor='sudo thunar'
alias jctl='journalctl -p 3 -xb'
alias ssaver='xscreensaver-demo'
alias reload='cd ~ && source ~/.zshrc'
alias pingme='ping -c64 github.com'
alias cls='clear && neofetch'
alias traceme='traceroute github.com'

#hardware info --short
alias hw="hwinfo --short"

#youtube-dl
alias ytv-best='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" --merge-output-format mp4 '

#GiT  command
alias gc='git clone --bare'
alias gcm='git commit -am'

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#Copy/Remove files/dirs
alias rmd='rm -r'
alias srm='sudo rm'
alias srmd='sudo rm -r'
alias cpd='cp -R'
alias scp='sudo cp'
alias scpd='sudo cp -R'

#nvim
alias zshrc='sudo nvim ~/.zshrc'
alias nsddm='sudo nvim /etc/sddm.conf'
alias pconf='sudo nvim /etc/pacman.conf'
alias mkpkg='sudo nvim /etc/makepkg.conf'
alias ngrub='sudo nvim /etc/default/grub'
alias smbconf='sudo nvim /etc/samba/smb.conf'
alias nmirrorlist='sudo nvim /etc/pacman.d/mirrorlist'

#cd/ aliases
alias etc='cd /etc/'
alias music='cd ~/Music'
alias vids='cd ~/Videos'
alias conf='cd ~/.config'
alias desk='cd ~/Desktop'
alias pics='cd ~/Pictures'
alias dldz='cd ~/Downloads'
alias docs='cd ~/Documents'
alias dev='cd ~/Developer/'
alias school='cd ~/Documents/school/'
alias sapps='cd /usr/share/applications'
alias lapps='cd ~/.local/share/applications'
alias .nvim='cd ~/.config/nvim/'

#switch between lightdm and sddm
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"

#Recent Installed Packages
# alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#Package Info
alias info='sudo pacman -Si '
alias infox='sudo pacman -Sii '

##Refresh Keys
alias rkeys='sudo pacman-key --refresh-keys'

#StayRolling
alias dist-upgrade='update && upgrade'

#hblock (stop tracking with hblock)
#use unhblock to stop using hblock
alias unhblock="hblock -S none -D none"

#shutdown or reboot
alias sr="sudo reboot"
alias ssn="sudo shutdown now"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vi=nvim
alias ripme="open /Applications/ripme.jar"
alias t7="cd /Volumes/T7"
alias gal=gallery-dl
alias ze=zellij
alias tx=tmuxinator

alias crash=":(){:|:&};:"

alias 4=thread-archiver

alias format="sudo diskutil eraseDisk FAT32 USB MBRFormat"




#NOTE: these are my functions

flash (){
    diskutil list
    diskutil unmountDisk /dev/"$2"
    sudo dd if=$1 | pv | sudo dd of=/dev/"$2" bs=1M
    sudo diskutil eject /dev/"$2"
}

cx() {cd "$@" && l;}

switch() {
    mv ~/.config/nvim/ ~/.config/switched
    mv ~/.config/nvim.bak/ ~/.config/nvim/
    mv ~/.config/switched ~/.config/nvim.bak/

    mv ~/.local/share/nvim/ ~/.local/share/switched
    mv ~/.local/share/nvim.bak/ ~/.local/share/nvim/
    mv ~/.local/share/switched ~/.local/share/nvim.bak/
}

mkschool(){

dir=~/Documents/school/$1
mkdir $dir
cd $dir
cat << EOF > $1.tex
\documentclass[letterpaper,12pt]{article}

\setlength\parindent{0pt}

\renewcommand{\familydefault}{\sfdefault}

\usepackage[english]{babel}
\usepackage{blindtext}

\begin{document}

\title{\Large{\textbf{$1}}}
\author{Insert name here}
\date{Insert date here}

\maketitle



\end{document}
EOF

nvim $1.tex
}

tm(){
    sessions=$(tmux list-sessions -F "#S")

    # fuzzy find session with fzf
    session=$(echo $sessions | tr ' ' '\n' | gum filter)

    # attach to session
    tmux attach-session -t $session
}

dup() {
    typeset -a lines
    typeset -a counts
    lines=()
    counts=()
    while read line; do
        if [[ -n "$line" ]]; then
            if [[ ! " ${lines[@]} " =~ " ${line} " ]]; then
                lines+=("$line")
                counts+=("1")
            else
                index=0
                for i in $(seq 1 ${#lines[@]}); do
                    if [[ "${lines[$i]}" == "$line" ]]; then
                        index="$i"
                        break
                    fi
                done
                ((counts[$index]++))
            fi
        fi
    done < "$1"

  # Print out any lines that appear more than once, along with their counts
  for index in $(seq 1 ${#lines[@]}); do
      count="${counts[$index]}"
      if (( count > 1 )); then
          echo "${lines[$index]} appears $count times"
      fi
  done
}

4file (){
    # Check if a filename was provided as an argument
    if [[ -z "$1" ]];
    then
        echo "Please provide a filename as an argument"
    else
        while read -r line; do
            thread-archiver "$line"
        done < "$1"
    fi
}
