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
hosts: test-servers

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
      url: https://download.docker.com/linux/centos/docker-ce.repo
      dest: /etc/yum.repos.d/docker-ce.repo
    become: yes
    
  - name: enable docker ce edge repo
    ini_file:
      dest: /etc/yum.repos.d/docer-ce.repo
      section: 'docker-ce-edge'
      option: enabled
      value: 0
    become: yes
    
  - name: enable docker test repo
    ini_file: 
      dest: /etc/yum.repos.d/docer-ce.repo
      section: 'docker-ce-test'
      option: enabled
      value: 0
    become: yes
    
  - name: install docker
    package: 
      name:docker-ce
      state: latest
    become: yes
    
  - name: start docker service
    service: 
      name: docker
      state: started
      enabled: yes
    become: yes
```

```yaml
  - name: add user tester  
    user:
      name: tester
      password: there should be sha512 thing for secret password
      createhome: yes
    become: yes      
    
  - name: add user tester to docker group
    user:
      name: tester
      groups: docker
      append: yes
    become: yes
    
  - name: add user tester to sudoers
    user:
      name: tester
      groups: sudo
      append: yes
    become: yes
```

```yaml
  - name: create subnet
    docker_network:
      name: test
```

```yaml
  - name: install python
    pip:
      name: docker
```

```yaml
  - name: deploy nginx container
    docker_container: 
      image: nginx:stable
      name: nginx
      state: started
      ports: 8080:80
      volumes: 
        - /etc/docker/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
  
  - name: add container to subnet
    docker_network:
      name: test
      connected: 
        - nginx
      appends: yes
```
