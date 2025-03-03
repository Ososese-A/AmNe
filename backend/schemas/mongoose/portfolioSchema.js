const mongoose = require("mongoose");


const portfolioSchema = new mongoose.Schema({
    stockName: {
        type: mongoose.Schema.Types.String,
        required: true
    }, 

    stockSymbol: {
        type: mongoose.Schema.Types.String,
        required: true
    },
}, {timestamps: true})

module.exports = { portfolioSchema }