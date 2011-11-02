#!/bin/sh

RSYNC=/usr/bin/rsync

RPATH='/usr/local/conf/rsync-dist'
RCONFIGS=(`ls ${RPATH}/*.rsync`)

source ${RPATH}/global.conf

for R in ${RCONFIGS[@]}
do

	EXCLUDEPATHS=""
	EXCLUDE=""
	source $R


	if [ ! -z "${EXCLUDEPATHS}" ]; then
		for E in echo $EXCLUDEPATHS
		do
			ADDEXCLUDE="--exclude=${E}"
			EXCLUDE="${EXCLUDE} ${ADDEXCLUDE}"
		done
	fi
	

	${RSYNC} -avlH --delete ${EXCLUDE} --progress --log-file=${RSYNCOUT} rsync://${SRCHOST}${SRCPATH} ${DSTPATH}
done
