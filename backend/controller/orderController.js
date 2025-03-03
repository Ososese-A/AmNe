const alpaca = require('../utility/alpacaAuthUtility')

const buyOrder = async (req, res) => {
    //buy stock with wallet 
        // router.post('/walletBuy', (req, res) => {
        //     try {
        //         const {price, currency, itemSymbol, qty} = req.body
        //     } catch (error) {
        //     }
        // })

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
    //sell stcok with wallet 
        // router.get('', () => {
        //     try {
        //     } catch (error) {
        //     }
        // })


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