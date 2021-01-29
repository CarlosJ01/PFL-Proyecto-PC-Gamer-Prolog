#pip install pyswip
#pip install -U flask-cors


import bottle
from bottle import route, run, template

from pyswip import Prolog

prolog = Prolog()
prolog.consult("pc-constructor.pl")

from bottle import response

# the decorator
def enable_cors(fn):
    def _enable_cors(*args, **kwargs):
        # set CORS headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token'

        if bottle.request.method != 'OPTIONS':
            # actual request; reply with the actual response
            return fn(*args, **kwargs)

    return _enable_cors


app = bottle.app()

#Ejemplo con cors de bottle
@app.route('/cors', method=['OPTIONS', 'GET'])
@enable_cors
def lvambience():
    response.headers['Content-type'] = 'application/json'
    return '[1]'

@route('/prolog/<P>/<G>/<R>/<M>/<A>/<T>/<J>')
@enable_cors
def compu2(P,G,R,M,A,T,J):

    response.headers['Content-type'] = 'application/json'

    if(P=='0'):
        P='P'
    if(G=='0'):
        G='G'
    if(R=='0'):
        R='R'
    if(M=='0'):
        M='M'
    if(A=='0'):
        A='A'
    if(T=='0'):
        T='T'
    if(J=='0'):
        consulta = "computadora("+P+","+G+","+R+","+M+","+A+",C,"+T+")"
    else:
        consulta = "computadora2("+P+","+G+","+R+","+M+","+A+",C,"+T+","+J+")"
    
    #Ejecucion de prolog
    listas=list(prolog.query(consulta))
    
    json = {}
    json['json'] = []
    
    datos = {}
    datos['p1'] = 'a'
    
    json['json'].append(datos)
    return json

app.run(port=8001)
