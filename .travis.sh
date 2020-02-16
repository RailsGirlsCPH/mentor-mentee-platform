#!/bin/bash -e

case "$1" in
    server)
        cd server
        bundle install
        bundle exec rspec spec
        ;;
    *)
        echo "specify a test suite"
        exit 1
        ;;
esac

