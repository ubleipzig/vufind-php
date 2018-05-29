#!/usr/bin/env bash
docker_test() {
	local msg=$1
	local test=$2
	local op=$3
	local expected=$4

	echo -ne "$msg... "
	if [ "$test" $op "$expected" ];then
		echo "passed"
		return 0
	else
		echo "failed"
		return 1
	fi
}

# check if file permissions are correct

# 5.6
echo "testing for www-data permissions..."
www_data_uid="$(docker run --rm ubleipzig/vufind-php:5.6 id -u www-data)"
www_data_gid="$(docker run --rm ubleipzig/vufind-php:5.6 id -g www-data)"

docker_test "test whether npm-cache belongs to user www-data" "$(docker run --rm ubleipzig/vufind-php:5.6 stat -c '%u' /home/www-data/.npm)" = $www_data_uid
docker_test "test whether npm-cache belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6 stat -c '%g' /home/www-data/.npm)" = $www_data_gid
docker_test "test whether vufind-application-dir belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6 stat -c '%g' /usr/local/vufind)" = $www_data_gid
docker_test "test whether vufind-cache-dir belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6 stat -c '%g' /var/cache/vufind)" = $www_data_gid

# 5.6-debug
docker_test "test weather www-data matches the developer's uid" "$(docker run --rm ubleipzig/vufind-php:5.6-debug id -u www-data)" = "$(id -u)"
docker_test "test weather www-data matches the developer's gid" "$(docker run --rm ubleipzig/vufind-php:5.6-debug id -g www-data)" = "$(id -g)"

docker_test "test whether npm-cache belongs to user www-data" "$(docker run --rm ubleipzig/vufind-php:5.6-debug stat -c '%u' /home/www-data/.npm)" = "$(id -u)"
docker_test "test whether npm-cache belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6-debug stat -c '%g' /home/www-data/.npm)" = "$(id -g)"
docker_test "test whether vufind-application-dir belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6-debug stat -c '%g' /usr/local/vufind)" = "$(id -u)"
docker_test "test whether vufind-cache-dir belongs to group www-data" "$(docker run --rm ubleipzig/vufind-php:5.6-debug stat -c '%g' /var/cache/vufind)" = "$(id -g)"

container="$(docker run -d --rm -p 9000:9000 ubleipzig/vufind-php:5.6)"
docker_test "test whether php-fpm is working"
docker stop "$container"