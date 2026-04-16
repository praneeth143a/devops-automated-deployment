# Devops-Automated-Deployment

To Implement this project, you need:
Docker, Ansible, Bash, EC2 instance.

# Step-by-Step Process to implement:

1. Create a folder.
   ```
   mkdir devops-project && cd devops-project
   ```
   
2. Create folders and a file in the previous folder.
   ```
   mkdir ansible app scripts
   touch docker-compose.yml
   ```

3. Open 'app' folder and create files and insert data into it.
   ```
   touch app.py && vi app.py
   ```
   
   //insert data in it.

   ```
   from flask import Flask
   app = Flask(__name__)

    @app.route('/')
   def home():
      return "DevOps EC2 Project Running "

   if __name__ == '__main__':
      app.run(host='0.0.0.0', port=5000)
   ```

   //create requirements.

   ```
   touch requirements.txt && vi requirements.txt
   ```

   //insert data in it.

   ```
   flask
   ```

   // create Dockerfile and insert data.

   ```
   vi Dockerfile

   //insert data

   FROM python:3.9-silm
   WORKDIR /app
   COPY . .
   RUN pip install -r requirements.txt
   CMD ["python", "app.py"]
   ```

4. Then open ansible folder and create files and insert data in it.

   ```
   cd ansible
   vi inventory.ini
   ```
   //insert data in it.
   ```
   [web]
   <EC2_Public_Key> ansible_user=ubuntu ansible_ssh_private_key_file=<location of pem>
   ```

   ```
   vi setup.yml
   ```
   //insert data in it.
     ```
      - name: Setup EC2
     hosts: web
     become: true
   
     tasks:
       - name: Install packages
         apt:
           name:
             - docker.io
             - docker-compose
           state: present
           update_cache: yes
   
       - name: Add user to docker group
         user:
           name: ubuntu
           groups: docker
           append: yes
   
       - name: Start Docker
         service:
           name: docker
           state: started
           enabled: true
   ```

   ```
   vi deploy.yml
   ```
   //insert data in it.
   ```
   - name: Deploy App
     hosts: web
     become: true
   
     tasks:
       - name: Create directory
         file:
           path: /home/ubuntu/devops-project
           state: directory
   
       - name: Copy files
         copy:
           src: ../
           dest: /home/ubuntu/devops-project
   
       - name: Run container
         command: docker-compose up -d --build
         args:
           chdir: /home/ubuntu/devops-project
   ```

5. Insert data in docker-compose.yml.
   ```
   vi docker-compose.yml
   ```
   //insert data in it.
   ```
   version: '3'

   services:
     web:
       build: ./app
       ports:
         - "80:5000"
       restart: always
    ```

6. Open scripts folder and create a file deploy.sh insert data in it.
   ```
      cd scripts && vi deploy.sh
   ```
   //insert data in it.
   
   ```
   #!/bin/bash

   echo "Starting Deployment..."
   
   cd ..
   
   ansible-playbook -i ansible/inventory.ini ansible/setup.yml
   ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
   
   echo "Deployment Completed "
   ```

7. Now comeback to main project folder and run this commands.
   ```
   chmod +x /scripts/deploy.sh

   cd scripts
   ./deploy.sh
   ```

8. Open EC2 instance, and run these commands.
   ```
   docker ps
   docker logs <container_id>

   curl http://localhost
   ```
   
   ```
   
