%23%21%2Fbin%2Fbash%0AdateFromServer%3D%24%28curl+-v+--insecure+--silent+https%3A%2F%2Fgoogle.com%2F+2%3E%261+%7C+grep+Date+%7C+sed+-e+%27s%2F%3C+Date%3A+%2F%2F%27%29%0Abiji%3D%60date+%2B%22%25Y-%25m-%25d%22+-d+%22%24dateFromServer%22%60%0A%23%23%23%23%23%23%23%23%23%23%23-+COLOR+CODE+-%23%23%23%23%23%23%23%23%23%23%23%23%23%23%0Acolornow%3D%24%28cat+%2Fetc%2Farzvpn%2Ftheme%2Fcolor.conf%29%0ANC%3D%22%5Ce%5B0m%22%0ARED%3D%22%5C033%5B0%3B31m%22+%0ACOLOR1%3D%22%24%28cat+%2Fetc%2Farzvpn%2Ftheme%2F%24colornow+%7C+grep+-w+%22TEXT%22+%7C+cut+-d%3A+-f2%7Csed+%27s%2F+%2F%2Fg%27%29%22%0ACOLBG1%3D%22%24%28cat+%2Fetc%2Farzvpn%2Ftheme%2F%24colornow+%7C+grep+-w+%22BG%22+%7C+cut+-d%3A+-f2%7Csed+%27s%2F+%2F%2Fg%27%29%22++++++++++++++++++++%0A%23%23%23%23%23%23%23%23%23%23%23-+END+COLOR+CODE+-%23%23%23%23%23%23%23%23%23%23%0A%0ABURIQ+%28%29+%7B%0A++++curl+-sS+https%3A%2F%2Fraw.githubusercontent.com%2Farzvpn%2Fpermission%2Fmain%2Fipmini+%3E+%2Froot%2Ftmp%0A++++data%3D%28+%60cat+%2Froot%2Ftmp+%7C+grep+-E+%22%5E%23%23%23+%22+%7C+awk+%27%7Bprint+%242%7D%27%60+%29%0A++++for+user+in+%22%24%7Bdata%5B%40%5D%7D%22%0A++++do%0A++++exp%3D%28+%60grep+-E+%22%5E%23%23%23+%24user%22+%22%2Froot%2Ftmp%22+%7C+awk+%27%7Bprint+%243%7D%27%60+%29%0A++++d1%3D%28%60date+-d+%22%24exp%22+%2B%25s%60%29%0A++++d2%3D%28%60date+-d+%22%24biji%22+%2B%25s%60%29%0A++++exp2%3D%24%28%28+%28d1+-+d2%29+%2F+86400+%29%29%0A++++if+%5B%5B+%22%24exp2%22+-le+%220%22+%5D%5D%3B+then%0A++++echo+%24user+%3E+%2Fetc%2F.%24user.ini%0A++++else%0A++++rm+-f+%2Fetc%2F.%24user.ini+%3E+%2Fdev%2Fnull+2%3E%261%0A++++fi%0A++++done%0A++++rm+-f+%2Froot%2Ftmp%0A%7D%0A%0AMYIP%3D%24%28curl+-sS+ipv4.icanhazip.com%29%0AName%3D%24%28curl+-sS+https%3A%2F%2Fraw.githubusercontent.com%2Farzvpn%2Fpermission%2Fmain%2Fipmini+%7C+grep+%24MYIP+%7C+awk+%27%7Bprint+%242%7D%27%29%0Aecho+%24Name+%3E+%2Fusr%2Flocal%2Fetc%2F.%24Name.ini%0ACekOne%3D%24%28cat+%2Fusr%2Flocal%2Fetc%2F.%24Name.ini%29%0A%0ABloman+%28%29+%7B%0Aif+%5B+-f+%22%2Fetc%2F.%24Name.ini%22+%5D%3B+then%0ACekTwo%3D%24%28cat+%2Fetc%2F.%24Name.ini%29%0A++++if+%5B+%22%24CekOne%22+%3D+%22%24CekTwo%22+%5D%3B+then%0A++++++++res%3D%22Expired%22%0A++++fi%0Aelse%0Ares%3D%22Permission+Accepted...%22%0Afi%0A%7D%0A%0APERMISSION+%28%29+%7B%0A++++MYIP%3D%24%28curl+-sS+ipv4.icanhazip.com%29%0A++++IZIN%3D%24%28curl+-sS+https%3A%2F%2Fraw.githubusercontent.com%2Farzvpn%2Fpermission%2Fmain%2Fipmini+%7C+awk+%27%7Bprint+%244%7D%27+%7C+grep+%24MYIP%29%0A++++if+%5B+%22%24MYIP%22+%3D+%22%24IZIN%22+%5D%3B+then%0A++++Bloman%0A++++else%0A++++res%3D%22Permission+Denied%21%22%0A++++fi%0A++++BURIQ%0A%7D%0Ared%3D%27%5Ce%5B1%3B31m%27%0Agreen%3D%27%5Ce%5B1%3B32m%27%0ANC%3D%27%5Ce%5B0m%27%0Agreen%28%29+%7B+echo+-e+%22%5C%5C033%5B32%3B1m%24%7B*%7D%5C%5C033%5B0m%22%3B+%7D%0Ared%28%29+%7B+echo+-e+%22%5C%5C033%5B31%3B1m%24%7B*%7D%5C%5C033%5B0m%22%3B+%7D%0APERMISSION%0Aif+%5B+-f+%2Fhome%2Fneedupdate+%5D%3B+then%0Ared+%22Your+script+need+to+update+first+%21%22%0Aexit+0%0Aelif+%5B+%22%24res%22+%3D+%22Permission+Accepted...%22+%5D%3B+then%0Aecho+-ne%0Aelse%0Ared+%22Permission+Denied%21%22%0Aexit+0%0Afi%0A