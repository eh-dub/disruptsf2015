from bottle import route, run, template, request, response, static_file
import requests, json

# https://alchemyapi.readme.io/v1.0/docs/rest-api-documentation

ApiKey = '85e62ad889b1b15314bb96cf6387592215231fc5'
MaxResults = 2
Pfx = 'https://gateway-a.watsonplatform.net'

def saveit(outfile,text):
    import os
    text = text.replace('"','')
    cmd = """curl -k -u 474bf77c-0e50-4aca-a1ce-b3100f217aec:Nql0dzKQToEv  --header 'Content-Type: application/json'  --header 'Accept: audio/wav'  --data '{\"text\":\"%s\"}'  'https://stream.watsonplatform.net/text-to-speech/api/v1/synthesize?voice=en-GB_KateVoice' >static/wav/%s.wav 2>/dev/null &""" % ( text, outfile, )
    #print "CMD", cmd
    os.system( cmd )
    pass

# PODCAST
    
@route('/static/<filename:path>')
def send_static(filename):
    print "BLAH"
    return static_file(filename, root='./static/')
    
@route('/top')
def _():
    response.headers['Access-Control-Allow-Origin'] = '*'
    max_results = request.params.get('max',MaxResults)
    term = request.params.get('term','Bernie+Sanders')

    term = term.replace('%20','+')

    #term = request.params.get('term','Apple')
    print max_results
    url = (Pfx + '/calls/data/GetNews?outputMode=json&start=now-1d&end=now&'+
           'count=5&'+
           'q.enriched.url.enrichedTitle.entities.entity=|text=%s|&'+
           'return=enriched.url.url,enriched.url.title,enriched.url.text,enriched.url.entities&'+
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
    arr2 = []
    for x in lst:
        print "X", x['id']
        id = x['id']
        #print "-", x["source"]["enriched"]["url"]
        rec = x["source"]["enriched"]["url"]
        title = unicode(rec["title"])
        title = title.encode('ascii','ignore')
        text  = unicode(rec["text"])
        text = text.encode('ascii','ignore')
        print '.', rec["text"]


        text = text.replace("'", "")
        text = text.replace("\"", "")
        text = text.replace("<", "")
        text = text.replace(">", "")
        text = text.replace("\\", "")
        text = text.replace("\r", "")
        text = text.replace("\n", " ")
        try:
            print "ID", id
            #print '  txt', (text)
            #print '  txt', repr(text)
            saveit( id, text )
            #    pass
        except:
            print "FAIL", id, text
            pass
        pass



        #    print "-", x["source"]["enriched"]["url"]["title"]

        entities = rec["entities"]
        earr = []
        print '    . . . ',entities
        for e in entities:
            print '  == ',e['text']
            earr.append( e['text'] )
            pass
        
        url2  = unicode(rec["url"])

        print "URl2", url2

        if 'tumblr' in url2:
            continue
        if 'twitter' in url2:
            continue

        #if 'Optional' in title:
        #    continue

        #sarr = title.split(':')
        #title = ':'.join ( sarr[:-1] )

        #arr.append( dict( id=id, title=title, text=text ) )
        #arr.append( dict( id=id, title=title, url2=url2 ) )
        arr.append( dict( id=id, title=title, url2=url2, entities=earr ) )

        arr2.append( id )
        arr2.append( title )

        #arr.append( rec["title"] )
        pass
    print '='*40
    print arr
    ' r["result"]["docs"] '
    r = dict(result=arr)
    r2 = json.dumps( arr2[:3], indent = 5 )
    r2 = json.dumps( arr, indent = 5 )
    return [r2]
    print '*'*40
    print r
    return r
    print '*'*40
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

run(host='', port=8181)
