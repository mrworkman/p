#!/bin/bash

# berks install
# berks vendor ..
sudo chef-client --local-mode -c client.rb -j node.json $*