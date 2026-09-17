# FIXME: before you push into master...
RUNTIMEDIR=/home/nboldi/OpenModelica/build/include/omc/c/
OMC_MINIMAL_RUNTIME=1
OMC_FMI_RUNTIME=1
include $(RUNTIMEDIR)/Makefile.objs
#COPY_RUNTIMEFILES=$(FMI_ME_OBJS:%= && (OMCFILE=% && cp $(RUNTIMEDIR)/$$OMCFILE.c $$OMCFILE.c))

fmu:
	rm -f OneModel.fmutmp/sources/OneModel_init.xml
	cp -a /home/nboldi/OpenModelica/build/include/omc/c/* OneModel.fmutmp/sources/include/
	cp -a /home/nboldi/OpenModelica/build/share/omc/runtime/c/fmi/buildproject/* OneModel.fmutmp/sources
	cp -a OneModel_FMU.libs OneModel.fmutmp/sources/

