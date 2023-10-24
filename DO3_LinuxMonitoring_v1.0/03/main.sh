#!/bin/bash

source ./utils.sh

# Все ли 4 параметра заданы? Если нет, то выводим пояснения и завершаем работу скрипта
if [ $# -ne 4 ]; then
      echo "Usage: $0 <bg_color_1_column> <font_color_1_column> <bg_color_2_column> <font_color_2_column>"
      echo "       bg_color_1_column          - background color of labels (HOSTNAME, TIMEZONE, USER, etc.)"
      echo "       font_color_1_column        - foreground color of labels (HOSTNAME, TIMEZONE, USER, etc.)"
      echo "       bg_color_2_column          - background color of values"
      echo "       font_color_2_column        - foreground color of values"
      echo "  "
      echo "       Available colors:"
      echo "       1 - white"
      echo "       2 - red"
      echo "       3 - green"
      echo "       4 - blue"
      echo "       5 - purple"
      echo "       6 - black"
      exit 1
fi

# Все ли параметры являются числовыми и находятся в пределах диапазона [1..6]?
# Если нет, то выводим пояснения и завершаем работу скрипта
for i in {1..4}; do
    if ! [[ ${i} =~ ^[1-6]$ ]]; then
        echo "Error: Parameter color must be a number between 1 and 6!"
        echo "       Available colors:"
        echo "       1 - white"
        echo "       2 - red"
        echo "       3 - green"
        echo "       4 - blue"
        echo "       5 - purple"
        echo "       6 - black"
        exit 1
    fi
done

# Отличаются ли цвет шрифта и цвет фона для одного столбца?
if [ "$1" -eq "$2" ] || [ "$3" -eq "$4" ]; then
    echo "Error: Font and background colors of one column must not match. Please try again."
    read -p "Would you like to run this script again with new different parameters? (Y/N) " choice
    if [[ ${choice} =~ ^[Yy]$ ]]; then
        echo "Try: $0 <bg_color_1_column> <font_color_1_column> <bg_color_2_column> <font_color_2_column>"
        exit 1
    else
        exit 1
    fi
fi

# Цветовая палитра
bg_color_1_column=('47' '41' '42' '44' '45' '40')
font_color_1_column=('97' '91' '92' '94' '95' '90')
bg_color_2_column=('47' '41' '42' '44' '45' '40')
font_color_2_column=('97' '91' '92' '94' '95' '90')


# Устанавливаем цветовые коды на основе параметров
bg_val_names=${bg_color_1_column[$1 - 1]}
font_val_names=${font_color_1_column[$2 - 1]}
bg_vals=${bg_color_2_column[$3 - 1]}
font_vals=${font_color_2_column[$4 - 1]}

# Вывод значений на экран с цветами
printf "\e[${bg_val_names};${font_val_names}mHOSTNAME = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$HOSTNAME"
printf "\e[${bg_val_names};${font_val_names}mTIMEZONE = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$TIMEZONE"
printf "\e[${bg_val_names};${font_val_names}mUSER = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$USER"
printf "\e[${bg_val_names};${font_val_names}mOS = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$OS"
printf "\e[${bg_val_names};${font_val_names}mDATE = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$DATE"
printf "\e[${bg_val_names};${font_val_names}mUPTIME = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$UPTIME"
printf "\e[${bg_val_names};${font_val_names}mUPTIME_SEC = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$UPTIME_SEC"
printf "\e[${bg_val_names};${font_val_names}mIP = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$IP"
printf "\e[${bg_val_names};${font_val_names}mMASK = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$MASK"
printf "\e[${bg_val_names};${font_val_names}mGATEWAY = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$GATEWAY"
printf "\e[${bg_val_names};${font_val_names}mRAM_TOTAL = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$RAM_TOTAL"
printf "\e[${bg_val_names};${font_val_names}mRAM_USED = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$RAM_USED"
printf "\e[${bg_val_names};${font_val_names}mRAM_FREE= \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$RAM_FREE"
printf "\e[${bg_val_names};${font_val_names}mSPACE_ROOT = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$SPACE_ROOT"
printf "\e[${bg_val_names};${font_val_names}mSPACE_ROOT_USED = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$SPACE_ROOT_USED"
printf "\e[${bg_val_names};${font_val_names}mSPACE_ROOT_FREE = \e[0m\e[${bg_vals};${font_vals}m%s\e[0m\n" "$SPACE_ROOT_FREE"

exit 0