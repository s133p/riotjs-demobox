<test-tag>

  <!-- this script tag is optional -->
  <script>
    this.on('mount', function(){
        console.log(opts.config)
        opts.chatty.trigger('start', opts.config)
    })
    this.on('unmount', function(){
        opts.chatty.trigger('stop')
    })

    opts.chatty.on('connect', function(){
        console.log('connected')
    })

    opts.chatty.on('message', function(msg){
        console.log('message: ' + msg.topic + ' : ' + msg.message )
    })
  </script>

</test-tag>
