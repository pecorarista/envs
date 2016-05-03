#/bin/bash
if [ $# -ne 1 ]
then
    echo "Usage: anaconda.sh installation-root-directory"
    exit 1
fi
working_dir="$(pwd)"
cd scala; sbt -Dconfig.file=$working_dir/anaconda.conf "run --prefix=$1"; cd ..
anaconda_home="$1/anaconda3"
source "$anaconda_home/bin/activate" root; python -c "import nltk; nltk.download('all')"
