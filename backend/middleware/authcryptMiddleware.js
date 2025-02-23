const { isPotentiallyEncrypted, decrypt } = require("../utility/cryptUtility")

const authCrypt = (req, res, next) => {
    //check if it is encrypted
    if (isPotentiallyEncrypted) {
        //if it is decrypt and pass it along
        req.body.password = decrypt(req.body.password)
        req.body.email = decrypt(req.body.email)
    } else {
        //if not throw an error
        throw Error("An unknown error occured")
    }

    next()
}

module.exports = {authCrypt}