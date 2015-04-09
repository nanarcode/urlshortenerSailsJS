/**
 *
 */
module.exports = {
    attributes:{
        longUrl:{
            type : 'string',
            required : true
        },
        shortUrl:{
            type : 'string'
        }
    },

    afterValidate : function (values, cb){
        var validUrl = require('valid-url');

        if(validUrl.isUri(values.longUrl)){
            var ShortUID = require('short-uid');
            var idGen = new ShortUID();
            var id = idGen.randomUUID();
            values.shortUrl = id;
            cb();
        }else{
            cb('url is not valid');
        }

    }
}

