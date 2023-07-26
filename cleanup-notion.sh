#!/bin/bash


set -e
set -u



rename_root(){
	for item in $(ls)
	do
		if [[ $item =~ Export-.* ]]; then
			mv Export-*/ Export/
		fi
	done
}


remove_UUID(){
	echo "================================================="
	echo 'remove UUIDs in filenames and dirnames'
	find . -depth -exec rename 's|(.*) [a-z0-9]{32}|\1|' {} + 2>/dev/null

	echo "\n\n================================================="
	echo 'remove UUIDs in filenames in .md contents'
	find . -name "*.md" -exec sed -i "" 's|%20[a-z0-9]\{32\}\/|\/|g' {} +
	find . -name "*.md" -exec sed -i "" 's|%20[a-z0-9]\{32\}\.md|\.md|g' {} +
	find . -name "*.md" -exec sed -i "" 's|%20[a-z0-9]\{32\}\.csv|\.csv|g' {} +
	find . -name "*.csv" -exec sed -i "" 's|%20[a-z0-9]\{32\}\/|\/|g' {} +
	find . -name "*.csv" -exec sed -i "" 's|%20[a-z0-9]\{32\}\.csv|\.csv|g' {} +
	find . -name "*.csv" -exec sed -i "" 's|%20[a-z0-9]\{32\}\.md|\.md|g' {} +
	# find . -name "*_all.csv" -type f -delete
}


replace_space(){
	echo "\n\n================================================="
	echo 'replace space in filenames with _'
	find . -depth -exec rename 's| |_|g' {} + 2>/dev/null
	echo "\n\n================================================="
	echo 'replace %20 in filenames with _ in file contents'
	find . -name "*.md" -exec sed -E -i "" '/\[.*\]\(.*\.md\)/s/%20/_/g' {} +
	find . -name "*.md" -exec sed -E -i "" '/\[.*\]\(.*\.csv\)/s/%20/_/g' {} +
	find . -name "*.csv" -exec sed -E -i "" '/\[.*\]\(.*\.md\)/s/%20/_/g' {} +
	find . -name "*.csv" -exec sed -E -i "" '/\[.*\]\(.*\.csv\)/s/%20/_/g' {} +
}


notice(){
	echo "\n\n================================================="
	echo "Done"
	ls -R | grep "[a-z0-9]\{32\}" > failed.txt
	echo "\n\033[0;44mCheck files failed to be renamed: cat failed.txt"
}


main() {
	echo "\033[0;36m"
	rename_root
	remove_UUID
# 	replace_space
	notice
}


caution(){
	echo "\033[0;33m"
	echo "====================================================================================="
	echo "\nCaution: Please make a copy of your Exported directory before executing this script just in case"
	read -p "Press enter to continue;"
	echo "====================================================================================="
	echo "\nCaution: You might have files or directories with the same name except UUID in the same directory, in that case, their links in .md files won't work after executing the script.\n"
	echo "I recommend that you rename those files before exporting from notion.\n"
}


ready(){
	read -r -p "Are you ready? [y/N] " response
	case "$response" in
	    [yY][eE][sS]|[yY]) $1 ;;
	                    *) echo "\033[0;41m"; echo "Stop" ;;
	esac
}



caution
ready main
