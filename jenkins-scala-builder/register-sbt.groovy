import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

plugin=Jenkins.instance.getExtensionList(org.jvnet.hudson.plugins.SbtPluginBuilder.DescriptorImpl.class)[0];
tool = plugin.installations.find {
  it.name == "sbt"
}

if (tool == null) {
  println "Registering sbt tool"
  i=(plugin.installations as List);
  i.add(new org.jvnet.hudson.plugins.SbtPluginBuilder.SbtInstallation("sbt", "/usr/local/bin/sbt", "", []));
  plugin.installations=i
  plugin.save()
} else {
  println "sbt tool has been already registered"
}
