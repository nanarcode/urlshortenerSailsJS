/**
 * UrlController
 *
 */

module.exports = {
    redirect : function(req,res){
        res.redirect('/');
    },

	create: function(req,res){
        if(typeof req.body.longUrl != 'undefined'){
            var longUrl = req.body.longUrl;
            var validUrl = require('valid-url');

            //on test si le format de l'url est valide
            if(validUrl.isUri(req.body.longUrl)){
                // l'url est valide on test si il est possible de se connecter à cette url
                var request = require('request');

                request(longUrl, function (error, response, body) {
                    //la connection est possible
                    if (!error && response.statusCode == 200) {
                        //on crée une chaine de char pour créer la petite url
                        var ShortUID = require('short-uid');
                        var idGen = new ShortUID();
                        var short = idGen.randomUUID();
                        //on insert l'object url dans la base de données
                        Url.create({longUrl : longUrl, shortUrl : short}).exec(function (err, created) {
                            //erreur lors de la création
                            if(err){
                                return res.view('homepage','Erreur interne');
                            }
                            console.log(created);
                            res.status(200);
                            created.created = true;

                            created.hostname = req.get('host');
                            return res.view('homepage',created);
                        });

                    }else{
                        res.status(400);
                        return res.view('homepage',{error : "Il est impossible de se connecter à cette url"});
                    }
                });



            }else{
                res.status(400);
                return res.view('homepage',{error : 'Url non valide'});
            }



        }else{
            res.send(400);
            return res.view('homepage',{error : 'Vous devez indiquer une URL'});

        }
    }
};

