const express = require('express')
const {  signup } = require('../controller/signupController')
const { checkSchema } = require('express-validator')
const { userValidationSchema } = require('../schemas/validation/userSchema')
const { authCrypt } = require('../middleware/authcryptMiddleware')


const router = express.Router()

router.post("/", authCrypt, checkSchema(userValidationSchema),  signup)

module.exports = router