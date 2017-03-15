<v-time>
    <span>{date.toLocaleTimeString()}</span>

    <script>
        'use strict';
        var tag = this;

        // console.log(opts);
        tag.date = opts.date ? new Date(opts.date) : new Date();
        tag.autoUpdate = opts.date ? false : true;
        if(tag.autoUpdate){
            // setInterval( ()=>{ tag.date=new Date(); tag.update(); }, 1000 );
        }
    </script>
</v-time>
