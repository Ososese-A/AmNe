const { isPotentiallyEncrypted, decrypt } = require("../utility/cryptUtility")

const authCrypt = (req, res, next) => {
    //check if it is encrypted
    if (isPotentiallyEncrypted(req.body.email)) {
        //if it is decrypt and pass it along
        req.body.password = decrypt(req.body.password)
        req.body.email = decrypt(req.body.email)
    } else {
        //if not throw an error
        throw Error("Unreconized or invalid encryption")
    }

    next()
}

const pinCrypt = (req, res, next) => {
    if(isPotentiallyEncrypted(req.body.pin)) {
        req.body.pin = decrypt(req.body.pin)
    } else {
        throw Error("Unreconized or invalid encryption")
    }
    next()
}

module.exports = {authCrypt, pinCrypt}