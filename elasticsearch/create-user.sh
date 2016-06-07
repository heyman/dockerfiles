#!/bin/bash

## Create a user for the web app.
addgroup --gid 9999 elasticsearch
adduser --uid 9999 --gid 9999 --disabled-password --system --no-create-home --gecos "ElasticSearch" elasticsearch
