<table-list>
    <div class="c-card">
        <div class="c-alert c-alert--brand">
            <h3>Tables</h3>
        </div>
        <div class="c-card__item" each={thing in list}>
            <button type="button" class="c-button c-button--block c-button--ghost-info"  onclick={ ask }>{ thing.name }</button>
        </div>
    </div>


  <!-- this script tag is optional -->
  <style>
  table-list {
        display:block;
  }
  </style>
  <script>
      var tag = this;
      tag.ping = opts.ping;
      tag.list = []
      tag.ping.on('table-list', function(err, list){ 
          tag.list = list ? list : []
          tag.update();
      })
      tag.ask = function(e){
          tag.ping.trigger('query-table', e.item.thing.name, "");
      }
  </script>

</table-list>
