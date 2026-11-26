

#!/bin/bash
# Chuong trinh quan ly va xu ly du lieu sinh vien
# Xac dinh thu muc bai tap
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_FILE="$SCRIPT_DIR/../data/sinhvien.txt"

# Kiem tra file du lieu
if [ ! -f "$DATA_FILE" ]; then
    echo "Khong tim thay file du lieu sinh vien!"
    exit 1
fi

# Menu chuong trinh
while true
do
    echo
    echo "===== CHUONG TRINH QUAN LY SINH VIEN ====="
    echo "1. Hien thi danh sach sinh vien"
    echo "2. Tim kiem sinh vien theo ma"
    echo "3. Thong ke sinh vien dat va khong dat"
    echo "4. Tinh diem trung binh"
    echo "5. Hien thi sinh vien co diem cao nhat"
    echo "6. Sap xep sinh vien theo diem giam dan"
    echo "0. Thoat chuong trinh"
    echo -n "Nhap lua chon: "
    read choice

    case "$choice" in

        1)
            echo "===== DANH SACH SINH VIEN ====="
            printf "%-10s %-20s %s\n" "Ma SV" "Ho ten" "Diem"
            awk -F',' '{printf "%-10s %-20s %s\n",$1,$2,$3}' "$DATA_FILE"
            ;;

        2)
            echo -n "Nhap ma sinh vien can tim: "
            read masv

            if grep -q "^${masv}," "$DATA_FILE"; then
                echo "Thong tin sinh vien:"
                grep "^${masv}," "$DATA_FILE"
            else
                echo "Khong tim thay sinh vien co ma $masv"
            fi
            ;;

        3)
            awk -F',' '
            {
                if ($3 >= 5)
                    dat++
                else
                    khongdat++
            }
            END {
                print "So sinh vien dat:", dat
                print "So sinh vien khong dat:", khongdat
            }' "$DATA_FILE"
            ;;

        4)
            awk -F',' '
            {
                tong += $3
                dem++
            }
            END {
                if (dem > 0)
                    printf "Diem trung binh: %.2f\n", tong/dem
                else
                    print "Khong co du lieu sinh vien"
            }' "$DATA_FILE"
            ;;

        5)
            echo "===== SINH VIEN CO DIEM CAO NHAT ====="
            sort -t',' -k3,3nr "$DATA_FILE" | head -n 1
            ;;

        6)
            echo "===== DANH SACH SAP XEP DIEM GIAM DAN ====="
            sort -t',' -k3,3nr "$DATA_FILE"
            ;;

        0)
            echo "Thoat chuong trinh!"
            break
            ;;

        *)
            echo "Lua chon khong hop le! Vui long nhap lai."
            ;;
    esac
done
