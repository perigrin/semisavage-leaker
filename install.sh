#!/bin/bash

carton install --deployment
carton exec cpanm -l xs MooseX::XSAccessor
