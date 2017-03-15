<servers>
    <div class="c-overlay" if={ settingsOpen }  onclick={ settingsToggle }></div>
    <div class="o-modal" if={ settingsOpen }>
        <div class="c-card">
            <header class="c-card__header">
                <button type="button" class="c-button c-button--close" onclick={ settingsToggle }>×</button>
                <h2 class="c-heading">Modal heading</h2>
            </header>
            <div class="c-card__body o-grid" each={ servers }>
                <div class="o-grid__cell o-grid__cell--width-10">
                    <button class={ c-button: true, c-button--success: connected, c-button--error: !connected, c-button--rounded: true } onclick={ connectToggle } >
                        <i class="fa fa-fw fa-plug"> </i>
                    </button>
                </div>
                <div class="o-grid__cell">
                    <input type="text" class='c-field' value={ title } onclick={ killBub } oninput={ unfuck } />
                </div>
                <div class="o-grid__cell">
                    <input type="text" class='c-field' value={ uri } onclick={ killBub } />
                </div>
            </div>
            <footer class="c-card__footer">
                <button type="button" class="c-button c-button--brand" onclick={ settingsToggle }>Close</button>
            </footer>
        </div>
    </div>

    <div class="u-window-box--xlarge">
        <div class="o-grid">
            <div class="o-grid__cell o-grid__cell--width-25">
                <div class="c-card">
                    <div class="c-card__item c-card__item--brand u-centered">
                        <h1 onclick={ settingsToggle }>MQTT Dash</h1>
                    </div>
                    <div each={ servers } onclick={ showListeners } class="c-card__item c-card__item--dark">
                        <button class={ c-button: true, c-button--block: true, c-button--ghost-info: true, c-button--active: connected} }>
                            { title }
                        </button>
                    </div>
                </div>
            </div>


            <div class="o-grid__cell o-grid__cell--width-80">
                <listener
                    each={servers.filter(isConnected)} connected={ connected }
                    title={title} routes={routes}
                    uri={uri}>
                </listener>
            </div>
        </div>
    </div>

    <style>
        servers div.c-card__item--dark {
            background-color: #333;
        }
    </style>
    <script>
        this.servers = require('../config.json').servers;
        this.settingsOpen = opts.settingsOpen
        this.on('mount', function(){ this.settingsOpen = opts.settingsOpen })

        for (server in this.servers){
            this.servers[server].connected = server==0 ? true : false
        }

        this.openCoynt = 1;

        unfuck(e){
            console.log(e.srcElement.value)
        }

        settingsToggle(){
            this.settingsOpen = !this.settingsOpen;
        }

        function connectedCount(){
            return this.servers.filter(isConnected).length;
        }

        isConnected(s){
            return s.connected
        }

        killBub(e){
            e.cancelBubble = true
        }

        connectToggle(s){
            this.openCoynt -= s.item.connected;
            s.item.connected = !s.item.connected;
            this.openCoynt += s.item.connected;
            console.log(this.openCoynt)
            s.cancelBubble = true
        }

        showListeners(e){
            if(e.shiftKey == false){
                for (server in this.servers){
                    if(this.servers[server] != e.item){
                        this.servers[server].connected = false
                    }
                }
            }
            e.item.connected = !e.item.connected
        }
    </script>

</servers>
