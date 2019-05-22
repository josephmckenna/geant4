FROM rootproject/root-cc7
WORKDIR /

#Install dependencies
RUN yum install -y cmake g++ gcc libexpat1-dev \
libxerces-c-dev libx11-dev libxmu-dev libgl1-mesa-dev

#Build geant4
RUN mkdir -i geant4
WORKDIR geant4
RUN git clone --depth 1 https://github.com/Geant4/geant4.git .

RUN mkdir build && mkdir install
WORKDIR build
RUN cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_INSTALL_PREFIX=../install -DCMAKE_BUILD_TYPE=RelWithDebInfo -DGEANT4_INSTALL_DATA=ON -DCLHEP_ROOT_DIR=$CLHEP_BASE_DIR -DCMAKE_COMPILER_IS_GNUCXX=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_RAYTRACER_X11=ON -DGEANT4_USE_GDML=ON ../ 2>&1 | tee cmake.log
RUN make
RUN make install

WORKDIR /
CMD /bin/bash
