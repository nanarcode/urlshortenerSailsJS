var bcrypt = require('bcrypt');

module.exports = {

  attributes: {
    username : {
      type : 'string',
        required : true,
        unique : true
    },
      password:{
          type : 'string',
          required : true
      },
      toJSON : function(){
          var o = this.toObject();
          delete o.password;
          return o;
      }
  },

    beforeCreate: function(user, cb){
        bcrypt.genSalt(10,function(err,salt){
           bcrypt.hash(user.password, salt,function(err,hash){
             if(err){
                 console.log(err);
                 cb(err);
             }else{
                 user.password = hash;
                 cb(null, user);
             }
           });
        });
    }
};

