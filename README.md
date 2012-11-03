zappajs-template
================

A working ZappaJS server with useful templates

Start coding
------------

Make sure you have coffee-script

    [sudo] npm install -g coffee-script

Install and test:

    git clone git://github.com/zappajs/zappajs-template.git
    npm install

Edit `bin/server.coffee` to taste

    npm start

Deploy on your server
---------------------

    git clone <your-zappajs-template-repository>
    npm config set production true
    npm install
    npm start

Deploy on nodejitsu
-------------------

    jitsu signup
    jitsu login
    jitsu deploy


Use Node Cluster
-------------------
To start your app on cluster mode, with one worker per cpu:
    
    coffee bin/cluster.coffee --cluster

Check out http://shimaore.zappajs-template.jit.su/ to see the default application.