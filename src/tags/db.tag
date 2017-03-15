<db>
        <div class="o-grid o-grid--small-full o-grid--medium-full o-grid--large-fit ">
            <table-list class="o-grid__cell o-grid__cell--width-30" ping={ ping }></table-list>
            <rows-list class="o-grid__cell " ping={ ping }></rows-list>
        </div>
    <!-- this script tag is optional -->
    <script>
        'using strict'
        var tag = this;
        tag.ping = opts.ping;

        tag.on('mount', () => {
                tag.ping.trigger('ready');
                riot.mount('table-list', { ping: tag.ping })
                riot.mount('rows-list', { ping: tag.ping })
        })
    </script>

</db>
