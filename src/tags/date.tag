<v-date>
    <span>{date.toLocaleDateString()}</span>

    <script>
        'use strict';
        var tag=this;

        tag.date = opts.date ? new Date(opts.date) : new Date();
    </script>
</v-date>
