const { web3 } = require("../utility/walletUtility")
const { createWallet } = require("../service/walletService")
const User = require('../schemas/mongoose/userSchema')
const { decrypt } = require("../utility/cryptUtility")


const walletInfo = async (req, res) => {
    const { identification } = req.headers 
    const identify = identification
    console.log(identify)
    const id = decrypt(identify)
    console.log(id);

    const user = await User.findById(id)

    if (!user) {
        return res.status(404).json({error: "User not found"})
    }

    const walletinfo = user.accountfinancials[0].wallet[0]

    res.status(200).json(walletinfo)
}

const financialsInfo = async (req, res) => {
    const { identification } = req.headers 
    const identify = identification
    console.log(identify)
    const id = decrypt(identify)
    console.log(id);

    const user = await User.findById(id)

    if (!user) {
        return res.status(404).json({error: "User not found"})
    }

    const financialsinfo = user.accountfinancials

    res.status(200).json(financialsinfo)
}

const registerWallet = async (req, res) => {
    const { identification } = req.headers 
    const identify = identification
    console.log(identify)
    const id = decrypt(identify)
    console.log(id);


    try {
        const user =  await User.findById(id)

        const {address, privateKey} = createWallet()
        const salt = await bcrypt.genSalt(8)
        const identifyer = encrypt(privateKey)
        const hash = await bcrypt.hash(identifyer, salt)
        const key = `${identifyer}dif${hash}`
        const storedKey = encrypt(key)

        const wallet = user.accountfinancials[0].wallet
        const walletDetails = {
            address: address,
            balance: 0,
            identity: storedKey
        }

        if (wallet.length > 0) {
            wallet[0] = walletDetails;
        } else {
            wallet.push(walletDetails)
        }

        console.log(wallet)

        await user.save()

        res.status(201).json({address})
    } catch (error) {
        res.status(500).json({error: error.message})
    }
}

const listWallet = (req, res) => {
    try {
        res.status(200).json({walletStore})
    } catch (error) {
        res.status(500).send(error.message)
    }
}

const deleteWallet = () => {
    try {
    } catch (error) {
    }
}

const withraw = () => {
    try {
    } catch (error) {
    }
}

module.exports = { registerWallet, listWallet, deleteWallet, withraw, walletInfo, financialsInfo }