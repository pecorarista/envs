#!/bin/sh
anaconda3_home=$HOME/Anacondas/anaconda3
if [ ! -x $anaconda3_home/bin/conda ]
then
    if [ ! -d $HOME/Downloads ]
    then
        mkdir $HOME/Downloads
    fi
    if [ ! -d $HOME/Anacondas ]
    then
        mkdir $HOME/Anacondas
    fi

    anaconda3_installer_url="https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh"
    anaconda3_installer_script="$HOME/Downloads/$(basename $anaconda3_installer_url)"
    anaconda3_installer_true_sha256sum="73b51715a12b6382dd4df3dd1905b531bd6792d4aa7273b2377a0436d45f0e78"
    anaconda3_installer_calculated_sha256sum="$(sha256sum $anaconda3_installer_script | cut -d' ' -f 1)"

    if [ ! -f "$anaconda3_installer_script" ] ||
       [ ! "$anaconda3_installer_calculated_sha256sum" = "$anaconda3_installer_true_sha256sum" ]
    then
        echo "$anaconda3_installer_calculated_sha256sum"
        echo "$anaconda3_installer_true_sha256sum"
        wget $anaconda3_installer_url -O $anaconda3_installer_script
        rm -rf $HOME/Anacondas/anaconda3
    else
        echo "$anaconda3_installer_calculated_sha256sum"
        echo "$anaconda3_installer_true_sha256sum"
        echo "a"
    fi
    bash "$HOME/Downloads/$(basename $anaconda3_installer_script)" -b -p $HOME/Anacondas/anaconda3
fi
