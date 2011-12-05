Redmine Embedded Video Plugin
=====================

This is a Redmine plugin that allows to insert a Flash video player in Redmine.

Features
--------

* Embedded .flv, .f4v videos in Issues and Wiki
* Quick insertion with a button in the Wiki toolbar

Installation
------------

First setup the plugin (Considering your Redmine installation is in /var/www/redmine/):

    cd /var/www/redmine/vendor/plugins
    git clone git://github.com/martin-denizet/redmine_embedded_video.git
    apache2ctrl restart

Remove the plugin
-----------------

    rm -Rf /var/www/redmine/vendor/plugins/redmine_embedded_video


License
-------

Published under GPLv2

Contains Yusuke Kamiyamane's icons, licensed under CC Attribution 3.0
Contains JW Player for Flash, licensed under Creative Commons License.

Known Issues
------------

* None for the moment