const sqlite3 = require('sqlite3');
const riot = require('riot');

require('./src/tags/date.tag');
require('./src/tags/v-time.tag');

require('./src/tags/grid-parent.tag');
require('./src/tags/grid-cell.tag');

require('./src/tags/layout/layout-root.tag');

require('./src/tags/tables-list.tag');
require('./src/tags/rows-list.tag');

require('./src/tags/servers.tag');
require('./src/tags/listener.tag');

require('./src/tags/user-status.tag');

require('./src/tags/db.tag');
require('./src/tags/app.tag');

function doDb(ev, triggerType, table, where, sort ){
    var db = new sqlite3.Database('./src/db.sqlite');
    var query = "SELECT * FROM " + table;
    if(where != ""){
        query += " WHERE " + where;
    }
    if(sort != undefined){
        query += " ORDER BY " + sort.id + " " + sort.type;
    }
        query += ";"
    console.log("doing query: " + query)
    db.all(query, function(err, data){ ev.lister(triggerType, err, data) });
    db.close();
};

function ping() {
  riot.observable(this)

  this.lister = function(triggerType, err, list) { this.trigger(triggerType, err, list); }
  this.on('ready', function(){doDb(this, 'table-list', "sqlite_master", "type='table'");})
  this.on('query-table', function(table, where){ doDb(this, 'rows-list', table, where) })
}
var pong = new ping();

riot.mount('app', {mode: 'servers', ping: pong})
