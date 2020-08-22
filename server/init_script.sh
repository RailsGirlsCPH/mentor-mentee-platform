#!/bin/sh

rails db:migrate RAILS_ENV=development
rails db:seed
rails server -b=0.0.0.0
