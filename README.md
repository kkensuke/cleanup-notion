# Clean up Notion backup files

## What it does:
`cleanup-notion.sh` does the following:
- Removes UUID (Universally Unique Identifier), or space+32-digit alphanumeric characters, from filenames and directory names and their references in `*.md` and `*.csv` contents.
- make `failed.txt` which contains the list of files and directories that failed to be renamed.
- Replace `%20` with `_` in filenames and directory names and their references in `*.md` and `*.csv` contents. However, it may break URLs with `%20` and other strings with `%20`. So, check with `find . -name "*.md" -exec grep "%20" {} + ` and `find . -name "*.csv" -exec grep "%20" {} + `. If there is no `%20` except in the file or directory path, uncomment the following part and run the script again.
	```bash
	# 	echo "\n\n================================================="
	# 	echo 'replace space in filenames with _'
	# 	find . -depth -exec rename 's| |_|g' {} + 2>/dev/null
	# 	echo "\n\n================================================="
	# 	echo 'replace %20 in filenames with _ in file contents'
	# 	find . -name "*.md" -exec sed -E -i "" 's|%20|_|g' {} +
	# 	find . -name "*.csv" -exec sed -E -i "" 's|%20|_|g' {} +
	```


## Note:
- Since the script is supposed to run on MacOS, you may need to modify something if you gonna run on a different OS.


## Caution:
- Please make a copy of your Exported directory before executing this just in case!
- You might have files or directories with the same name in the same directory, in that case, their links in .md files won't work after executing the script. I recommend that you rename those files before exporting.


## Usage
- Make sure you have installed `rename`:
	```bash
	brew install rename
	```

- To execute the script, put the unzipped backup as follows;
	```bash
	cleanup-notion
			|
			|-- cleanup-notion.sh
			|-- Export-...
	```

- Then, run the script:
	```bash
	./cleanup-notion.sh
	```