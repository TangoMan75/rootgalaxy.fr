#/**
# * TangoMan TangoMan RootGalaxy.fr
# *
# * TangoMan RootGalaxy.fr
# *
# * @version  0.1.0
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @licence  MIT
# * @link     https://github.com/TangoMan75/rootgalaxy.fr
# * @link     https://www.linkedin.com/in/morinmatthias
# */

.PHONY: help sass watch up install serve tests lint build deploy uninstall

#--------------------------------------------------
# Colors
#--------------------------------------------------

TITLE     = \033[1;42m
CAPTION   = \033[1;44m
BOLD      = \033[1;34m
LABEL     = \033[1;32m
DANGER    = \033[31m
SUCCESS   = \033[32m
WARNING   = \033[33m
SECONDARY = \033[34m
INFO      = \033[35m
PRIMARY   = \033[36m
DEFAULT   = \033[0m
NL        = \033[0m\n

#--------------------------------------------------
# Help
#--------------------------------------------------

## Print this help
help:
	@printf "${TITLE} TangoMan TangoMan RootGalaxy.fr ${NL}\n"

	@printf "${CAPTION} Infos:${NL}"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "login"  "$(shell whoami)"
	@printf "${PRIMARY} %-12s${INFO} %s${NL}" "system" "$(shell uname -s)"
	@printf "${NL}"

	@printf "${CAPTION} Description:${NL}"
	@printf "${WARNING} TangoMan RootGalaxy.fr${NL}\n"

	@printf "${CAPTION} Usage:${NL}"
	@printf "${WARNING} make [command] `awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"%s=[%s]\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq|tr '\n' ' '`${NL}\n"

	@printf "${CAPTION} Config:${NL}"
	$(eval CONFIG:=$(shell awk -F '?' '/^[ \t]+?[a-zA-Z0-9_-]+[ \t]+?\?=/{gsub(/[ \t]+/,"");printf"$${PRIMARY}%-12s$${DEFAULT} $${INFO}$${%s}$${NL}\n",$$1,$$1}' ${MAKEFILE_LIST}|sort|uniq))
	@printf " ${CONFIG}\n"

	@printf "${CAPTION} Commands:${NL}"
	@awk '/^### /{printf"\n${BOLD}%s${NL}",substr($$0,5)} \
	/^[a-zA-Z0-9_-]+:/{HELP="";if(match(PREV,/^## /))HELP=substr(PREV, 4); \
		printf " ${LABEL}%-12s${DEFAULT} ${PRIMARY}%s${NL}",substr($$1,0,index($$1,":")),HELP \
	}{PREV=$$0}' ${MAKEFILE_LIST}

##################################################
### Sass
##################################################

## Compile scss
sass:
	@printf "${INFO}sass src/scss/style.scss src/css/style.css${NL}"
	@sass src/scss/style.scss src/css/style.css

## Watch scss folder
watch:
	@printf "${INFO}sass --watch src/scss:src/css${NL}"
	@sass --watch src/scss:src/css

##################################################
### App
##################################################

## Build for production with minification
build: sass
	@printf "${INFO}rm -rf ./dist${NL}"
	@rm -rf ./dist

	@printf "${INFO}cat ./src/head.html ./src/article.html ./src/footer.html > ./src/index.html${NL}"
	@cat ./src/head.html ./src/article.html ./src/footer.html > ./src/index.html

	@printf "${INFO}mkdir ./dist${NL}"
	@mkdir ./dist

	@printf "${INFO}cp -r ./src/css ./dist${NL}"
	@cp -r ./src/css ./dist

	@printf "${INFO}cp -r ./src/favicon ./dist${NL}"
	@cp -r ./src/favicon ./dist

	@printf "${INFO}cp -r ./src/fonts ./dist${NL}"
	@cp -r ./src/fonts ./dist

	@printf "${INFO}cp -r ./src/images ./dist${NL}"
	@cp -r ./src/images ./dist

	@printf "${INFO}cp -r ./src/js ./dist${NL}"
	@cp -r ./src/js ./dist

	@printf "${INFO}cp ./src/CNAME ./dist${NL}"
	@cp ./src/CNAME ./dist

	@printf "${INFO}cp ./src/index.html ./dist${NL}"
	@cp ./src/index.html ./dist

	@printf "${INFO}cp ./src/robots.txt ./dist${NL}"
	@cp ./src/robots.txt ./dist

	@printf "${INFO}cp ./src/sitemap.xml ./dist${NL}"
	@cp ./src/sitemap.xml ./dist

## Deploy to gh-pages
deploy: build
	( \
		printf "${INFO}cd dist${NL}"; \
		cd dist; \
		printf "${INFO}git init${NL}"; \
		git init; \
		printf "${INFO}git add -A${NL}"; \
		git add -A; \
		printf "${INFO}git commit -m "$(shell date '+%Y-%m-%d %H:%M:%S')"${NL}"; \
		git commit -m "$(shell date '+%Y-%m-%d %H:%M:%S')"; \
		printf "${INFO}git push -f git@github.com:TangoMan75/rootgalaxy.fr.git master:gh-pages${NL}"; \
		git push -f git@github.com:TangoMan75/rootgalaxy.fr.git master:gh-pages; \
	)
