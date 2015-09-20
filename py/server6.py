from bottle import route, run, template, request, response, static_file
import requests, json, bottle

# https://alchemyapi.readme.io/v1.0/docs/rest-api-documentation

ApiKey = '85e62ad889b1b15314bb96cf6387592215231fc5'
MaxResults = 2
Pfx = 'https://gateway-a.watsonplatform.net'

def saveit(outfile,text):
    import os
    text = text.replace('"','')
    cmd = """curl -k -u 474bf77c-0e50-4aca-a1ce-b3100f217aec:Nql0dzKQToEv  --header 'Content-Type: application/json'  --header 'Accept: audio/wav'  --data '{\"text\":\"%s\"}'  'https://stream.watsonplatform.net/text-to-speech/api/v1/synthesize' >static/wav/%s 2>/dev/null""" % ( text, outfile, )
    #print "CMD", cmd
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
           'return=enriched.url.url,enriched.url.title,enriched.url.text,enriched.url.entities&'+
           'maxResults=%s&apikey=%s') % (term,max_results,ApiKey,)
    r = requests.get(url, verify=False)
    j = r.json()
    print '~'*40
    #print j
    print '~'*40
    lst = j["result"]["docs"]
    arr = []
    for x in lst[:]:
        print "=======X", x['id']
        #print x
        myid = x['id']
        rec = x["source"]["enriched"]["url"]
        print rec

        entities = rec["entities"]

        earr = []

        print '    . . . ',entities

        for e in entities:
            print '  == ',e['text']
            earr.append( e['text'] )
            pass

        title = unicode(rec["title"])
        title = title.encode('ascii','ignore')
        text  = unicode(rec["text"])
        text = text.encode('ascii','ignore')
        arr.append( dict( id=myid, title=title, entities=earr ) )
        #text = text.replace("'", "\'")
        text = text.replace("'", "")
        text = text.replace("\"", "")
        text = text.replace("<", "")
        text = text.replace(">", "")
        text = text.replace("\\", "")
        text = text.replace("\r", "")
        text = text.replace("\n", " ")
        try:
            print "ID", myid
            #print '  txt', (text)
            #print '  txt', repr(text)
            saveit( myid, text )
        #    pass
        except:
            print "FAIL", myid, text
            pass
        pass

    r = dict(result=arr)
    return r
    r2 = json.dumps( r, indent = 5 )
    return [r2]

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
server = WSGIServer(("0.0.0.0", 8484), bottle.app(),
                    handler_class=WebSocketHandler)
server.serve_forever()
