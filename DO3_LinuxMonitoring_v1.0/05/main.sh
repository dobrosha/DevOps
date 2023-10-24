#!/bin/bash

start_time=$(date +%s.%N)

# Проверяем, предоставил ли пользователь аргумент пути
if [ $# -eq 0 ]; then
    echo "Error: Directory path argument required"
    echo "       Usage: $0 <directory>"
    exit 1
fi

dir_path=$1

# Проверяем, закрыл ли пользователь путь "/"
if [ "${dir_path: -1}" != "/" ]; then
    echo "The directory path must end with '/'"
    exit 1
fi

# Проверяем, является ли предоставленный аргумент каталогом
if [ ! -d "$dir_path" ]; then
    echo "Error: '$dir_path' the specified directory does not exist."
    exit 1
fi

# Общее количество папок (включая все вложенные)
total_folders=$(find "$dir_path" -type d | wc -l)

# Топ 5 папок максимального размера, расположенных в порядке убывания (путь и размер)
top_folders=$(du -h "$dir_path"* | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}')

# Общее число файлов
total_files=$(find "$dir_path" -type f | wc -l)

# Количество конфигурационных файлов (с расширением .conf), текстовых файлов, исполняемых файлов, файлов журнала (файлы с расширением .log), архивов, символических ссылок
conf_files=$(find "$dir_path" -type f -name "*.conf" | wc -l)
txt_files=$(find "$dir_path" -type f -name "*.txt" | wc -l)
exe_files=$(find "$dir_path" -type f -executable | wc -l)
log_files=$(find "$dir_path" -type f -name "*.log" | wc -l)
archive_files=$(find "$dir_path" -type f \( -name "*.zip" -o -name "*.7z" -o -name "*.tar" -o -name "*.rar" -o -name "*.gz" \) | wc -l)
symlinks=$(find "$dir_path" -type l | wc -l)

# Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
largest_files="$(find "$dir_path" -type f -exec du -h {} + | sort -hr | sed -n '1,10'p | awk '{printf("%d - %s, %s, ", NR, $2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}')"

# Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш)
largest_executable_files=$(find "$dir_path" -type f -executable -exec du -h {} + | sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')

echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top_folders"
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $txt_files"
echo "Executable files = $exe_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symlinks"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$largest_files"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$largest_executable_files"

# Завершение таймера и расчет времени выполнения скрипта
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc -l)
echo "Script execution time (in seconds) = $elapsed_time"