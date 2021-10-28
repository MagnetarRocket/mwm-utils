# Common Makefile part, included by platform specific makefiles

CFLAGS += -NoXSM -DPREFIX='"$(PREFIX)"' -DRCDIR='"$(RCDIR)"' $(INCDIRS)
toolbox_libs =  -lXm -lXt -lX11


toolbox_objs = tbmain.o tbparse.o


app_defaults = XmToolbox.ad

executables =  xmtoolbox 

all: $(executables) $(app_defaults) 

xmtoolbox: $(toolbox_objs)
	$(CC) -o $@ $(LIBDIRS) $(toolbox_objs) $(toolbox_libs)

XmToolbox.ad: XmToolbox.ad.src
	sed s%PREFIX%$(PREFIX)%g XmToolbox.ad.src > $@

.PHONY: clean install common_no_xsm

common_install:
	install -m775 xmtoolbox $(PREFIX)/bin/xmtoolbox
	install -m775 -d $(MANDIR)/man1
	install -m664 xmtoolbox.1 $(MANDIR)/man1/xmtoolbox.1
	install -m775 -d $(APPLRESDIR)

	install -m664 XmToolbox.ad $(APPLRESDIR)/XmToolbox
	install -m664 toolboxrc $(RCDIR)/toolboxrc

clean:
	-rm $(toolbox_objs)  $(executables) $(app_defaults)
	-rm .depend

.depend:
	$(CC) -MM $(INCDIRS) $(toolbox_objs:.o=.c)  > $@
