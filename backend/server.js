require('dotenv').config()
const express = require('express')
const { loggger } = require('./middleware/loggerMiddleware')
const orderRoutes = require('./router/orderRoute')
const stockRoutes = require('./router/stockRoute')

const app = express()


app.use(express.json())
app.use(loggger)
app.use('/api/order/', orderRoutes)
app.use('/api/stock/', stockRoutes)

app.get('/accountInfo', async (req, res) => {
    try {
        const account = await alpaca.getAccount()

        if (account.trading_bloacked) {
            res.status(400).json({
                msg: 'Account is currently restricted from trading.'
            })
        }

        console.log(`$${account.buying_power} is available as buying power.`)

        const balanceChange = account.equity - account.last_equity;
        console.log("Today's portfolio balance change:", balanceChange);

        res.status(200).json({
            balanceChange,
            trading_bloacked: account.trading_blocked,
            buying_power: account.buying_power,
            account_status: account.status,
            equity: account.equity,
            last_equity: account.last_equity,
            ...account
        })

    } catch (error) {
        res.status(500).send(error.message)
    }
});

const PORT = 8080 || process.env.PORT
app.listen(PORT)