PROG:=launcherisbloat
VERSION?=0.1

CC?=cc

RM?=rm -f
CP?=cp -f

PREFIX?=/usr/local
MANPREFIX?=${PREFIX}/share/man
DESTDIR?=
BINDIR?=${DESTDIR}${PREFIX}/bin

CPPFLAGS+=-DPROG="\"${PROG}\"" -DVERSION="\"${VERSION}\""
CFLAGS+=-std=c99 -Wall ${CPPFLAGS} `pkg-config --cflags gtk+-3.0`
LDFLAGS+=`pkg-config --libs gtk+-3.0`

SRC:=main.c
OBJ:=${SRC:.c=.o}

.PHONY: all clean install uninstall options

all: ${PROG}

options:
	@echo ${PROG} build options:
	@echo "CFLAGS  = ${CFLAGS}"
	@echo "LDFLAGS = ${LDFLAGS}"
	@echo "CC      = ${CC}"

.SUFFIXES: .c .o
.c.o:
	${CC} -c ${CFLAGS} $< -o $@

${PROG}: ${OBJ}
	${CC} ${LDFLAGS} ${OBJ} -o $@

test: all
	./${PROG}

install: all
	install -d ${BINDIR}
	install -m 0755 ${PROG} ${BINDIR}/${PROG}

uninstall:
	${RM} ${BINDIR}/${PROG}

clean:
	${RM} ${PROG} ${PROG}.core ${OBJ}
