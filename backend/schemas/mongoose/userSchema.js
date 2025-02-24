const mongoose = require("mongoose");
const bcrypt =require("bcrypt");
const validator = require("validator");
const { encrypt, decrypt } = require("../../utility/cryptUtility");

const userSchema = new mongoose.Schema({
    email : {
        type: mongoose.Schema.Types.String,
        unique: true,
        required: true
    },

    password : {
        type: mongoose.Schema.Types.String,
        required: true
    },

    pin : {
        type : mongoose.Schema.Types.String,
    }
})


userSchema.statics.signup = async function (data) {
    const email = data.email
    const password = data.password

    // console.log(password)
    // console.log(decrypt(password))
    // console.log(encrypt(password))
    // console.log(email)
    // console.log(decrypt(email))
    // console.log(encrypt(email))
    

    if (!email || !password) {
        throw Error("All fields must be filled")
    }

    if (!validator.isEmail(email)) {
        throw Error('Email is not valid')
    }

    const exists = await this.findOne({email});

    if (exists) {
        throw Error('Email already in use')
    }

    const salt = await bcrypt.genSalt(8);
    const hash = await bcrypt.hash(password, salt)

    const user = await this.create({email, password: hash})
    return user
}

userSchema.statics.login = async function (data) {
    const email = data.email
    const password = data.password

    if (!email || !password) {
        throw Error("All fields must be filled")
    }

    if (!validator.isEmail(email)) {
        throw Error(JSON.stringify({eError: 'Email is not valid'}))
    }

    const user = await this.findOne({email});

    if (!user) {
        throw Error(JSON.stringify({eError: 'Incorrect email'}))
    }

    const match = await bcrypt.compare(password, user.password)

    if (!match) {
        throw Error(JSON.stringify({pError: 'Incorrect Password'}))
    }

    return user
}

userSchema.statics.assignPin = async function (data) {
    const pin = data.pin
    const id = data.id

    if (!pin) {
        throw Error("Pin cannot be empty")
    }

    const user = await this.findOneAndUpdate({id}, {pin}, {new: true})

    if (!user) {
        throw Error("Incorrect Pin")
    }

    return user
}


module.exports = mongoose.model('User', userSchema)