export A=/vagrant/presentations/02-exploitation/assignments/integer_conversion
export B=/vagrant/presentations/02-exploitation/assignments/integer_conversion_canary
export C=/vagrant/presentations/02-exploitation/assignments/integer_conversion_canary_pie
export TERM=xterm-256color

export EDITOR=vim
function pwn(){
    if [[ "${1}" == "" ]]; then
        fname=exploit.py
    else
        fname="${1}"
    fi
    if test -f "${fname}"; then
        echo "${fname} already exists."
        false
    else
        touch "${fname}"
        chmod +x "${fname}"
        cat > "${fname}"<<EOF
#!/usr/bin/env python2
# -*- coding: utf-8 -*-

from pwn import *

context(arch="i386", os="linux")

SHELLCODE = asm(shellcraft.findpeersh())
EOF
        ${EDITOR} "${fname}" +
    fi
}
function plasma(){
    real=$(realpath "${1}")
    dir=$(dirname "${real}")
    base=$(basename "${real}")
    docker run --rm -it -v "${dir}":/workdir robertlarsen/plasma:latest -i "./${base}"
}
function msfvenom(){
    docker run --rm -it robertlarsen/metasploit:latest msfvenom $*
}
function msfconsole(){
    docker run --rm -it robertlarsen/metasploit:latest msfconsole $*
}

export PS1='$ '
