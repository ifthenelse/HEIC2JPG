# HEIC2JPG
ZSH script that converts [HEIC](https://www.iso.org/standard/83650.html) files in [JPG](https://jpeg.org/jpeg/) and removes all metadata via [convert](https://imagemagick.org/script/convert.php).

## Configuration and installation
1. Clone the repo (like in `~/bin/heic2jpg`)
2. Make sure to add the previous folder to `$PATH` in `.zshrc`
3. Create a symlink to `~/bin/heic2jpg/heic2jpg.zsh`

```zsh
ln -s ~/bin/heic2jpg/heic2jpg.zsh heic2jpg h2j
```

## Usage

```zsh
heic2jpg [OPTIONS]
```

## Options

```
-f, --file FILE1 [FILE2 ...]  Convert specific HEIC files.
-d, --dir DIR1 [DIR2 ...]     Convert all HEIC files in specified directories.
-h, --help                    Show help message.
```

## Examples

```zsh
heic2jpg
```

The above command will convert all HEIC files in JPG format in the current folder and subfolders

```zsh
heic2jpg -f image.heic
```

The above command will convert the `image.heic` file to `image.jpg` in the same directory.

```zsh
heic2jpg -f image1.heic image2.heic image3.heic
```

The above command will convert multiple specified HEIC files to JPG format in their respective directories.

```zsh
heic2jpg -d /path/to/directory
```

The above command will convert all HEIC files found in the `/path/to/directory` and its subdirectories to JPG format.

```zsh
heic2jpg -d /dir1 /dir2 /dir3
```

The above command will convert all HEIC files found in the specified directories and their subdirectories to JPG format.
