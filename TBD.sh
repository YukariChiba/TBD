#!/bin/bash

function build_package {
	source $1
	docker run -it -v $(realpath $1):/src/pkgmeta -v $(dirname "$(realpath "${BASH_SOURCE[0]}")")/tTBD.sh:/usr/bin/tTBD.sh -v $PWD:/publish $image "bash" "-c" "source /src/pkgmeta && source /usr/bin/tTBD.sh"
}

if [[ $# -eq 0 ]] ; then
    echo 'Please specify a filename or `all` for all .TBD files.'
    exit 0
fi

if [ $1 = "all" ]; then
   for tbdfil in *.TBD; do
	   build_package $tbdfile
   done
else
   build_package $1
fi
