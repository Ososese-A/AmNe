const loggger = (req, res, next) => {
    console.log(`The URL: ${req.url},  The Method: ${req.method}`)
    next()
}

module.exports = {loggger}