
#!/bin/bash

# Xac dinh thu muc bai tap
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

DATA_DIR="$BASE_DIR/data"
BACKUP_DIR="$BASE_DIR/backup"
LOG_FILE="$BASE_DIR/logs/backup.log"

# Tao thu muc backup va logs neu chua co
mkdir -p "$BACKUP_DIR" "$(dirname "$LOG_FILE")"

# Lay thoi gian hien tai
TIME_NOW=$(date '+%Y-%m-%d %H:%M:%S')
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

# Ten file sao luu
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"
BACKUP_FILE="$BACKUP_DIR/$BACKUP_NAME"

# Kiem tra thu muc data
if [ -d "$DATA_DIR" ]; then

    # Nen thu muc data bang tar
    if tar -czf "$BACKUP_FILE" -C "$BASE_DIR" data; then
        STATUS="THANH CONG"
        echo "Sao luu thanh cong!"
        echo "File sao luu: $BACKUP_NAME"
    else
        STATUS="THAT BAI"
        echo "Sao luu that bai!"
        rm -f "$BACKUP_FILE"
    fi

else
    STATUS="THAT BAI"
    BACKUP_NAME="Khong co thu muc data"
    echo "Khong tim thay thu muc data!"
fi

# Ghi nhat ky sao luu
echo "$TIME_NOW | $BACKUP_NAME | $STATUS" >> "$LOG_FILE"

# Hien thi danh sach file da sao luu
echo
echo "===== DANH SACH FILE SAO LUU ====="
ls -lh "$BACKUP_DIR"
