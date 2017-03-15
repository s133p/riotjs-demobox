<grid-parent>
    <div class={ o-grid: true, o-grid--center: center, o-grid--wrap: wrap }>
        <yield/>
    </div>

    <style>
        grid-parent { display: block; }
    </style>
    <script>
        'use strict';
        var tag = this;
        tag.data = opts.data;
        tag.center = opts.center || false;
        tag.wrap = opts.wrap || false;
    </script>
</grid-parent>
