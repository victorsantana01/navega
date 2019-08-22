/* DOWNLOAD DE CLIENTES == */
function downloadClientes(){

    $.post('http://52.14.21.184:8090/api-kronos/agenda/listarCliente.jsp', function(jsonCa){

        /* CONSULTAR INFORMAÇÕES == */
        conectBd.transaction(function(sql){

            /* RETORNANDO DADOS == */
            var totalCliente = jsonCa.totalCliente;
            var loopBd = jsonCa.loopBd;
            var qntLoopBd = loopBd.length;

            for(var i=0;i<qntLoopBd;i++){

                /* DADOS DO LOOP == */
                var idCliente = loopBd[i].idCliente;
                var nomeCliente = loopBd[i].nomeCliente;

                /* VERIFICAR SE E ULTIMO REGISTRO == */
                if(i==(qntLoopBd-1)){
                    var ultimoRg = 1;
                } else {
                    var ultimoRg = 0;
                }

                /* CONVERTER DADOS == */
                var codCa = idCliente;
                var razao = nomeCliente;
                var jsonCaLp = {codCa:codCa, razao:razao, ultimoRg:ultimoRg};

                processarClientes(sql, jsonCaLp);
                
            }

        });

    })

}

/* PROCESSAR CLIENTES == */
function processarClientes(sql, jsonCa){

    /* RETORNANDO DADOS == */
    var codCa = jsonCa.codCa;
    var razao = jsonCa.razao;
    var ultimoRg = jsonCa.ultimoRg;

    /* CONSULTAR DADOS == */
    sql.executeSql("SELECT * FROM clientes WHERE codCa='"+codCa+"'", [], function(sql, resultados){

        var totalBd = resultados.rows.length;

        if(totalBd == 0){

            /* SALVAR DADOS == */
            sql.executeSql("INSERT INTO clientes (codCa, razao) VALUES('"+codCa+"', '"+razao+"')", [], function(sql, resultados){
                
            }, function(sql, erro){
                console.log(erro);
            });

        }

        /* EXECULTA O LOOP DE CLIENTES == */
        if(ultimoRg == 1){
            loopClientes();
        }

    }, function(sql, erro){
        console.log(erro);
    });

}