#!/bin/bash

# create source
rspm create source --name=crangrape --type=cran

# schedule source sync
rspm schedule --source=crangrape --cron='0 0 * * *' --sync-mode=lazy

# force sync
rspm sync --source=crangrape

# create repo
rspm create repo --name=snapple --description='A Snapple repo'

# subscribe repo to source
rspm subscribe --source=crangrape --repo=snapple


# create local source
rspm create source --name=apple --type=local

# add local package
# rspm add --source=apple --path=/testpackageblah_0.0.0.9000.tar.gz

# list packages
rspm list packages --source=apple

# create repo for local source
rspm create repo --name=juice --description='What type of juice do you want?'

# subscribe repo to local source
rspm subscribe --source=apple --repo=juice

# add another local package
# rspm add --source=apple --path=ggplot2_2.2.1.9000.tar.gz

# create repo for both CRAN and local
rspm create repo --name=cobbler --description='Cobbler for your cobbled cobbles'

# local packages take priority
rspm subscribe --source=apple --repo=cobbler

# add CRAN packages
rspm subscribe --source=crangrape --repo=cobbler
