#!/bin/bash

# create source
rspm create source --name=crangrape --type=cran

# schedule source sync
rspm schedule --source=crangrape --cron='0 0 * * *' --sync-mode=lazy

# create repo
rspm create repo --name=snapple --description=A Snapple repo

# subscribe repo to source
rspm subscribe --source=crangrape --repo=snapple

