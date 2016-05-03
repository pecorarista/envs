#/bin/bash
while [[ $# > 1 ]]
do
    key="$1"
    case $key in
        -p)
        prefix="$2"
        shift
        ;;
        -v)
        version="$2"
        shift
        ;;
        *)
        ;;
    esac
    shift
done
if [ -z "$prefix" ] || [ -z "$version" ]
then
    echo "$prefix"
    echo "Usage: anaconda.sh -p <installation-root> -v <2 or 3>"
    exit 1
fi
working_dir="$(pwd)"
cd scala; \
    sbt -Dconfig.file=$working_dir/anaconda.conf "run --prefix=$prefix --version=$version"; \
    cd ..
anaconda_home="$prefix/anaconda$version"
source "$anaconda_home/bin/activate" root
python -c "import nltk; nltk.download('all')"
