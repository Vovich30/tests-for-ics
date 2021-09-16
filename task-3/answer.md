<h2>Скрипт, который проверяет примонтирован ли сетевой диск 10.20.30.4 в  /mnt/samba, если примонтирован то выводится сообщение об ошибке и работа скрипта прекращается, если не примонтирован то диск монтируется в директорию /mnt/samba.
</h2>


```bash
#!/bin/sh
if grep 'mnt/samba' /proc/mounts; then 
  echo "disk is already mounted!"
else
  mount 10.20.30.4:mnt/some-disk mnt/samba
fi
```

<h2>Есть две папки /var/log/nginx и /mnt/samba/backup, требуется один раз в день в 10:00 перемещать содержимое папки /var/log/nginx в папку /mnt/samba/backup, так-же при выполнении требуется удалять из папки /mnt/samba/backup все файлы старше 7 дней.
</h2>

<p>Скрипт</p>

```bash
#!/bin/sh
mv -r /var/log/nginx /mnt/samba/backup
find /mnt/samba/backup -mtime +7 -delete
```

<p>Добавление скрипта в крон для запуска по расписанию</p>

```bash
cronetab -e
00 10 * * * /home/somescript.sh
```
