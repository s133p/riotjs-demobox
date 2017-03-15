<listener>
    <div class="c-card" if={ connected }>
        <div class="c-card__item c-alert" ><h3>{title}</h3></div>
        <div class="c-card__item "  each={ name, i in routes }>
            <h4 onclick={ foldRoute }>{ folds[i] ? "+" : "-" } { name }</h4>
            <div hide={ folds[i] } class="o-grid o-grid--center" each={ itemsForRoute(name) }>
                <div class="o-grid__cell">
                    { message }<br/>
                    <span class="u-small">{topic}</span>
                </div>
                <div class="o-grid__cell o-grid__cell--shrink u-window-box--small" style="text-align: right">
                    <span class="u-xsmall">
                        <v-date date={ timestamp } /><br/>
                        { timestamp.toLocaleTimeString() }
                    </span>
                </div>
            </div>
        </div>
    </div>


    <style>
        listener { display: block; margin-bottom: 2em; }
        listener div.o-grid__cell--shrink { flex-basis: auto; flex-grow:0;}

    </style>
    <script>
    var listen = this;
    this.items = []

    this.folds = opts.routes.slice(0);
    this.folds.fill(false);

    this.routes = opts.routes;
    this.uri = opts.uri;
    this.title = opts.title
    this.status = opts.status;


    routesIfConnected(){
        return opts.connected ?  opts.routes : []
    }

    enabled(r){
        return r.enabled;
    }

    foldRoute(e){
        this.folds[e.item.i] = !this.folds[e.item.i]
        this.update();
    }

    function matchesTopic(r, t){
            var topicMatcher = r.replace("+", ".*");
            topicMatcher = topicMatcher.replace("#", ".*");
            topicMatcher = topicMatcher.replace("/", "\/");

            return t.match(topicMatcher) != null;
    }

    itemsForRoute(r) {
        return listen.items.filter(function(item){
            return matchesTopic(r, item.topic);
        }).sort(function(l, r){
            if(l.timestamp < r.timestamp) return 1;
            if(l.timestamp > r.timestamp) return -1;
            return 0;
        })
    }

    var mqtt = require('mqtt');
    var client = ''
    this.on('mount', function(){ this.update() });
    this.on('unmount', function(){

    });
    this.on('update', function(){
        if(opts.connected && client == ''){
            client  = mqtt.connect(this.uri);

            client.on('connect', function () {
                for(var i=0; i < opts.routes.length; ++i){
                    client.subscribe(opts.routes[i]);
                    opts.routes[i].folded = false;
                }
                listen.status = true;
                opts.status = listen.status;
                listen.update();
            })

            client.on('message', function (topic, message) {
                var content=""
                content=message
                listen.items.push(
                    {
                        topic: topic,
                        message: content,
                        timestamp: new Date(),
                    }
                );
                listen.update();
            })
        }else if (!opts.connected && client != ''){
            client.end()
            listen.items = []
            listen.status = true;
            opts.status = listen.status;
            listen.update();
        }
    })
    // this.on('update', function() { })
    </script>

</listener>
