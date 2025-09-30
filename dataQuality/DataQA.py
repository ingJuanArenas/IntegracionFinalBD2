# Script para automatizar consultas de calidad de datos
import psycopg

with psycopg.connect(host="localhost", port=5432, dbname="dataMart- oficial", user="postgres", password="Manuel2309lm6") as conn:
    with conn.cursor() as cur:
        
        # Abrir archivo SQL
        with open("DataQA.sql", "r") as f:
            lines = f.readlines()
        
        query = ""
        descripcion = ""
        
        for line in lines:
            line = line.strip()
            
            # Guardar la descripción si es comentario
            if line.startswith("--"):
                descripcion = line[2:].strip()
                continue
            
            # Saltar líneas vacías
            if not line:
                continue
            
            # Acumular la query hasta el ;
            query += " " + line
            if line.endswith(";"):
                # Ejecutar query
                cur.execute(query)
                results = cur.fetchall()
                
                # Revisar resultados
                if len(results) == 0 or (len(results) == 1 and results[0][0] == 0):
                    print(f"{descripcion} -> OK")
                else:
                    print(f"{descripcion} -> ERROR: {results}")
                
                # Resetear query
                query = ""
