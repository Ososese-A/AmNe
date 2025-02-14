const express  = require('express')
const router = express.Router()
const {getStockInfo, getStockList} = require('../controller/stockController')

router.get('/getStockList', getStockList)

router.get('/getStockInfo', getStockInfo)

module.exports = router