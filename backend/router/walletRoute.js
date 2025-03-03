const express = require('express')
const { registerWallet, listWallet, deleteWallet, withraw, walletInfo, financialsInfo } = require('../controller/walletController')
const { auth } = require('../middleware/authMiddleware')
const router = express.Router()

router.get('/', auth, walletInfo)

router.get('/financials', auth, financialsInfo)

router.get('/createWallet', auth, registerWallet)

router.get('/allWallets', auth, listWallet)

router.delete('/deleteWallet', auth, deleteWallet)

router.post('/withraw', auth, withraw)

module.exports = router