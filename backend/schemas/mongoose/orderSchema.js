const mongoose = require("mongoose");

const orderSchema = new mongoose.Schema({
    type: {
        type: mongoose.Schema.Types.String
    },

    pricePerStock: {
        type: mongoose.Schema.Types.Number
    },

    NoOfStocks: {
        type: mongoose.Schema.Types.Number
    },

    orderFee: {
        type: mongoose.Schema.Types.Number
    }
    
}, {timestamps: true})

module.exports = { orderSchema }