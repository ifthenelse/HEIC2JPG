#!/bin/zsh

# Function to display usage information
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Convert HEIC images to JPG format and remove all metadata"
    echo ""
    echo "Options:"
    echo "  -f, --file FILE1 [FILE2 ...]   Convert specific HEIC files."
    echo "  -d, --dir DIR1 [DIR2 ...]     Convert all HEIC files in specified directories."
    echo "  -h, --help                     Show this help message."
    echo ""
}

# Check if ImageMagick (magick) is installed
if ! command -v magick &> /dev/null; then
    echo "ImageMagick (magick) is not installed. Please install it.\nhttps://imagemagick.org/script/download.php"
    exit 1
fi

# Function to convert HEIC to JPG
convert_heic_to_jpg() {
    local file="$1"

    if [ -f "$file" ]; then
        # Get the filename with path but without extension
        filename_noext="${file:r}"

        echo "Attempting conversion of $file in $filename_noext.jpg"

        # Convert HEIC to JPG and save in the output directory
        magick convert "$file" -strip "$filename_noext.jpg"
        
        if [ $? -eq 0 ]; then
            echo "Converted: $file to $filename_noext.jpg"
        else
            echo "Error converting: $file to $filename_noext.jpg"
        fi
    fi
}


# Process command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --)
            shift
            break
            ;;
        -f|--file)
            shift
            for file in "$@"; do
                if [[ $file == *.(HEIC|heic) ]]; then
                    convert_heic_to_jpg "$file"
                else
                    echo "Not a HEIC file: $file"
                fi
            done
            exit 0
            ;;
        -d|--dir)
            shift
            for dir in "$@"; do
                if [ -d "$dir" ]; then
                    for file in "$dir"/**/*.(HEIC|heic)(N.); do
                        convert_heic_to_jpg "$file"
                    done
                fi
            done
            exit 0
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Invalid option: $1"
            show_help
            exit 1
            ;;
    esac
done

# If no specific files or directories provided, convert HEIC files in the current directory
for file in ./**/*.(HEIC|heic)(N.); do
    convert_heic_to_jpg "$file"
done

echo "Conversion complete."
