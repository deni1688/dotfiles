function new_repo {
    PROJECT_NAME=$1
    PROJECT_PATH=$HOME/IdeaProjects/$PROJECT_NAME

    mkdir -p $PROJECT_PATH
    cd $PROJECT_PATH

    curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user/repos -d "{\"name\":\"$PROJECT_NAME\",\"private\":true}" > /dev/null 2>&1

    git init
    git remote add origin "git@github.com:$GITHUB_USER/$PROJECT_NAME.git"

    echo "# $PROJECT_NAME" > README.md

    git add .
    git commit -m "Initial commit"
    git push -u origin master
}
