LIB_DIR 	:= ./lib
DIST_DIR 	:= ./dist
SRC_DIR 	:= ./src
TST_DIR 	:= ./tst

NODE_PATH := '.'
TARGET_FILENAME  := 'short-uid'

NODE_MODULES := ./node_modules
NODE_MODULES_BIN := ${NODE_MODULES}/.bin

MOCHA  := ${NODE_MODULES_BIN}/mocha
COFFEE := ${NODE_MODULES_BIN}/coffee
UGLIFY := ${NODE_MODULES_BIN}/uglifyjs

all: clean install compile test

install:
	npm install

compile:
	${COFFEE} -o ${LIB_DIR} -c ${SRC_DIR}/*.coffee
	mkdir -p ${DIST_DIR} && ${UGLIFY} ${LIB_DIR}/${TARGET_FILENAME}.js > ${DIST_DIR}/${TARGET_FILENAME}.min.js

test: compile
	NODE_PATH=${NODE_PATH} ${MOCHA} -s 1000 --compilers coffee:coffee-script/register -R spec ${TST_DIR}

clean:
	rm -rf ${LIB_DIR} ${DIST_DIR} ${NODE_MODULES}
