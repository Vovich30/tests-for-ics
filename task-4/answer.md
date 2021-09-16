<h2>Написать Ansible-playbook стараясь следовать Best Practices, который приводит обе виртуальные машины в требуемое состояние:</h2>
<ul>
  <li>установлен Docker</li>
  <li>создан пользователь tester, добавленный в группу docker и sudo</li>
  <li>создана docker-подсеть test</li>
  <li>запущен docker-контейнер с Nginx с открытым портом 80, контейнер должен быть включен в подсеть test</li>
  <li>Nginx должен выступать в качестве прокси на 80 порту, требуется перенаправлять запросы к example.com на адрес 10.20.40.4</li>
</ul>

```yaml
name: install docker
hosts:test-servers

tasks:
  - name: install yum utils
    yum:
      name: yum-utils
      state: latest
      
  - name: install device-mapper-persistent-data
    yum:
      name: device-mapper-persistent-data
      state: latest
      
  - name: install lvm2
    yum:
      name: lvm2
      state: latest
      
  - name: add docker repo
    get_url:
      url
```
