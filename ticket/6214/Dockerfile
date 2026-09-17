FROM ubuntu:18.04 
MAINTAINER Arunkumar Palanisamy "arunkumar.palanisamy@liu.se"
RUN apt-get update

RUN apt-get install -y sudo gnupg lsb-release wget

RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` nightly"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | sudo apt-key add - 

# Update index (again)
RUN apt-get update

# Install minimal OpenModelica Components
RUN apt-get install -y omc omlib-modelica-3.2.2

RUN apt-get install -y git

# instal python3-pip
RUN apt-get install -y python3-pip

RUN pip3 install --upgrade pip

# Install OMPython                        
RUN pip3 install -U git+https://github.com/OpenModelica/OMPython.git

# ADD non-root users 
RUN useradd -m -s /bin/bash openmodelicausers

# add and set up the working directory 
ADD . /compile_mod
WORKDIR /compile_mod

# set user permissions to the directory
RUN chown -R openmodelicausers:openmodelicausers /compile_mod
RUN chmod 755 /compile_mod

RUN pip3 install -r /compile_mod/requirements.txt

USER openmodelicausers
ENV USER openmodelicausers


#CMD /bin/bash
#CMD python3 compile_mod.py
