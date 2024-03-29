# Clean up Notion backup files

## What it does:
`cleanup-notion.sh` does the following:
- Removes UUID (Universally Unique Identifier), i.e., space + 32-digit alphanumeric characters, from filenames and directory names and their references in `*.md` and `*.csv` contents.
- make `failed.txt` which contains the list of files and directories that failed to be renamed.
- (Need to uncomment `replace_space`) Replace `%20` with `_` in filenames and directory names and their references in `*.md` and `*.csv` contents.

	```bash
	main() {
		remove_UUID
		# replace_space
		notice
	}
	```


## Note:
- Since the script is supposed to be run on MacOS, you may need to modify something if you gonna run it on a different OS.


## Caution:
- Please make a copy of your Exported directory before executing this script just in case!
- You might have files or directories with the same name except UUID in the same directory, in that case, their links in `.md` files won't work after executing the script. I recommend that you rename those files before exporting from notion.


## Usage
- Make sure you have installed `rename`:
	```bash
	brew install rename
	```

- Put the unzipped notion backup as follows;
	```bash
	cleanup-notion
		|
		|-- cleanup-notion.sh
		|-- Export-...
	```

- Then, run the script:
	```bash
	sh cleanup-notion.sh
	```