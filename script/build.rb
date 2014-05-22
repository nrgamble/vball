`cd ..`
`git archive master --format=tar | gzip > vball.tar.gz`
`scp -i /Users/ngamble/.ssh/gamblejr-key.pem vball.tar.gz ec2-user@54.243.227.31:/home/ec2-user`
`scp -i /Users/ngamble/.ssh/gamblejr-key.pem script/deploy.rb ec2-user@54.243.227.31:/home/ec2-user`