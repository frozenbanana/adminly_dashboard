# This file is licensed under the Affero General Public License version 3 or
# later. See the LICENSE file.

app_name=adminly_dashboard
build_directory=$(CURDIR)/build
temp_build_directory=$(build_directory)/temp
build_tools_directory=$(CURDIR)/build/tools
composer=$(shell which composer 2> /dev/null)

all: dev-setup lint build-js-production test

release: npm-init build-js-production build-tarball
# Dev env management
dev-setup: clean clean-dev composer npm-init


# Installs and updates the composer dependencies. If composer is not installed
# a copy is fetched from the web
composer:
ifeq (, $(composer))
	@echo "No composer command available, downloading a copy from the web"
	mkdir -p $(build_tools_directory)
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar $(build_tools_directory)
	php $(build_tools_directory)/composer.phar install --prefer-dist
	php $(build_tools_directory)/composer.phar update --prefer-dist
else
	composer install --prefer-dist
	composer update --prefer-dist
endif

npm-init:
	npm ci

npm-update:
	npm update

# Building
build-js:
	npm run dev

build-js-production:
	npm run build

watch-js:
	npm run watch

serve-js:
	npm run serve

# Linting
lint:
	npm run lint

lint-fix:
	npm run lint:fix

# Style linting
stylelint:
	npm run stylelint

stylelint-fix:
	npm run stylelint:fix

# Cleaning
clean:
	rm -rf js/*

clean-dev:
	rm -rf node_modules

# Tests
test:
	./vendor/phpunit/phpunit/phpunit -c phpunit.xml

build-tarball:
	rm -rf $(build_directory)
	mkdir -p $(temp_build_directory)
	rsync -a \
	--exclude=".git" \
	--exclude=".github" \
	--exclude=".vscode" \
	--exclude="node_modules" \
	--exclude="build" \
	--exclude="vendor" \
	--exclude=".editorconfig" \
	--exclude=".gitignore" \
	--exclude=".php_cs.dist" \
	--exclude=".prettierrc" \
	--exclude=".stylelintrc.json" \
	--exclude="composer.json" \
	--exclude="composer.lock" \
	--exclude="Makefile" \
	--exclude="package-lock.json" \
	--exclude="package.json" \
	../$(app_name)/ $(temp_build_directory)/$(app_name)
	tar czf $(build_directory)/$(app_name).tar.gz \
		-C $(temp_build_directory) $(app_name)

