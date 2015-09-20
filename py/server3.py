from bottle import route, run, template, request, response, static_file
import requests, json, bottle

# https://alchemyapi.readme.io/v1.0/docs/rest-api-documentation

ApiKey = '85e62ad889b1b15314bb96cf6387592215231fc5'
MaxResults = 2
Pfx = 'https://gateway-a.watsonplatform.net'

#@route('/images/<filename:re:.*\.png>')
#def send_image(filename):
#    return static_file(filename, root='/path/to/image/files', mimetype='image/png')

#@route('/static/<path:path>')
#def callback(path):
#    return static_file(path, ...)


def saveit(outfile,text):
    print "SAVE IT"
    import os
    text = text.replace('"','')
    cmd = """curl -k -u 474bf77c-0e50-4aca-a1ce-b3100f217aec:Nql0dzKQToEv  --header 'Content-Type: application/json'  --header 'Accept: audio/wav'  --data '{\"text\":\"%s\"}'  'https://stream.watsonplatform.net/text-to-speech/api/v1/synthesize' >static/wav/%s""" % ( text, outfile, )
    print "CMD", cmd
    print "---CMD"
    print "---CMD"
    print "---CMD"
    os.system( cmd )
    pass


@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='./static/')
    
@route('/top')
def _():
    response.headers['Access-Control-Allow-Origin'] = '*'
    max_results = request.params.get('max',MaxResults)
    term = request.params.get('term','Bernie+Sanders')
    #term = request.params.get('term','Apple')
    print max_results
    url = (Pfx + '/calls/data/GetNews?outputMode=json&start=now-1d&end=now&'+
           'count=5&'+
           'q.enriched.url.enrichedTitle.entities.entity=|text=%s|&'+
           'return=enriched.url.url,enriched.url.title,enriched.url.text&'+
           'maxResults=%s&apikey=%s') % (term,max_results,ApiKey,)
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
        print "X", x['id']
        id = x['id']
        #print "-", x["source"]["enriched"]["url"]
        rec = x["source"]["enriched"]["url"]
        title = unicode(rec["title"])
        title.encode('ascii','ignore')
        text  = unicode(rec["text"])
        text.encode('ascii','ignore')
        print '.', rec["text"]
        #    print "-", x["source"]["enriched"]["url"]["title"]

        #arr.append( dict( id=id, title=title, text=text ) )
        arr.append( dict( id=id, title=title ) )

        #print "TEXT", text[:1024]

        try:
            saveit( id, text )
            pass
        except:
            print "FAIL", id, text
        #arr.append( dict( id=id, title=title ) )

        #arr.append( rec["title"] )
        pass
    print '='*40
    print arr
    ' r["result"]["docs"] '
    r = dict(result=arr)
    r2 = json.dumps( r, indent = 5 )
    print '*'*40, 10
    print r2
    print '*'*40, 99
    #return ["hellooo"]
    return [r2]

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

#run(host='', port=8282)
from gevent.pywsgi import WSGIServer
from geventwebsocket import WebSocketError
from geventwebsocket.handler import WebSocketHandler
server = WSGIServer(("0.0.0.0", 8282), bottle.app(),
                    handler_class=WebSocketHandler)
server.serve_forever()
