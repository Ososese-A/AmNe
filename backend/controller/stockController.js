const alpaca = require('../utility/alpacaAuthUtility')

const getStockList = async (req, res) => {
    try {
        const activeAssets = await alpaca.getAssets({status: "active",})
           const nasdaqAssets = activeAssets.filter(
                (asset) => asset.exchange == "NASDAQ"
                );
        // console.log(nasdaqAssets)
        res.status(200).json({nasdaqAssets})
    } catch (error) {
        console.log(error)
        res.status(500).send(error.message)
    }
}

const getStockInfo = async (req, res) => {
    const stock = req.query.stock
    let stockInfo = {}
    console.log(stock)
    try {
        await alpaca.getAsset(`${stock}`)
        if (stockCheck.tradable) {
            console.log(`We can trade ${stock}.`);
            // console.log(stockCheck);
            stockInfo = stockCheck
          }

          res.status(200).json(stockInfo)
    } catch (error) {
        console.log(error)
        res.status(500).send(error.message)
    }
}

module.exports = {getStockList, getStockInfo}