pipeline {
    agent { label 'AGENT-1' }
    environment { 
        PROJECT = 'EXPENSE'
        COMPONENT = 'backend' 
        appVersion = ''
        ACC_ID = '658775564324'
       
    }
    options {
        disableConcurrentBuilds()
        timeout(time: 30, unit: 'MINUTES')
    }
    /* parameters{
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    } */
    stages {
        stage('Read Version') {
            steps {
               script{
                def packageJson = readJSON file: 'package.json' 
                appVersion = packageJson.version
                echo "version is: $appVersion"
               }
            }
        }
        stage('Install Dependencies') {
            steps {
                script{
                    sh """
                    npm install
                    """
                }
            }
        }
        stage('Docker Build') {
            steps {
                script{
                    sh """
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com
                    """
                }
            }
        }
            
    }
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        failure { 
            echo 'I will run when pipeline is failed'
        }
        success { 
            echo 'I will run when pipeline is success'
        }
    }
}