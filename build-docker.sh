function build_docker {
    local git_tag=$1

    if [ -z "$git_tag" ]; then
        git_tag=master
    fi

    if [ "$git_tag" == "master" ]; then
        docker build -t yamachu/sptk:latest --build-arg TAG=$git_tag .
    else
        docker build -t yamachu/sptk:$git_tag --build-arg TAG=$git_tag .
    fi
}

build_docker $1
