/**
 *
 */
module.exports = {
    attributes:{
        longUrl:{
            type : 'url',
            required : true
        },
        shortUrl:{
            type : 'string'
        },
        clicks:{
            type : 'integer',
            defaultsTo : 0
        }
    },

    //npm install --save sails-hook-validation
    //permet de créer des messages d'erreur personnalisés
    validationMessages:{
      longUrl:{
          url : "L'url n'est pas valide.",
          required : "Vous devez indiquer une url."
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

