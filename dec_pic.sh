#!/bin/bash

#скачивание
#wget -r -k -l 5 -nc -np http://classinform.ru/ok-eskd/kod.html
#exit 0

#подготовка
#рабочий каталог
ptch="/home/$USER/tst/zayavki/ok-eskd/classinform.ru/ok-eskd"
ptch="/home/$USER/git/dec_pic"
#имя ASCII файла со строками 
outf="eskd_num.txt"
#имя сжатого gzip файла со строками 
outgz="$outf.gz"
#подкаталог с изображениями
outpicdir="." #если в том-же подкаталоге
outpicdir="img" #всё это только для файлов состоящих из цифр, например 7111.jpg

#cat $ptch/kod-0*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>$outf
#cat $ptch/kod-1*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-2*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-3*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-4*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-5*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-6*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-7*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-8*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#cat $ptch/kod-9*.html|sed -n -e '/<title/p'|iconv -f WINDOWS-1251 -t UTF-8|sed 's/<title>Классификатор\ ЕСКД\ |\ //'|sed 's/\ |\ Общероссийский\ классификатор\ изделий\ и\ конструкторских\ документов<\/title>//'>>$outf
#сжатие ОДНОГО файла BD
#gzip -c $outf > $outgz
#сжатие КАТАЛОГА с изображениями
#tar -cvzf $outpicgz $outpicdir/
#exit 0

#работа
#Имя временного файла совмещённого изображения
pict=t.jpg
#Имя файла HTML #<html><body><img src="t.jpg"><p></body>
htmt=t.htm #<html><body><img src="t.jpg"><p></body>
#исполняемый файл браузера (вывод несколько картинок - собрать ImageMagick и в браузер)
browser=firefox
#можно не использовать файл HTML, а использовать браузер, как просмотровщик изображений
#можно выбрать просмотровщик изображений: В убунте eog; В сусях gwenview
#browser=eog
#browser=gwenview
#слово идентификатор для начального списка (в примере состоящего из первых 2-х цифр)
slv2=Класс
#слово идентификатор для списков кроме начального (в примере начиная с 3-й цифры)
slv3=Код
#число цифр в начальном списке (в примере 2)
N=2
#Количество цифр в списке всего
M=6
#Варианты использования GNU утилит
#montage img/711[0-9].jpg -tile 2x -geometry '300x200+2+2>' t.jpg
#$browser /home/$USER/git/eskd_num/t.htm
#montage img/731[0-9].jpg -tile 2x -geometry '300x200+2+2>' t.jpg;$browser /home/$USER/git/eskd_num/t.htm
#read -n 1 a;echo $a;montage img/7"$a"1[0-9].jpg -tile 2x -geometry '300x200+2+2>' t.jpg;$browser /home/$USER/git/eskd_num/t.htm
#if `ls img/7111[0-9].* > /dev/null 2>&1`;then echo yyyyy;else echo nnnnn;fi

#Вывод начального списка
zcat $outgz|sed -n -e "/^$slv2/p"
echo ""
#ввод N цифр из начального списка (в примере 2 цифры)
read -p "Введите $N цифры $slv2а:" -n $N F
#перебор оставшихся цифр начинается со следующей после N
N=$(($N+1))

#перебор оставшихся цифр
for N in `seq $N $M` ;do
    echo ""
    echo ""
    #выборка и вывод подходящих строк, из строки показать 1 и последнее поля, разделённые "|" "/"
    zcat $outgz|sed -n -e "/^$slv3\ $F"[0-9]\ /p|tr "|" "/"|cut -f 1,"$N" -d "/"
    if `ls img/$F[0-9].* > /dev/null 2>&1`;then
        #ImageMagick собирает подходящие под введённые номера картинки в одну парами в строке (-tile 2x)
        montage $outpicdir/$F[0-9].jpg -tile 2x -geometry '300x200+2+2>' $pict
        $browser $ptch/$htmt
    fi
    echo ""
    read -p "Введите $N-ю цифру $slv3а:" -n 1 kl
    #составление введённых цифр
    F=$F$kl
    #вот такой у меня инкремент
    N=$(($N+1))
done

echo ""
echo ""
#выборка и вывод подходящих строк, показать все поля
zcat $outgz|sed -n -e "/^$slv3\ $F"\ /p
