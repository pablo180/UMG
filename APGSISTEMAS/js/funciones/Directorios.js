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
                //areas: [{ id: "GT-QC" },
                //    {
                //        id: "GT-ZA",
                //        value: 1
                //    },
                //        {
                //            id: "GT-JU",
                //            value: 2
                //        },
                //        {
                //            id: "GT-JA",
                //            value: 3
                //        },
                //        {
                //            id: "GT-CQ",
                //            value: 4
                //        },
                //        {
                //            id: "GT-IZ",
                //            value: 5
                //        },
                //        {
                //            id: "GT-SR",
                //            value: 6
                //        },
                //        {
                //            id: "GT-PR",
                //            value: 7
                //        },
                //        {
                //            id: "GT-TO",
                //            value: 8
                //        },
                //        {
                //            id: "GT-SO",
                //            value: 9
                //        },
                //        {
                //            id: "GT-SA",
                //            value: 10
                //        },
                //        { id: "GT-SU" },
                //        {
                //            id: "GT-GU",
                //            value: 10,
                //            customData: "1973",
                //        },
                //        { id: "GT-ES" },
                //        { id: "GT-CM" },
                //        { id: "GT-AV" },
                //        { id: "GT-SM" },
                //        { id: "GT-RE" },
                //        { id: "GT-QZ" },
                //        { id: "GT-PE" },
                //        { id: "GT-HU" },
                //        { id: "GT-BV" }]
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
                    "<button type='button' id='" + item.IdDirectorio + "' class='btn btn-default btn-xs BtnEditarCliente'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarCliente'></i> Editar</button>"
                ]);
            });
        },
        error: function (data) {
            console.log(data);
        }
    });
}