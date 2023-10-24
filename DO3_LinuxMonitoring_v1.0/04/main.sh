#!/bin/bash

source ./utils.sh

# Существует ли файл конфигурации?
if [[ ! -f ./config.cfg ]]; then
    echo "Error: Config file does not exist"
    exit 1
fi

# Цветовая схема по умолчанию
default_bg_colors=("6" "5")
default_font_colors=("1" "4")

# Цветовая схема
bg_color_val_names=('47' '41' '42' '44' '45' '40')
font_color_val_names=('37' '31' '32' '34' '35' '30')
bg_color_vals=('47' '41' '42' '44' '45' '40')
font_color_vals=('37' '31' '32' '34' '35' '30')
color_names=("white" "red" "green" "blue" "purple" "black")

# Загружаем значение из конфигурации или используем значения по умолчанию, если они не определены
column1_background=$(grep "^column1_background=" config.cfg | cut -d "=" -f 2)
if [[ -z "$column1_background" ]]; then
    column1_background=${default_bg_colors[0]}
    default_column1_background="default ("${color_names[$column1_background - 1]}")"
fi

column1_font_color=$(grep "^column1_font_color=" config.cfg | cut -d "=" -f 2)
if [[ -z "$column1_font_color" ]]; then
    column1_font_color=${default_font_colors[0]}
    default_column1_font_color="default ("${color_names[$column1_font_color - 1]}")"
fi

column2_background=$(grep "^column2_background=" config.cfg | cut -d "=" -f 2)
if [[ -z "$column2_background" ]]; then
    column2_background=${default_bg_colors[1]}
    default_column2_background="default ("${color_names[$column2_background - 1]}")"
fi
column2_font_color=$(grep "^column2_font_color=" config.cfg | cut -d "=" -f 2)
if [[ -z "$column2_font_color" ]]; then
    column2_font_color=${default_font_colors[1]}
    default_column2_font_color="default ("${color_names[$column2_font_color - 1]}")"
fi

# Отличаются ли цвет шрифта и цвет фона для одного столбца?
if [ "$column1_background" = "$column1_font_color" ] || [ "$column2_background" = "$column2_font_color" ]; then
    echo "Error: Font and background colors of one column must not match. Please try again."
    exit 1
fi

# Все ли параметры являются числовыми и находятся в пределах диапазона [1..6]?
# Если нет, то выводим пояснения и завершаем работу скрипта
if ! [[ $column1_background =~ ^[1-6]$ ]] ||
    ! [[ $column1_font_color =~ ^[1-6]$ ]] ||
    ! [[ $column2_background =~ ^[1-6]$ ]] ||
    ! [[ $column2_font_color =~ ^[1-6]$ ]]; then
    echo "Error: Parameter color must be a number between 1 and 6."
    echo "       Available colors:"
    echo "       1 - white"
    echo "       2 - red"
    echo "       3 - green"
    echo "       4 - blue"
    echo "       5 - purple"
    echo "       6 - black"
    exit 1
fi

# Устанавливаем цветовые коды на основе параметров
bg_val_names=${bg_color_val_names[$column1_background - 1]}
font_val_names=${font_color_val_names[$column1_font_color - 1]}
bg_vals=${bg_color_vals[$column2_background - 1]}
font_vals=${font_color_vals[$column2_font_color - 1]}

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

# Вывод информации о цветовой схеме
if [[ -z "$default_column1_background" ]]; then
    printf "Column 1 background = $column1_background (${color_names[$column1_background - 1]})\n"
else
    printf "Column 1 background = $default_column1_background\n"
fi

if [[ -z "$default_column1_font_color" ]]; then
    printf "Column 1 font color = $column1_font_color (${color_names[$column1_font_color - 1]})\n"
else
    printf "Column 1 font color = $default_column1_font_color\n"
fi

if [[ -z "$default_column2_background" ]]; then
    printf "Column 2 background = $column2_background (${color_names[$column2_background - 1]})\n"
else
    printf "Column 2 background = $default_column2_background\n"
fi

if [[ -z "$default_column2_font_color" ]]; then
    printf "Column 2 font color = $column2_font_color (${color_names[$column2_font_color - 1]})\n"
else
    printf "Column 2 font color = $default_column2_font_color\n"
fi

exit 0