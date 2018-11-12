var fs = require('fs')

var contents = fs.readFileSync('index.html', 'utf8')
var search_for = '<script data-injected-via-docker></script>'
var inner = process.env.ENV_CARRIER_PORTAL_JS_SCRIPT
var replace_with = '<script data-injected-via-docker>' + inner + '</script>'

var result = contents.replace(search_for, replace_with)

fs.writeFileSync('index.html', result, 'utf8')
