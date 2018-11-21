# docker-rally
[![Build Status](https://travis-ci.org/itzikb/docker-rally.svg?branch=master)](https://travis-ci.org/itzikb/docker-rally)  
It meant to make it easy to configure and run Rally against an existing cloud.

**Note:** If you already have the image use the following to get the latest build
```
$ sudo docker pull  itzikb/docker-rally
```

Docker should be installed and running.
To install it run(Fedora):
```
$ sudo dnf -y install docker && sudo systemctl start docker && sudo systemctl enable docker
```
or For other RHEL based distros:
```
$ sudo yum -y install docker && sudo systemctl start docker && sudo systemctl enable docker
```

Before running you need to have a directory with overcloudrc file and set the SELinux file context. 

For example:
```
$ mkdir /home/stack/authdir
$ cp /home/stack/overcloudrc /home/stack/authdir
$ sudo chcon -Rt svirt_sandbox_file_t /home/stack/authdir
$ setfacl -m u:5006:r /home/stack/authdir/overcloudrc
```

By default to run the Rally scenarios you need to have:
1. An external network called public
2. A flavor called m1.tiny
3. A cirros image with a name that machres the regex cirros.*-disk

You can create the the image and the flavor using the following commands:
```
$ wget -4 http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
$ openstack image create --disk-format qcow2 --file cirros-0.3.5-x86_64-disk.img --public cirros-disk
$ openstack flavor create --ram 128 --vcpus 1 --public m1.tiny
```

To use it run the following (Here overcloudrc file is under /home/stack/authdir):
```
$ sudo docker run -it --name myrally --network host -v /home/stack/authdir:/env itzikb/docker-rally  /bin/bash
```
**Note: Don't use the /home/stack directory as it may result in an unexpected behavior**

Inside the container run
```
$ sudo ~/scripts/run_rally.sh
$ source /home/centos/rally/bin/activate
```
**itzikb/docker-rally** is the docker image to use (don't change)  


You can access the container by running
```
$ sudo docker exec -it <container-name> /bin/bash
```
You can see all the containers by running
```
$ sudo docker ps -a 
```

## Troubleshooting
After Redployment tests are complaining about connections timeout
Make sure you either run a new container or copy over the overcloudrc to the directory you use (e.g. authdir) and run the ~/scripts/run_rally.sh script
