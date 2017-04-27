pipeline {
  agent none
  stages {
    stage('Compile') {
      steps {
        parallel(
          "OpenBSD 6.1": {
	    node('openbsd-6.1') {
		sh 'git config --global user.name "jenkins@kakwa.fr"'
        	sh 'git config --global user.email "jenkins@kakwa.fr"'
                git 'https://github.com/kakwa/uts-server'
                sh 'git clean -fdx'
                sh 'export CC=/usr/local/bin/egcc;export CXX=/usr/local/bin/ec++; cmake . -DBUNDLE_CIVETWEB=ON'
                sh 'make'
            } 
          },
          "FreeBSD 11": {
	    node('freebsd-11') {
		sh 'git config --global user.email "jenkins@kakwa.fr"'
		sh 'git config --global user.name "jenkins@kakwa.fr"'
                git 'https://github.com/kakwa/uts-server'
                sh 'git clean -fdx'
                sh 'cmake . -DBUNDLE_CIVETWEB=ON'
                sh 'make'
            } 
          },
          "CentOS 7": {
	    node('centos-7') {
		sh 'git config --global user.email "jenkins@kakwa.fr"'
		sh 'git config --global user.name "jenkins@kakwa.fr"'
                git 'https://github.com/kakwa/uts-server'
                sh 'git clean -fdx'
                sh 'cmake . -DBUNDLE_CIVETWEB=ON'
                sh 'make'
            } 
          },
          "Debian 8": {
	    node('debian-8') {
		sh 'git config --global user.email "jenkins@kakwa.fr"'
		sh 'git config --global user.name "jenkins@kakwa.fr"'
                git 'https://github.com/kakwa/uts-server'
                sh 'git clean -fdx'
                sh 'cmake . -DBUNDLE_CIVETWEB=ON'
                sh 'make'
            } 
          }
        )
      }
    }
  }
}