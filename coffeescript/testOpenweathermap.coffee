
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
Promise = require 'promise'

config = require './config'
getExternalData = require './openweathermap'

db = dbDriver.connectToServer(dbConfig.database).useDb(config.database.name + "_config")


configDbConfig = config.database.clone()
configDbConfig.name = configDbConfig.name + "_config"
configDb = dbDriver.useDb(configDbConfig)

dataDbConfig = config.database.clone()
dataDbConfig.name = dataDbConfig.name + "_data"
dataDb = dbDriver.useDb(dataDbConfig)

createViews = require '../create_views'

describe "fetch weather data from openweathermap",->

    it "should work", (done)->

    	location = 
    		latitude : 44.849264
    		longitude : -0.572434

        getExternalData location,(name,data)->
		    
            name.must.be('weather')
            console.log data
            # data.total_rows.must.be.at.least(1)

        done()
