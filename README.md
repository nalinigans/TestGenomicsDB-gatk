## Sanity test gatk with GenomicsDB
genomicsdb-\<VER\>.jar bundles native libtiledbgenomicsdb-\<VER\> shared libaries for Linux and OSX. This native library should not have dynamic dependencies with other shared libraries and is statically linked with all other dependencies like C/C++ runtime libraries, ssl, protobuf, curl, etc. The only dynamic dependency is with backward compatible glibc and zlib. See https://github.com/GenomicsDB/GenomicsDB/wiki/Compiling-GenomicsDB#building-a-distributable-jar.

### With Docker
To build and test gatk with GenomicsDB using Docker, specify the following *optional* build arguments

  | Build Argument | Default |
  | --- | --- |
  | os=ubuntu:trusty\|centos:7\|\<linux_base:ver\> | centos:7 |
  | user=<user_name> | gatk |
  | branch=master\|develop\|<any_gatk_branch> | master |
  
Examples:
```
git clone https://github.com/nalinigans/TestGenomicsDB-gatk.git
cd TestGenomicsDB-gatk
docker build --build-arg os=ubuntu branch=nalini_test -t gatk:ubuntu . 
```

To run and enter the bash shell:
```
 docker run -it gatk:ubuntu
```

To delete docker images:
```
docker image rm -f gatk:ubuntu
docker system prune #optional
```


