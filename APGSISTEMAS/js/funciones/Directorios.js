function CargarMapa() {
    $.ajax({
        type: "POST",
        url: "wsIngresoDirectorio.asmx/DirectorioMapa",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            //$.each(msg.d, function (index, item) {
            //    $("#DropDepartamento").trigger('chosen:updated').append("<option value='" + item.IdDepartamento + "'>" + item.Nombre + "</option>");
            //});
            //$("#DropDepartamento, #DropDepartamento3, #DropDepartamentoOrigen4, #DropDepartamentoDestino4").select2().select2("val");
            console.log(msg.d)
            var array =[]
            $.each(msg.d, function (index, item) {
                array.push({id: item.id, value : item.value})

            });
            console.log(array)
            console.log(msg.d)
            map = new AmCharts.AmMap();


            map.colorSteps = 10
            map.areasSettings = {
         
              
            };
            var dataProvider = {
                mapVar: AmCharts.maps.guatemalaLow,
                areas: msg.d
                
            };

            map.areasSettings = {
                autoZoom: false,
                balloonText: "[[title]] Sucursales: [[value]]",
                selectable: true
            };
            map.dataProvider = dataProvider;
          
            var valueLegend = new AmCharts.ValueLegend();
            valueLegend.right = 10;
            valueLegend.minValue = "little";
            valueLegend.maxValue = "a lot!";
            map.valueLegend = valueLegend;
            map.addListener("clickMapObject",Prueba);
               
            
            map.write("mapdiv");
        },
        error: function (msg) {
            Error(msg.responseText);
        }
    });

}


var map;

jQuery(document).ready(function () {
    
    CargarMapa()
   
});

function Prueba(event) {
    var nemonico = event.mapObject.id
    MostrarDetalleDirecorio(nemonico);
    console.log(event);
    $("#mapdiv").hide('linear');
    $("#tableDetalle").show('linear');
    
}

function MostrarDetalleDirecorio(nemonico) {
    $("#btnRegresar").show('linear');
    $("#tableDetalle").dataTable().fnClearTable();
    $.ajax({
        type: "POST",
        url: "wsIngresoDirectorio.asmx/DirectorioMapaDetalle",
        data: "{ 'nemonico': '" + nemonico + "' }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                $("#tableDetalle").dataTable().fnAddData([
                    item.IdDirectorio,
                    item.NombreCompania,
                    item.NombreDepartamento,
                    item.NombreMunicipio,
                    "<button type='button' id='" + item.IdDirectorio + "' class='btn btn-default btn-xs BtnEditarDirectorio'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarCliente'></i> Editar</button>"
                ]);
            });
        },
        error: function (data) {
            console.log(data);
        }
    });
}


$("#btnRegresar").click(function () {
    $("#mapdiv").show('linear');
    $("#tableDetalle").hide('linear');
    $("#btnRegresar").hide('linear');
    CargarMapa()
});

$("#BtnMostrarTodo").click(function () {
    MostrarDetalleDirecorio(0)
});


$("#tableDetalle tbody").on("click", ".BtnEditarDirectorio", function () {
    //            IndexTr = $(this).parent().parent().index();
    //            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
    $("#BtnEditarC").show();
    $("#BtnGuardarC").hide();
    $("#LblModificar").show();
    $("#LblCrear").hide();
    var id = this.id;

    //$("#CheckPool div").removeClass("active");
    $.ajax({
        type: "POST",
        url: "wsProductos.asmx/CatalogoClientes",
        data: "{ 'IdCliente': " + id + " }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                $("#textMDId").val(item.idProducto);
                // $("#textMDPool").val(item.poolv);
                $("#textMDCodigo").val(item.codigo);
                $("#textMDNombre").val(item.Descripcion);
                  
                 
                $("#txtMDCodigo").val(item.codigo);

                $('#DropEstatus').val(item.IdEstado).trigger("chosen:updated");
                $('#DropProveedor').val(item.idProveedor).trigger("chosen:updated");
                $('#DropDUnidad').val(item.idUnidad).trigger("chosen:updated");
                $('#DropCategoria').val(item.idCategoria).trigger("chosen:updated");
                if (item.IdEstado) {
                    $('#DropEstatus').val(1).trigger("chosen:updated");
                } else {
                    $('#DropEstatus').val(0).trigger("chosen:updated");
                }

            });
            $('.ModalEditarVehiculo').modal('toggle');
        },
        error: function (data) {
            console.log(data);
        }
    });
});


$(document).ready(function () {
    LlenarDepartamentos();

});

function LlenarDepartamentos() {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Departamentos",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            $.each(msg.d, function (index, item) {
                $("#DropDepartamento").trigger('chosen:updated').append("<option value='" + item.IdDepartamento + "'>" + item.Nombre + "</option>");
            });
            //$("#DropDepartamento, #DropDepartamento3, #DropDepartamentoOrigen4, #DropDepartamentoDestino4").select2().select2("val");
            LlenarMunicipio($("#DropDepartamento").val());
        },
        error: function (msg) {
            Error(msg.responseText);
        }
    });
    jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
}

function LlenarMunicipio(IdDepartamento) {
    $.ajax({
        type: "POST",
        url: "wsdepartamentomunicipio.asmx/Municipios",
        contentType: "application/json; charset=utf-8",
        data: "{IdDepartamento:" + IdDepartamento + "}",
        dataType: "json",
        success: function (msg) {
            $("#DropMunicipios").html("");
            $.each(msg.d, function (index, item) {
                $("#DropMunicipios").trigger('chosen:updated').append("<option value='" + item.IdMunicipio + "'>" + item.Nombre + "</option>");
            });
            //$("#DropMunicipios").select2().select2("val");
        },
        error: function (msg) {
            msgerror(msg.responseText);
        }
    });
}

$("#DropDepartamento").bind("change blur", function () {
    LlenarMunicipio($(this).val());
});

