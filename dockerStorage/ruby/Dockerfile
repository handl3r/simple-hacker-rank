FROM ruby:2.6.3
WORKDIR /app
RUN apt-get update
RUN apt-get install bc
COPY ./script.sh /usr/bin/script.sh
RUN chmod +x /usr/bin/script.sh

# Note V1:
# This note show how to run run_container service by hand 
# Step1: build image: ruby_image 
# in dockerStorage folder run:
# Comand: docker build -t ruby_image -f ruby/Dockerfile .
# Step2: create ruby_1.rb in submit_code_result folder. This file keep code user submit
# Step3: create file result_1.txt in the same folder. This file will keep result when service done job 
# Step4: run container  form images ruby_image to get a running container ruby_container_1  
# Command: docker run -it --name ruby_container_1 -v /home/thai/www/RailsPR/Project2/submit_code_result:/app project2_ruby_image bash
# Step5: attach to container
# Comand: docker attach ruby_container_1
# Step6: run file ruby_1.rb in container
# Comand: docker exec -it ruby_container_1 ./script.sh ruby ruby_1.rb result_1.txt
