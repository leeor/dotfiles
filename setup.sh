#!/usr/bin/env sh

rcfiles=(
	wget/wgetrc
)

for rcf in $rcfiles; do
	if [ ! -h ~/.$(basename ${rcf}) ]; then
		rm -f ~/.$(basename ${rcf}) && ln -s $(pwd)/${rcf} ~/.$(basename ${rcf})
	fi
done
