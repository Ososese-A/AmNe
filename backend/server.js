require('dotenv').config()
const express = require('express')
const { loggger } = require('./middleware/loggerMiddleware')
const loginRoutes = require('./router/loginRoute')
const signupRoutes = require('./router/signupRoute')
const orderRoutes = require('./router/orderRoute')
const stockRoutes = require('./router/stockRoute')
const accountRoutes = require('./router/accountRoute')
const mongoose = require('mongoose')

const app = express()



app.use(express.json())
app.use(loggger)
app.use('/api/account', accountRoutes)
app.use('/api/signup/', signupRoutes)
app.use('/api/login/', loginRoutes)
app.use('/api/order/', orderRoutes)
app.use('/api/stock/', stockRoutes)



const PORT = 8080 || process.env.PORT
mongoose
    .connect(process.env.MONGODB_URI)
    .then(
        app.listen(PORT, () => {
            console.log(`Live and connected to DB at PORT : ${PORT}`)
        })
    )
    .catch(
        (err) => {
            console.log(err)
        }
    )


