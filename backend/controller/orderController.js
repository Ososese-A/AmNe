const alpaca = require('../utility/alpacaAuthUtility')

const buyOrder = async (req, res) => {
    const side = "buy"
    const {symbol, qty} = req.body

    console.log(symbol, qty)

    try {
        await alpaca.createOrder({
            symbol,
            qty,
            side,
            type: "market",
            time_in_force: "day",
          });

        res.status(201).json({msg: "Success"})
    } catch (error) {
        console.log(error)
        res.status(500).send(error.message)
    }
}

const sellOrder = async (req, res) => {
    const side = "sell"
    const {symbol, qty} = req.body

    console.log(symbol, qty)

    try {
        await alpaca.createOrder({
            symbol,
            qty,
            side,
            type: "market",
            time_in_force: "day",
          });

        res.status(201).json({msg: "Success"})
    } catch (error) {
        console.log(error)
        res.status(500).send(error.message)
    }
}

module.exports = {buyOrder, sellOrder}