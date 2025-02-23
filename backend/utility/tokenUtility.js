const jwt = require('jsonwebtoken')

const createToken = (_id) => {
    return jwt.sign({_id}, process.env.SECRETKEY, {expiresIn: '1d'})
}

module.exports = {createToken}