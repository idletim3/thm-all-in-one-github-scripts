import os
import argparse

def main():
    bright_blue = '\033[1;96m'  # Brighter blue in bold
    bright_green = '\033[1;92m'  # Brighter green in bold
    red = '\033[0;31m'
    nocolor = '\033[0m'

    parser = argparse.ArgumentParser(description="Find a phrase in multiple files.")
    parser.add_argument("-d", "--directory", type=str, required=True, help="Directory to search in.")
    parser.add_argument("-f", "--file", type=str, required=True, help="File to search in.")
    parser.add_argument("-p", "--phrase", type=str, required=True, help="Phrase to search for.")

    args = parser.parse_args()

    current_color = bright_blue
    first_result = True

    for root, dirs, files in os.walk(args.directory):
        if args.file in files:
            file_path = os.path.join(root, args.file)
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
                lines = file.readlines()

            found = False
            for i, line in enumerate(lines):
                if args.phrase in line:
                    if not found:
                        if not first_result:
                            print()
                        print(f"\033[1;{current_color}{file_path}\033[0m")
                        found = True
                        first_result = False
                    line = line.replace(args.phrase, f"{red}{args.phrase}{nocolor}")
                    print(line.strip())

            if found:
                if current_color == bright_blue:
                    current_color = bright_green
                else:
                    current_color = bright_blue

if __name__ == '__main__':
    main()
