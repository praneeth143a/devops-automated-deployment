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
