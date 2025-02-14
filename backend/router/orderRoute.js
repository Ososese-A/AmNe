const express = require('express')
const router = express.Router()
const {buyOrder, sellOrder} = require('../controller/orderController')

router.post('/buyOrder', buyOrder)

router.post('/sellOrder', sellOrder)

module.exports = router;