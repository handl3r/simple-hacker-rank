FROM ruby:2.6.3
WORKDIR /app
#COPY ./ruby/runfile.rb /app/runfile.rb
#COPY ./ruby/result.txt /app/result.txt
RUN apt-get update
RUN apt-get install bc
COPY ./script.sh /app/script.sh
RUN chmod +x script.sh
#ENTRYPOINT ["./script.sh"]
#, "ruby", "/app/runfile.rb", "/app/result.txt"
#docker exec -it ruby_container echo "s"
#Note :
# in dockerStorage run:
# Step1, docker build -t testuby2 -f ruby/Dockerfile .   -> to build image has name : testuby2
# Step2, docker run -d --name ruby_container --rm -it testuby2 bash   -> to run container has name: ruby_container
#form image testuby2
# Step3, docker attach ruby_container  -> to get into ruby_container
# Step4, touch a.rb , rouch b , echo 'puts "x"' >> a.rb
# Step5, docker exec -it ruby_container ./script.sh ruby a.rb b to run script -> get result in file b
# Step6, docker cp ruby_container:/app/b /home/thai/b to get result to file b in host
