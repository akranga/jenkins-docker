import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;
import java.nio.file.*;

def createSshCreds(user, pemFile) {
  println "Creating ssh creds for user: $user and private key: $pemFile"
  new BasicSSHUserPrivateKey(
    CredentialsScope.GLOBAL,
    "$user-private-key",
    user,
    new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource(pemFile),
    "",
    "SSH creds that Jenkins will use to access SCM"
  )
}

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

def dir = new File( System.getenv("JENKINS_SECRETS_HOME") )
dir.eachFileMatch(~/.*.pem/) {  
  def user = it.name.substring(0,it.name.lastIndexOf("."))
  def pemFile = it.path   
  def privateKey = createSshCreds(user, pemFile)
  store.addCredentials(domain, privateKey)
}

pk = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  "jenkins-slave-key",
  "root",
  new BasicSSHUserPrivateKey.UsersPrivateKeySource(),
  "",
  ""
)

userPass = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  "jenkins-slave-password", "Jenkis Slave with Password Configuration",
  "root",
  "jenkins"
)

store.addCredentials(domain, pk)
store.addCredentials(domain, userPass)
