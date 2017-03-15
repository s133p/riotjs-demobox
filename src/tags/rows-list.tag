<rows-list>
    <div class="c-card" if={ list != [] }>

        <div class="c-alert c-alert--info  u-xlarge">
            <button class="c-button c-button--close" onclick={ doBack }>×</button>
            Table Rows
        </div>
        <div class="c-card__item">
            <table class="c-table c-table--striped c-table--clickable">
                <thead class='c-table__head'>
                    <tr class='c-table__row c-table__row--heading'>
                        <th class='c-table__cell' each={ bit, i in list[0] } >
                            { i }
                        </th>
                    </tr>
                    <tr class='c-table__row c-table__row--heading'>
                        <th class='c-table__cell' each={ bit, i in filterDict } >
                            <div class="c-input-group">
                                <div class="o-field">
                                    <input ref="input" class="c-field u-xsmall" type="text" placeholder="filter" value={ bit } onkeyup={ filterUpdate }>
                                </div>
                                <button class="c-button c-button--brand u-xsmall" onclick={ doSort}><i class="fa fa-fw fa-sort"></i></button>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody class='c-table__body'>
                    <tr class='c-table__row' each={thing in list.filter( filters )}>
                        <td class='c-table__cell' each={ bit, i in thing } onclick={ edit }> { bit } </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="c-alert c-alert--warning  u-small" if={ list.filter( filters ).length == 0 && list.length != 0 } >
        No rows
    </div>

    <script>
        'using strict'
        const tag = this;

        tag.ping = opts.ping
        tag.list = []
        tag.filterDict = {}

        // Update filters
        tag.filterUpdate = e => tag.filterDict[e.item.i] = e.target.value

        // Sort based on column
        tag.doSort = (e) => {
            var col = e.item.i;
            tag.list.sort( function(lRow, rRow){
                if( lRow[col] > rRow[col] ) return 1
                if( lRow[col] < rRow[col] ) return -1
                return 0
            } )
        }

        // Filter list by current filters
        tag.filters = (e) => {
            var passes = true;
            for (thing in e){
                var row = thing
                var rowVal = ''
                if( e[thing] != null ){
                    rowVal = e[thing].toString().toLowerCase();
                }
                var matchVal = tag.filterDict[row].toString().toLowerCase();
                if( tag.filterDict[thing] != "" && rowVal.match(".*"+matchVal+".*") == null  ){
                    passes = false;
                }
            }
            return passes;
        }

        // User edited a filter
        tag.edit = (e) => {
            if(e.item.i.match(".+_id$")){
                var table  = e.item.i.slice(0,-3)+"s"
                tag.ping.trigger('query-table', table, '')
            }
        }

        tag.doBack = (e) => {
            tag.ping.trigger('ready');
        }

        tag.on('mount', () => {
            tag.list = []
            tag.filterDict = {}
            tag.ping.on('rows-list', (err, list) => {
                tag.filterDict = {}
                for( k in list[0] ){
                    tag.filterDict[k] = ''
                }
                tag.list = list || []
                tag.update();
            })
            tag.ping.on('table-list', () => {
                if( tag == undefined ) return;
                tag.list = []
                tag.filterDict = {}
                tag.update();
            })
        })
    </script>

</rows-list>
