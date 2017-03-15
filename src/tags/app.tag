<app>
    <ul class="c-nav c-nav--inline">
        <li id="db" class={ navClass + (mode == 'db' ? navClassSelected : ' ') } onclick={ go }>
            <i class="fa fa-fw fa-database"></i>
        </li>
        <li id="servers" class={ navClass + (mode == 'servers' ? navClassSelected : ' ') } onclick={ go }>
            <i class="fa fa-fw fa-bar-chart"></i>
        </li>
        <li id="status" class={ navClass + (mode == 'status' ? navClassSelected : ' ') } onclick={ go }>
            <i class="fa fa-fw fa-user-circle-o"></i>
        </li>
        <li id="settings" class={ navClass + navClassRight + (mode == 'settings' ? navClassSelected : ' ') } onclick={ go }>
            <i class="fa fa-fw fa-sliders"></i>
        </li>
    </ul>
    <div class="u-window-box--medium">
        <servers if={ mode == 'servers' } settingsOpen={ settingsOpen } />
        <db if={ mode == "db" } ping={ opts.ping } />
        <user-status if={ mode == "status" } />
            <layout-root layout={ layoutData }  if={ mode == "settings" }/>

    </div>

    <!-- this script tag is optional -->
    <script>
        'using strict'
        var tag = this;
        tag.layoutData = require('../layout_test.json')

        tag.mode = 'settings'
        tag.ping = opts.ping
        tag.navClass = "c-nav__item c-nav__item--info u-xlarge"
        tag.navClassSelected = " c-nav__item--active"
        tag.navClassRight = " c-nav__item--right"

        tag.go = (e) => {
            var id = e.target.id || e.target.parentNode.id
            tag.mode = id
            tag.update()
        }
    </script>

</app>
