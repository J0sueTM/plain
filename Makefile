# file: Makefile
# author: Josue Teodoro Moreira <teodoro.josue@protonmail.ch>
# date: 27 August, 2022
#
# Copyright (C) 2022, Josue Teodoro Moreira
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.	 If not, see <https://www.gnu.org/licenses/>.

CC=gcc
CC_FLAGS=-c -Wall -Werror

CCL_ST=ar
CCL_ST_FLAGS=rcs
CCL_SH=gcc
CCL_SH_FLAGS=-shared

DIR_BIN=bin
DIR_LIB=lib
DIR_OBJ=obj
DIR_SRC=src

NAME=plain
LIB=${DIR_LIB}/lib${NAME}
SRC=$(shell find ${DIR_SRC} -type f -name "*.c")
OBJ=$(patsubst ${DIR_SRC}/%.c, ${DIR_OBJ}/%.o, ${SRC})

DIR_BIN_TEST=${DIR_BIN}/test
DIR_OBJ_TEST=${DIR_OBJ}/test
DIR_SRC_TEST=test

SRC_TEST=$(shell find ${DIR_SRC_TEST} -type f -name "*.c")
OBJ_TEST=$(patsubst ${DIR_SRC_TEST}/%.c, ${DIR_OBJ_TEST}/%.o, ${SRC_TEST})
BIN_TEST=$(patsubst ${DIR_SRC_TEST}/%.c, ${DIR_BIN_TEST}/%, ${SRC_TEST})

CCL_FLAGS_TEST=-L${DIR_LIB} -l${NAME}

.PHONY: all build setup dirs clean

all: setup ${LIB}

setup: dirs
ifeq (${BUILD_TYPE}, shared)
	@ CC_FLAGS="${CC_FLAGS} -fPIC"
endif

ifeq (${DEBUG}, true)
	@ CC_FLAGS="${CC_FLAGS} -g"
else
	@ CC_FLAGS="${CC_FLAGS} -O3"
endif
	$(info -- Compiling objects)

${LIB}: ${OBJ}
ifeq (${BUILD_TYPE}, shared)
	$(info -- Building shared library)
	${CCL_SH} ${CCL_SH_FLAGS} $^ -o $@.so
else
	$(info -- Building static library)
	${CCL_ST} ${CCL_ST_FLAGS} $@.a $^
endif

${DIR_OBJ}/%.o: ${DIR_SRC}/%.c
	@ mkdir -p $(dir $@)
	${CC} ${CC_FLAGS} $< -o $@

test: ${BIN_TEST}

${DIR_BIN_TEST}/%: ${DIR_OBJ_TEST}/%.o
	@ mkdir -p $(dir $@)
	${CC} $< ${CCL_FLAGS_TEST} -o $@

${DIR_OBJ_TEST}/%.o: ${DIR_SRC_TEST}/%.c
	@ mkdir -p $(dir $@)
	${CC} -I${DIR_SRC} ${CC_FLAGS} $< -o $@

dirs:
	$(info -- Creating dirs)
	mkdir -p ${DIR_BIN}
	mkdir -p ${DIR_LIB}
	mkdir -p ${DIR_OBJ}
	mkdir -p ${DIR_BIN_TEST}
	mkdir -p ${DIR_OBJ_TEST}

clean:
	$(info -- Cleaning)
	@ find ${DIR_BIN} -type f -exec rm -fv {} \;
	@ find ${DIR_LIB} -type f -exec rm -fv {} \;
	@ find ${DIR_OBJ} -type f -exec rm -fv {} \;
	@ find ${DIR_BIN_TEST} -type f -exec rm -fv {} \;
	@ find ${DIR_OBJ_TEST} -type f -exec rm -fv {} \;
