#!/bin/bash
make -C source release
git add * && git add -u * . && git commit -m "Update" && git push