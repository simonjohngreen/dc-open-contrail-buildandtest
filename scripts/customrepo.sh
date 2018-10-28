echo Running customrepo.sh
echo adding a custom git repo
su - vagrant -c 'mkdir -p /home/vagrant/contrail'
su - vagrant -c 'mkdir -p /home/vagrant/contrail/.repo/local_manifests'
echo '<manifest>
<remote name="github" fetch=".."/>
<default revision="refs/heads/master" remote="github"/>
<project name="contrail-ceilometer-plugin" remote="github" path="openstack/ceilometer_plugin"/>
</manifest>' > /home/vagrant/contrail/.repo/local_manifests/opencontrail_patch.xml

chown vagrant.vagrant /home/vagrant/contrail/.repo/local_manifests/opencontrail_patch.xml
