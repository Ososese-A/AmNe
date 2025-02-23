const express = require('express')
const { login } = require('../controller/loginController')
const { checkSchema } = require('express-validator')
const { userValidationSchema } = require('../schemas/validation/userSchema')
const { authCrypt } = require('../middleware/authcryptMiddleware')


const router = express.Router()

router.post("/", authCrypt, checkSchema(userValidationSchema),  login)

module.exports = router