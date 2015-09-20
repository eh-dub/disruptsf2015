from bottle import route, run, template, request, response
import requests, json

# https://alchemyapi.readme.io/v1.0/docs/rest-api-documentation

#ApiKey = '562d48f76a5e059e16c8422b5df77c8e57da9f19'
ApiKey = '85e62ad889b1b15314bb96cf6387592215231fc5'
MaxResults = 2

#url = "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=562d48f76a5e059e16c8422b5df77c8e57da9f19&outputMode=json&start=now-1d&end=now&maxResults=100&q.enriched.url.enrichedTitle.relations.relation=|action.verb.text=acquire,object.entities.entity.type=Company|&return=enriched.url.title"
'''
@route('/news.old')
def _():
    ret = []
    max_results = request.params.get('xxx',MaxResults)
    print max_results
    url = "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=%s&outputMode=json&start=now-1d&end=now&maxResults=%s&q.enriched.url.enrichedTitle.relations.relation=|action.verb.text=acquire,object.entities.entity.type=Company|&return=enriched.url.title" % (ApiKey,max_results)
    resp = requests.get(url, verify=False)
    print resp
    j = resp.json()
    print j
    print json.dumps(j)
    j2 = json.dumps(j, indent=5)
    print j2
    return [ j2 ]

@route('/apple')
def _():
    r = requests.get('https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&count=5&q.enriched.url.enrichedTitle.entities.entity=|text=apple,type=company|&return=enriched.url.url,enriched.url.title&apikey=562d48f76a5e059e16c8422b5df77c8e57da9f19', verify=False)
    print r.text
    return [ r.text ]

@route('/bernie')
def _():
    r = requests.get('https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&count=5&q.enriched.url.enrichedTitle.entities.entity=|text=Bernie+Sanders|&return=enriched.url.url,enriched.url.title&apikey=562d48f76a5e059e16c8422b5df77c8e57da9f19', verify=False)
    print r.text
    return [ r.text ]
'''

@route('/top.old')
def _():
    max_results = request.params.get('max',MaxResults)
    term = request.params.get('term','Bernie+Sanders')
    print max_results
    url = 'https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&count=5&q.enriched.url.enrichedTitle.entities.entity=|text=%s|&return=enriched.url.url,enriched.url.title&maxResults=%s&apikey=%s' % (term,max_results,ApiKey,)
    r = requests.get(url, verify=False)
    print r.text
    print max_results
    return [ r.text ]

@route('/top')
def _():
    max_results = request.params.get('max',MaxResults)
    term = request.params.get('term','Bernie+Sanders')
    #term = request.params.get('term','Apple')
    print max_results
    url = 'https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&count=5&q.enriched.url.enrichedTitle.entities.entity=|text=%s|&return=enriched.url.url,enriched.url.title&maxResults=%s&apikey=%s' % (term,max_results,ApiKey,)
    r = requests.get(url, verify=False)
    #print r.text
    j = r.json()
    print '='*40
    print j
    print '='*40
    print j["result"]
    print '='*40
    print j["result"]["docs"]
    lst = j["result"]["docs"]
    arr = []
    print '='*40
    for x in lst:
        #print "X", x
        print "-", x["source"]["enriched"]
        print "-", x["source"]["enriched"]["url"]["title"]
        arr.append( x["source"]["enriched"]["url"]["title"] )
        pass
    print '='*40
    print arr
    ' r["result"]["docs"] '
    return dict(result=arr)

@route('/news')
def _():
    ret = []
    max_results = request.params.get('xxx',MaxResults)
    print max_results
    url = "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=%s&outputMode=json&start=now-1d&end=now&maxResults=%s&q.enriched.url.enrichedTitle.relations.relation=|action.verb.text=acquire,object.entities.entity.type=Company|&return=enriched.url.title" % (ApiKey,max_results)
    resp = requests.get(url, verify=False)
    print resp
    j = resp.json()
    print j
    print json.dumps(j)
    j2 = json.dumps(j, indent=5)
    print j2
    return [ j2 ]

@route('/')
def index():
    return ["BLAH"]

@route('/hello/<name>')
def hello(name):
    return template('<b>Hello {{name}}</b>!', name=name)

run(host='', port=8080)
