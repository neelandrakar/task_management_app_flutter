const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {

    try{

        const token = req.header('x-auth-token');

        if(!token)
            return res.status(401).json({
                success : false,
                msg: "No auth token, access denied!"
        });

        const verified = jwt.verify(token, "PasswordKey");

        if(verified)
            return res.status(401).json({
                success : false,
                msg: "Token verification failed, authrization failed!"
        });

        req.user = verified.id;
        req.token = token;
        next();
        
    }catch(err){
        res.status(500).json({
            success : false,
            error: err.message
        });
    }
}

module.exports = auth;