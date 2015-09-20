import requests
r = requests.get('https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&count=5&q.enriched.url.enrichedTitle.entities.entity=|text=apple,type=company|&return=enriched.url.url,enriched.url.title&apikey=562d48f76a5e059e16c8422b5df77c8e57da9f19', verify=False)
print r.text
