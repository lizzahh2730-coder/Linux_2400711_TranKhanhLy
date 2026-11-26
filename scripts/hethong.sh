#!/bin/bash

# Xac dinh thu muc chua script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/hethong.log"

# Tao thu muc logs neu chua co
mkdir -p "$(dirname "$LOG_FILE")"

# Hien thi va ghi ket qua vao file log
{
    echo "===== KIEM TRA HE THONG ====="
    echo "Nguoi dung: $(whoami)"
    echo "Ten may tinh: $(hostname)"
    echo "Ngay gio hien tai: $(date)"
    echo "Phien ban Linux Kernel: $(uname -r)"

    echo
    echo "===== DUNG LUONG RAM ====="
    free -h

    echo
    echo "===== DUNG LUONG O DIA ====="
    df -h

    echo
    echo "===== KIEM TRA KET NOI MANG ====="

    if ping -c 1 -W 3 google.com.vn > /dev/null 2>&1
    then
        echo "Co ket noi mang"
    else
        echo "Khong xac nhan duoc ket noi mang"
    fi

    echo "===== KET THUC KIEM TRA ====="
} | tee -a "$LOG_FILE"
