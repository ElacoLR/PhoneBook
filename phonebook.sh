name=$1
number=$2
region=""

if [ $# -ne 2 ]; then
  echo 인수가 2개 전달되지 않아 프로그램을 종료합니다.
  exit 1
fi

if [ "$( grep $name phonebook.txt )" = "" ]; then
  if [ "$( echo $number | grep -E -o '^[0-9]{2,3}[-]{1}[0-9]{3,4}[-]{1}[0-9]{4}$' )" = "" ]; then
    echo "번호가 아니거나 잘못된 형식입니다."
    exit 2
  else
    regionNum=$( echo $number | cut -d '-' -f 1 )
    
    case $regionNum
    in
      "010") region="핸드폰"
      ;;
      "02") region="서울"
      ;;
      "031") region="경기"
      ;;
      "062") region="광주광역시"
      ;;
      "061") region="전라남도"
      ;;
      "051") region="부산광역시"
      ;;
      *) echo "유효하지 않은 지역번호 입니다."; exit 3
    esac

    echo -e "$name $number $region" >> phonebook.txt
    LC_COLLATE=C sort phonebook.txt -o phonebook.txt
  fi
else
  aLine=$( grep $name phonebook.txt )
  
  if [ "$( echo $aLine | grep $number )" = "" ]; then
    if [ "$( echo $number | grep -E -o '^[0-9]{2,3}[-]{1}[0-9]{3,4}[-]{1}[0-9]{4}$' )" = "" ]; then
      echo "번호가 아니거나 잘못된 형식입니다."
      exit 2
    else
      regionNum=$( echo $number | cut -d '-' -f 1 )

      case $regionNum
      in
        "010") region="핸드폰"
        ;;
        "02") region="서울"
        ;;
        "031") region="경기"
        ;;
        "062") region="광주광역시"
        ;;
        "061") region="전라남도"
        ;;
        "051") region="부산광역시"
        ;;
        *) echo "유효하지 않은 지역번호 입니다."; exit 3
      esac

      echo -e "$name $number $region" >> phonebook.txt
      LC_COLLATE=C sort phonebook.txt -o phonebook.txt
    fi
  else
    grep $number phonebook.txt
  fi
fi