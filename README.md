# Devops-Automated-Deployment

To Implement this project, you need:
Linux(command line), Docker, Ansible, Bash, EC2 instance.

# Project Folder Structure
   ```
   devops-project/
   │
   ├── app/
   │   ├── app.py
   │   ├── requirements.txt
   │   └── Dockerfile
   │
   ├── ansible/
   │   ├── inventory.ini
   │   ├── setup.yml
   │   └── deploy.yml
   │
   ├── scripts/
   │   └── deploy.sh
   │
   └── docker-compose.yml
   ```


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
   
   Insert data in it.

   ```
   from flask import Flask
   app = Flask(__name__)

   @app.route('/')
   def home():
      return "DevOps EC2 Project Running "

   if __name__ == '__main__':
      app.run(host='0.0.0.0', port=5000)
   ```

   Create requirements.

   ```
   touch requirements.txt && vi requirements.txt
   ```

   Insert data in it.

   ```
   flask
   ```

   Create Dockerfile and insert data.

   ```
   vi Dockerfile

   //insert data

   FROM python:3.9-slim
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
   Insert data in it.
   ```
   [web]
   <EC2_Public_IP> ansible_user=ubuntu ansible_ssh_private_key_file=<location of pem>
   ```

   ```
   vi setup.yml
   ```
   Insert data in it.
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
   Insert data in it.
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
   Insert data in it.
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
   Insert data in it.
   
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
   chmod +x scripts/deploy.sh

   cd scripts
   ./deploy.sh
   ```

8. Open EC2 instance, and run these commands.
   ```
   docker ps
   docker logs <container_id>

   curl http://localhost
   ```
   
9. Then run it in local browser.
    ```
    http://<EC2_Public_IP>
    ```

# Output
DevOps EC2 Project Running

<img width="1600" height="723" alt="WhatsApp Image 2026-04-14 at 10 06 00 PM" src="https://github.com/user-attachments/assets/2c029f1f-d80a-4914-a095-6ad0656fc44d" />
