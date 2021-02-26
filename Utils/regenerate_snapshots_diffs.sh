#/bin/bash -l
set -e
set -o pipefail

TARGET_DIR=$1

if [ ! -d "$TARGET_DIR" ]; then
	echo "Target dir not found: \"$TARGET_DIR\""
  	exit 1
fi

# for FILE in `git ls-files -z -o --exclude-standard`; do
for DIFF_FILE in `git ls-files --others --exclude-standard --modified | grep -e "diff_.*png"`; do
	echo $DIFF_FILE

	FILE_DIR=$(dirname "$DIFF_FILE")
	DIFF_FILE_NAME=$(basename -- "$DIFF_FILE")
	BASE_FILE_NAME="${DIFF_FILE_NAME//diff_/}"

	rm $DIFF_FILE

	set +e
	compare $FILE_DIR"/reference_"$BASE_FILE_NAME $FILE_DIR"/failed_"$BASE_FILE_NAME $DIFF_FILE
	set -e
done