FROM jenkins/jenkins:lts-jdk21

USER root
# Copy plugins list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Create ref paths, install plugins, hand ownership back to 'jenkins' user
RUN mkdir -p /usr/share/jenkins/ref/plugins \
  && jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt --verbose \
  && chown -R jenkins:jenkins /usr/share/jenkins/ref

# Preload JCasC into reference dir so it gets copied to JENKINS_HOME on first boot
COPY casc/ /usr/share/jenkins/ref/casc/
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/casc

# Run the rest as the jenkins user
USER jenkins

# JCasC: point to the directory in JENKINS_HOME that will be copied on first run
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc

# Set admin usernamd and password
ENV JENKINS_OPTS="--argumentsRealm.passwd.admin=admin --argumentsRealm.roles.admin=admin"
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
