<grid-cell>
    <div class="o-grid__cell { shrink ? 'o-grid__cell--shrink' : '' } { width }">
        <yield/>
    </div>

    <style>
        grid-cell { display: block; }
        grid-cell div.o-grid__cell--shrink { flex-basis: auto; flex-grow:0;}
    </style>
    <script>
        'use strict';
        var tag = this;
        tag.width = opts.width != null ? 'o-grid__cell--width-' + opts.width : '';
        tag.shrink = opts.shrink;
    </script>
</grid-cell>
