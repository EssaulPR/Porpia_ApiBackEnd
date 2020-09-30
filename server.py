from flask import Flask
app= Flask(__name__)

# @app.route("/")
# def hello():
#     return {"Nombre": "Essaul", "Calf":10}

@app.route("/api/cereales")
def alumnos():
    import csv
    json = {}
    lista_cereales = []
    with open('cereales.csv', newline='',encoding='utf-8') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in spamreader:
            lista_cereales.append({"Numeracion":row[0], "Cereales": row[1]})

    json["Lista De Cereales"] = lista_cereales     
    return json