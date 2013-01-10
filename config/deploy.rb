set :application, "benhagenfacts.com"
set :scm, :git
set :repository, "git@github.com:jayed/benhagenfacts.com.git"
set :branch, "release"
set :ssh_options, { :forward_agent => true }

role :bucket, "benhagenfacts.com"
server "benhagenfacts.com", :bucket, :primary => true

before "deploy:s3", "deploy:pull_github"
namespace :deploy do
  task :pull_github do
    run "git checkout #{branch} && git pull origin #{branch}"
  end

  desc "Push index.html to AWS S3 bucket"
  task :s3, :roles => :bucket  do
    run "s3cmd put index.html s3://benhagenfacts.com/"
  end
end
