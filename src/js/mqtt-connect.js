// Mqtt api

var makeMqtt = function() {
    var self = this
    self.server = server
    self.client = ''
    riot.observable(self)
    self.on('start', function () {
        var client  = mqtt.connect(self.server.uri);

        client.on('connect', function () {
            for( route in self.server.routes ){
                client.subscribe(route)
            }
            mqttConnect.trigger('connect');
        })

        client.on('disconnect', function () {
            mqttConnect.trigger('disconnect');
        })

        client.on('message', function (topic, message) {
            var content=message
            var msg = {
                topic: topic,
                message: content,
                timestamp: new Date()
            };
            self.trigger('message', msg)
        })
    })
    self.on('stop', function () {
        if(client != ''){
            client.end();
        }
    })
}

exports.makeMqtt = makeMqtt
